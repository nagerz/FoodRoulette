class VoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(vote)
    # total_votes = Vote.total_votes(vote)
    # survey_restaurant_vote = Vote.survey_restaurant_votes(vote)
    total_votes = 6
    sr_1_votes = 1
    sr_2_votes = 2
    sr_3_votes = 3
    ActionCable.server.broadcast 'survey_results_channel', vote: render_vote(total_votes,
                                                                             sr_1_votes,
                                                                             sr_2_votes,
                                                                             sr_3_votes)
  end

  private

  def render_vote(total_votes, sr_1_votes, sr_2_votes, sr_3_votes)
    ApplicationController.renderer.render(partial: 'votes/vote', locals: {vote: total_votes})
  end
end
