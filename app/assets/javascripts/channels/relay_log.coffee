class RelayLog
  constructor: (@relayId) ->
    App.relay_log = App.cable.subscriptions.create { channel: "RelayLogChannel", relay_id: @relayId},
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        window.RelayLogsApp.addRelayLog(JSON.parse(data))

window.RelayLog ||= RelayLog
