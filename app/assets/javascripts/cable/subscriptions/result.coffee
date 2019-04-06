App.cable.subscriptions.create { channel: "ResultChannel", room: "Results Room" },
  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("[data-results-room='Results Room']").append(html)

  createLine: (data) ->
    """
    <article class="result-line">
      <span class="speaker">#{data["sent_by"]}</span>
      <span class="body">#{data["body"]}</span>
    </article>
    """
