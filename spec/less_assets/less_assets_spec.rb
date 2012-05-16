require 'spec_helper'

describe LessAssets::LessTemplate do

  let(:template) do
    LessAssets::LessTemplate.new('/Users/tester/projects/less_assets/styles/template.lesst', line=1, options={}) do
      <<-TMPL
  h1 { margin: 10px; }
  h2 { margin: 20px; }
      TMPL
    end
  end

  let(:scope) do
    double(logical_path: 'styles/template')
  end

  before do
    LessAssets::LessTemplate.namespace = 'window.JSST'
    LessAssets::LessTemplate.name_filter = lambda { |n| n.sub /^(templates|styles|stylesheets)\//, '' }
  end

  describe "#evaluate" do
    context 'with defaults' do
      it 'uses the provided template name' do
        template.render(scope).should eql <<-TEMPLATE
(function() {
  window.JSST || (window.JSST = {});
  window.JSST['template'] = function(v) { return LessAssets.render(\"  h1 { margin: 10px; }\\n  h2 { margin: 20px; }\\n\", v); };\n}).call(this);
        TEMPLATE
      end
    end

    context 'when changing the namespace' do
      before do
        LessAssets::LessTemplate.namespace = 'window.STYLES'
      end

      it 'uses the provided template name' do
        template.render(scope).should eql <<-TEMPLATE
(function() {
  window.STYLES || (window.STYLES = {});
  window.STYLES['template'] = function(v) { return LessAssets.render(\"  h1 { margin: 10px; }\\n  h2 { margin: 20px; }\\n\", v); };\n}).call(this);
        TEMPLATE
      end
    end

    context 'when changing the name filter' do
      before do
        LessAssets::LessTemplate.name_filter = lambda { |n| n }
      end

      it 'uses the provided template name' do
        template.render(scope).should eql <<-TEMPLATE
(function() {
  window.JSST || (window.JSST = {});
  window.JSST['styles/template'] = function(v) { return LessAssets.render(\"  h1 { margin: 10px; }\\n  h2 { margin: 20px; }\\n\", v); };\n}).call(this);
        TEMPLATE
      end
    end
  end
end
