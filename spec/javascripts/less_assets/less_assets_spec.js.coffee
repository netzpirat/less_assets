describe 'LessAssets', ->
  describe '#render', ->
    describe 'a less stylesheet', ->
      beforeEach ->
        @result = LessAssets.render 'template', '''
          #header {
            #logo {
              margin: 10px;
            }
          }
        '''

      it 'renders the less style sheet to css', ->
        expect(@result).toEqual '''
          #header #logo {
            margin: 10px;
          }

        '''

    describe 'when passing variables', ->
      describe 'for variables that does not exist', ->
        beforeEach ->
          @result = LessAssets.render 'template', '''
            #logo {
              border-radius: @radius;
            }
          ''', { radius: '10px' }

        it 'adds the variable', ->
          expect(@result).toEqual '''
            #logo {
              border-radius: 10px;
            }

          '''

      describe 'for variables that does exist', ->
        beforeEach ->
          @result = LessAssets.render 'template', '''
            @box-margin: 10px;
            @box-padding: 10px;

            .box {
              margin: @box-margin;
              padding: @box-padding;
            }
          ''', { 'box-margin': '20px' }

        it 'replaces the existing variable', ->
          expect(@result).toEqual '''
            .box {
              margin: 20px;
              padding: 10px;
            }

          '''

    describe 'when passing an HTML element', ->
      describe 'for a non existing style', ->
        beforeEach ->
          LessAssets.render 'template/head', '''
            #logo {
              border-radius: 5px;
            }
          ''', { }, document

        afterEach -> $('#less_asset_template_head').remove()

        it 'creates a script tag', ->
          expect($(document)).toContain 'style#less_asset_template_head'

        it 'adds the css to the tag', ->
          expect($('#less_asset_template_head').text()).toEqual '''
            #logo {
              border-radius: 5px;
            }

          '''

      describe 'for an existing style', ->
        beforeEach ->
          $(document).find('head').append '<style id="less_asset_template_head">div { padding: 1px; }</style>'
          LessAssets.render 'template/head', '''
            div {
              padding: 5px;
            }
          ''', { }, document

        afterEach -> $('#less_asset_template_head').remove()

        it 'replaces the css in the tag', ->
          expect($('#less_asset_template_head').text()).toEqual '''
            div {
              padding: 5px;
            }

          '''
