class ApplyRankJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ranking = RankController.new(args)
    ranking.perform
  end
end
