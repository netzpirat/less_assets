# LessAssets helper methods to render less css.
#
class window.LessAssets

  # Render less css with its variables to plain css
  #
  # @param [String] css the less css
  # @param [Object] variables the less variables
  #
  @render: (css, variables) ->
    result = undefined

    style = ''
    style += "@#{ variable }: #{ value };\n" for variable, value of variables
    style += css

    less.Parser().parse style, (err, tree) ->
      throw err if err

      result = tree.toCSS()

    result
