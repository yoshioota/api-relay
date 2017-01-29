document.addEventListener 'turbolinks:load', =>
  appName = '#relays-app'
  return unless $(appName)[0]

  window.RelaysApp = new Vue(
    el: appName
    props:
      relays:
        default: undefined

    methods:
      getRelays: () ->
        $.ajax("/relays.json").done( (data) =>
          this.relays = data
        )

    ready: ->
      @getRelays()
  )
