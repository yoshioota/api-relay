document.addEventListener 'turbolinks:load', =>
  appName = '#relays-show-app'
  return unless $(appName)[0]

  window.RelaysShowApp = new Vue(
    el: appName
    props:
      relayId:
        default: undefined

      newBaseUrl:
        default: undefined

      relayDestinations:
        default: undefined

      visibleNewRelayDestinationForm:
        default: false

    methods:
      getRelays: () ->
        $.ajax("/relays.json").done( (data) =>
          this.relays = data
        )

      changeActiveRelayDestination: (relay) ->
        $.ajax("/relays/#{relay.id}.json",
          method: 'PATCH',
          data: { relay: { active_relay_destination_id: relay.active_relay_destination_id }})

      handleCreateSubmit: () ->
        $.ajax("/relays/#{@relayId}/relay_destinations.json",
          method: 'POST',
          data: { relay_destination: {relay_id: @relayId, base_url: @newBaseUrl}})
        .done( () =>
          this.getRelayDestinations()
          this.visibleNewRelayDestinationForm = false
        )

      getRelayDestinations: () ->
        $.ajax("/relays/#{@relayId}/relay_destinations.json")
        .done( (data) =>
          this.relayDestinations = data
        )

      removeRelayDestination: (relayDestination) ->
        $.ajax("/relays/#{@relayId}/relay_destinations/#{relayDestination.id}.json",
          method: 'DELETE'
        ).done( (data) =>
          this.getRelayDestinations()
        )

      newRelayDestinationBtn: ()->
        @visibleNewRelayDestinationForm = !@visibleNewRelayDestinationForm
        if @visibleNewRelayDestinationForm
          setTimeout(() =>
            $('#js-new-base-url').focus()
          , 0)

      editRelayDestination: (relayDestination) ->
        Vue.set(relayDestination, 'visibleRelayDestinaionForm', ! relayDestination.visibleRelayDestinaionForm)

      updateRelayDestination: (relayDestination) ->
        $.ajax("/relays/#{@relayId}/relay_destinations/#{relayDestination.id}.json"
          method: 'PATCH',
          data: { relay_destination: { base_url: relayDestination.base_url }}
        ).done(() =>
          Vue.set(relayDestination, 'visibleRelayDestinaionForm', false)
        )

    ready: ->
      @getRelayDestinations()
  )
