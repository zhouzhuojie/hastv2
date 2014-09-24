
Template.displayIndex.rendered = ->

  vm = new Vue
    el: '#t-displayIndex'
    data:
      hEditorContent: localStorage.getItem 'lsEditorContent' || '# Make your first hast presentation!'
      hEditorButton: 'saved'
      isDisabled: false
    methods:
      saving: ->
        @isDisabled = true
        @hEditorButton = 'saving...'
      saved: ->
        @isDisabled = false
        @hEditorButton = 'saved'
      refreshPreview: _.debounce(
        ->
          if @hEditorContent?
            htmlString = kramed @hEditorContent
            localStorage.setItem 'lsEditorContent', @hEditorContent
            $preview = $('.h-Preview-preview').html(htmlString)
            _.each $preview.find('script[type="math/tex"]'), (mathTag) ->
              mathTag = $(mathTag)
              content = mathTag.html()
              mathTag?.replaceWith(katex.renderToString(content))
            _.each $preview.find('script[type="math/tex; mode=display"]'), (mathTag) ->
              mathTag = $(mathTag)
              content = mathTag.html()
              mathTag?.replaceWith("<div class='u-center'>#{katex.renderToString(content)}<div>")
            @saved()
        , 500)
    ready: ->
      @refreshPreview()

  vm.$watch 'hEditorContent', ->
    vm.saving()
    vm.refreshPreview()
