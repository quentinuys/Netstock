class RankController < ApplicationController


    def initialize(hash_params)
        @player_one_id = hash_params[0]["player_one"]
        @player_two_id = hash_params[0]["player_two"]
        @winner_id = hash_params[0]["winner"]
    end

    def perform
        rank_players
    end

    def higher_rank 
        player_one.rank < player_two.rank ? player_one : player_two
    end

    def lower_rank 
        player_one.rank > player_two.rank ? player_one : player_two
    end

    def winner
        return nil if @winner_id.to_i < 1
        @winner ||= Member.find(@winner_id)
    end

    def player_one
        @player_one ||= Member.find(@player_one_id)
    end

    def player_two
        @player_two ||= Member.find(@player_two_id)
    end

    def rank_players
        new_lower_rank = lower_rank.rank
        new_higher_rank = higher_rank.rank

        if !winner
            if higher_rank.rank - 1 < lower_rank.rank
                new_lower_rank = lower_rank.rank - 1
            end

        elsif winner == lower_rank
            rank_difference = lower_rank.rank - higher_rank.rank
            new_lower_rank = lower_rank.rank - (rank_difference / 2).to_i
            new_higher_rank = higher_rank.rank + 1
        else
            return
        end
        rank_down(new_higher_rank, new_lower_rank)
    end

    def rank_down new_higher_rank, new_lower_rank
        lower_ranking = Member.where("rank >= ?", new_higher_rank).order("rank")
        ranking_index = new_higher_rank
        higher_rank.update("games_played = games_played + 1 AND rank = ?", new_higher_rank)
        lower_ranking.each do |lower_member|
            ranking_index += 1
            if(ranking_index == new_lower_rank)
                lower_rank.update("games_played = games_played + 1 AND rank = ?", ranking_index)
                ranking_index +=1
            end
            
            lower_member.update(rank: ranking_index)
        end
    end

end
