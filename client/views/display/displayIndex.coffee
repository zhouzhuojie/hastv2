Template.displayIndex.rendered = ->
  self = @
  self.$('#editor-input').keyup _.debounce(
    ->
      preview = self.$('#preview').html(kramed(@value))
      _.each $('#preview script[type="math/tex"]'), (mathTag) ->
        mathTag = $(mathTag)
        content = mathTag.html()
        mathTag?.replaceWith(katex.renderToString(content))
      _.each $('#preview script[type="math/tex; mode=display"]'), (mathTag) ->
        mathTag = $(mathTag)
        content = mathTag.html()
        mathTag?.replaceWith(katex.renderToString(content))
    , 500)
