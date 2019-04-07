class VoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(vote)
    ActionCable.server.broadcast 'survey_results_channel', vote: render_vote(vote)
  end

  private

  def render_vote(vote)
    ApplicationController.renderer.render(partial: 'votes/vote', locals: { vote: vote })
  end
end
