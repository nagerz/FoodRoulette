App.surveys = App.cable.subscriptions.create "ResultChannel",
connected: ->
#functions to do things when we begin and end communication with the server
disconnected: ->

received: (data) ->
# Handle the result

result:   ->
  var surveyId = 1;
  #sets up and id for or dog(passed from the back-end
  #when the connection is first made)
  @perform("result", {id: surveyId})
  #perform is a magic Action Cable command
  #that tells it to send the data(id) to the back-end side
  #of the channel, using the result method.





#set up the front end to make a connection
#with the server
