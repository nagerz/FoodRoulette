App.survey_results = App.cable.subscriptions.create "SurveyResultsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#votes').append data['vote']

  vote: (vote_value) ->
    @perform 'vote', vote_value: vote_value

  $(document).on 'keypress', '[data-behavior~=survey_results_voter]', (event) ->
    if event.keyCode is 13 #return = send
      App.survey_results.vote event.target.value
      event.target.value = ''
      event.preventDefault()
