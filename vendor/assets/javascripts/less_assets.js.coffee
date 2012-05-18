# LessAssets helper methods to render less css.
#
class window.LessAssets

  # Render less css with its variables to plain css
  #
  # @param [String] css the less css
  # @param [Object] variables the less variables
  # @param [HTMLDocument] element a target element to add the styles
  # @return [String] the css styles
  #
  @render: (name, css, variables = {}, doc = undefined) ->
    result = undefined
    newVariables = {}

    # Replace existing less variables
    #
    for variable, value of variables
      existing = ///@#{ variable }:\s*[^;]+;///

      if existing.test css
        css = css.replace existing, "@#{ variable }: #{ value };"
      else
        newVariables[variable] = value

    # Add bew less variables
    #
    style = ''
    style += "@#{ variable }: #{ value };\n" for variable, value of newVariables
    style += css

    # Compile the less stylesheet
    #
    less.Parser().parse style, (err, tree) ->
      throw err if err

      result = tree.toCSS()

    # Add a style tag with the css when a document is given
    #
    if doc instanceof HTMLDocument
      id = "less_asset_#{ name.replace(/[^A-Za-z0-1_/-]/, '').replace(/[/-]/, '_') }"

      style = document.getElementById(id) || document.createElement 'style'
      style.type = 'text/css'
      style.id = id

      rules = document.createTextNode result

      if style.styleSheet
        style.styleSheet.cssText = rules.nodeValue
      else
        while style.hasChildNodes()
          style.removeChild style.lastChild

        style.appendChild rules

      head = document.getElementsByTagName('head')[0]
      head.appendChild(style);

    result
