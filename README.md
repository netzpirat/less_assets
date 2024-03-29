# Less Assets [![Build Status](https://secure.travis-ci.org/netzpirat/less_assets.png)](http://travis-ci.org/netzpirat/less_assets)

[Less](http://lesscss.org/) JavaScript Style Templates (JSST) in the Rails asset pipeline or as Tilt template.
It's like a JavaScript template, but for generating dynamic CSS styles instead of HTML.

If you just want to render your Less stylesheets in the Rails backend and deliver the CSS through the asset pipeline,
have a look at [Less Rails](https://github.com/metaskills/less-rails).

Tested on MRI Ruby 1.8.7, 1.9.2, 1.9.3, REE and the latest version of JRuby.

## Why a Style template?
 
Why would you like to have JavaScript Style Templates? If you have a lot of domain models that describes a UI, you can
convert them dynamically to CSS and have nice style logic in the template instead of code that manipulates the DOM
style attributes.

I also wrote a JavaScript Style Template for [Stylus](https://github.com/learnboost/stylus), see
[Stylus_Assets](https://github.com/netzpirat/stylus_assets).

## Installation

The simplest way to install Less Assets is to use [Bundler](http://gembundler.com/).
Add `less_assets` to your `Gemfile`:

```ruby
group :assets do
  gem 'less_assets'
end
```

And require the `less` and `less_assets` in your `app/assets/javascripts/application.js.coffee`:

```coffeescript
#= require less
#= require less_assets
```

This provides the less.js parser to parse your stylesheets in the browser and the LessAssets renderer for adding the
variables at render time.

Please have a look at the [CHANGELOG](https://github.com/netzpirat/less_assets/blob/master/CHANGELOG.md) when
upgrading to a newer Less Assets version.

## Usage

You can place all your Less templates in the `app/assets/javascripts/styles` directory and include them from your
`app/assets/javascripts/application.js.coffee`:

```coffeescript
#= require_tree ./styles
```

Because Less Assets provides a default template name filter, the `styles/`, `stylesheet/` and `templates/` prefix will
be automatically removed.

## Configuration

Sprockets will cache your templates after compiling and will only recompile them when the content of the template has
changed, thus if you change to your configuration, the new settings will not be applied to templates already compiled.
You can clear the Sprockets cache with:

```Bash
rake assets:clean
```

### Template namespace

By default all Less templates are registered under the `JSST` namespace, which stands for JavaScript style template.
If you prefer another namespace, you can set it in an initializer:

```ruby
LessAssets::LessTemplate.namespace = `window.Styles`
```

### Template name

The name under which the template can be addressed in the namespace depends not only from the filename, but also on
the directory name by default.

The following examples assumes a configured namespace `window.JSST` and the asset template directory
`app/assets/javascripts/styles`:

* `app/assets/javascripts/styles/document.lesst` will become `JSST['document']`
* `app/assets/javascripts/styles/editor/zone.lesst` will become `JSST['editor/zone']`
* `app/assets/javascripts/styles/shared/general/headers.lesst` will become `JSST['shared/general/headers']`

#### Template name filter

If you wish to put the templates in a different location, you may want to modify `name_filter` in an initializer.

```ruby
LessAssets::LessTemplate.name_filter = lambda { |n| n.sub /^(templates|styles|stylesheets)\//, '' }
```

By default, `name_filter` strips the leading `templates/`, `stylesheets/` and `styles/` directory off of the name.

## Render

When you have a template named `header` with the given content:

```SCSS
.header (@r) {
    padding: @r * 2;
    border-radius: @r;
}

.header (@r) when (@r > 10) {
    margin-top: 3 * @r;
}

#header {
    .header(@radius);
}
```

You can render the style template and pass the variables to be used:

```javascript
JSST['header']({ radius: '10px' })
```

which will return in the following CSS

```CSS
#header {
  margin: 20px;
  border-radius: 10px;
}
```

whereas rendering

```JavaScript
JSST['header']({ radius: '20px' })
```

will result in

```CSS
#header {
  padding: 40px;
  border-radius: 20px;
  margin-top: 60px;
}
```

### Default variables

You do not need to define the variables in the less stylesheet, as they will be created before compilation, but you
may want to have them added to provide default variables.

Given the following style template named `box`

```SCSS
@box-margin: 10px;
@box-padding: 10px;

.box {
  margin: @box-margin;
  padding: @box-padding;
}
```

Rendered with only some of the variables passed to the template

```JavaScript
JSST['box']({ 'box-margin': '20px' })
```

will use the default values that results in

```CSS
.box {
  margin: 20px;
  padding: 10px;
}
```

### Applying the styles to a document

You can let Less Assets to manage the styles on a HTML document by passing the document to the style template.

Given the following Less style template named `divider`:

```CSS
div {
  margin-top: @m;
}
```

that is compiled with

```JavaScript
JSST['divider']({ m: '20px' }, document)
```

will create a new style tag in the head of the document:

```HTML
<style id="less_asset_divider">
  div {
    margin-top: 20px;
  }
</style>
```

Re-render the same style template again with other variables will replace the existing styles with the new ones.

## Author

Developed by Michael Kessler, [mksoft.ch](https://mksoft.ch).

If you like Less Assets, you can watch the repository at [GitHub](https://github.com/netzpirat/less_assets) and
follow [@netzpirat](https://twitter.com/#!/netzpirat) on Twitter for project updates.

## Development

* Issues and feature request hosted at [GitHub Issues](https://github.com/netzpirat/less_assets/issues).
* Documentation hosted at [RubyDoc](http://rubydoc.info/github/netzpirat/less_assets/master/frames).
* Source hosted at [GitHub](https://github.com/netzpirat/less_assets).

Pull requests are very welcome! Please try to follow these simple rules if applicable:

* Please create a topic branch for every separate change you make.
* Make sure your patches are well tested. All specs must pass.
* Update the [Yard](http://yardoc.org/) documentation.
* Update the README.
* Update the CHANGELOG for noteworthy changes.
* Please **do not change** the version number.

## Contributors

See the [CHANGELOG](https://github.com/netzpirat/less_assets/blob/master/CHANGELOG.md) and the GitHub list of
[contributors](https://github.com/netzpirat/less_assets/contributors).

## Acknowledgement

* [Alexis Sellier](http://twitter.com/cloudhead) for creating Less, the dynamic stylesheet language.

## License

(The MIT License)

Copyright (c) 2012 Michael Kessler

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
