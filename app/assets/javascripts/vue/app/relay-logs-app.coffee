document.addEventListener 'turbolinks:load', =>
  appName = '#relay-logs-app'
  return unless $(appName)[0]

  window.RelayLogsApp = new Vue(
    el: appName
    props:
      relayId:
        default: undefined

      relayLogs:
        default: undefined

    methods:
      getRelayLogs: (relayId) ->
        $.ajax(url: "/relays/#{@relayId}/relay_logs.json").done( (data) =>
          this.relayLogs = data
        )

      selectRelayLogHeader: (relayLogDetail) ->
        Vue.set(relayLogDetail, 'visible', !relayLogDetail.visible)

      addRelayLog: (redayLogJSON) ->
        @relayLogs.unshift(redayLogJSON)


      responseLabelClass: (relayLog) ->
        status = parseInt(relayLog.response_status)
        if status < 200 then 'label-info'
        else if status < 300 then 'label-success'
        else if status < 400 then 'label-warning'
        else if status < 500 then 'label-danger'
        else if status < 999 then 'label-danger2'
        else 'label-default'

    ready: ->
      new RelayLog(@relayId)
      @getRelayLogs(@relayId)
  )
