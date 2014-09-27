Meteor.startup ->
  kramed.options
    katex: true

Template.displayIndex.rendered = ->

  vm = new Vue
    el: '#t-displayIndex'
    data:
      hEditorContent: localStorage.getItem 'lsEditorContent' || '# Make your first hast presentation!'
      hEditorButton: 'saved'
      isDisabled: false
      hPreview: 'loading...'
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
            @hPreview = kramed @hEditorContent
            @saved()
        , 500)
    ready: ->
      @refreshPreview()

  vm.$watch 'hEditorContent', ->
    vm.saving()
    vm.refreshPreview()
