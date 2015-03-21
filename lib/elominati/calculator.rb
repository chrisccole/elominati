module Elominati
  class Calculator
    attr_accessor :k_value, :expert_threshold, :expert_k_value, :provisional_k_value

    def initialize(args={})
      args  = defaults.merge(args)

      @provisional_k_value = args[:provisional_k_value]
      @expert_threshold    = args[:expert_threshold]
      @expert_k_value      = args[:expert_k_value]
      @k_value             = args[:k_value]
    end

    def defaults
      {
        provisional_k_value: 40,
        expert_threshold:    2400,
        expert_k_value:      10,
        k_value:             20
      }
    end

    def get_new_rating(primary_player, opponent)
      k              = determine_k_value(primary_player)
      expected_score = determine_expected_score(primary_player, opponent)
      actual_score   = determine_actual_score(primary_player, opponent)

      primary_player.rating + k * (actual_score - expected_score)
    end

    def determine_actual_score(primary_player, opponent)
      if primary_player.score > opponent.score
        1
      elsif opponent.score > primary_player.score
        0
      else
        0.5
      end
    end

    def determine_expected_score(primary_player, opponent)
      exponent    = (opponent.rating - primary_player.rating) / 400;
      denominator = 1 + 10 ** exponent

      1 / denominator
    end

    def determine_k_value(primary_player)
      if primary_player.provisional?
        @provisional_k_value
      elsif primary_player.rating >= @expert_threshold
        @expert_k_value
      else
        @k_value
      end
    end

    def self.initializable_args
      {
        provisional_k_value: true,
        expert_threshold:    true,
        expert_k_value:      true,
        k_value:             true
      }
    end
  end
end