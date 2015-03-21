module Elominati
  class Game
    attr_reader :players, :calculator

    def initialize(args={})
      @players    = args[:players] || []
      @calculator = Elominati::Calculator.new(
        args.select { |k, _v| Elominati::Calculator.initializable_args[k] }
      )
    end

    def add_player(player)
      @players << player
    end

    def clear_players
      @players = []
    end

    def get_results
      Elominati::Result.new({players: @players, calculator: @calculator}).get_results
    end
  end
end