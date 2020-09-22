class MatchController < ApplicationController

    def index
        @players = nil
        if Member.all.count > 1
            @players = Member.all
        end
    end
    def rank
        ApplyRankJob.perform_now(match_params)
    end
    
    def match_params
        params.permit(:player_one, :player_two, :winner)
    end
end
