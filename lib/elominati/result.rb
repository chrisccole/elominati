module Elominati
  class Result

    def initialize(args)
      @calculator = args[:calculator]
      @players    = args[:players]
      @results    = []
    end

    def get_results
      # Compare every player involved in the game to each other player
      # Essentially calculates new ELO as if it were a round robin
      # With wins / losses based on placement (based on player.score)
      @players.each do |player|
        delta_sum = 0

        @players.each do |opponent|
          next if player == opponent

          new_rating = @calculator.get_new_rating(player, opponent)
          delta_sum += new_rating - player.rating
        end

        @results << result_hash(player, delta_sum)
      end

      @results
    end

    def result_hash(player, delta_sum)
      {
        rating: player.rating + delta_sum,
        delta:  delta_sum >= 0 ? "+#{delta_sum}" : delta_sum,
        id:     player.id
      }
    end
  end
end