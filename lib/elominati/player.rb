module Elominati
  class Player
    attr_reader :id, :rating, :provisional, :score

    def initialize(args)
      args = defaults.merge(args)

      @id          = args[:id]
      @rating      = args[:rating]
      @provisional = args[:provisional]
      @score       = args[:score]
    end

    def provisional?
      !!@provisional
    end

    def defaults
      {
        provisional: false,
        rating: 1200
      }
    end
  end
end