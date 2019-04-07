class VoteBroadcastJob < ApplicationJob
  queue_as :default

  def perform(vote)
    # id = vote.survey_results.id
    binding.pry
    ActionCable.server.broadcast "survey_results_channel", {:vote=>"Vote: #{vote.value}\n"}
  end

end
