require 'spec_helper'

module Elominati
  describe Player do

    context "when creating a new player" do
      subject(:player)  { Elominati::Player.new({}) }

      it "has a default rating of 1200" do
        expect(player.rating).to eq 1200
      end

      it "is not a provisional player" do
        expect(player.provisional?).to be false
      end
    end

    context "when creating a new player specifying all attributes" do
      subject(:player) do
        Elominati::Player.new({
          provisional: true,
          rating: 1350,
          score: 54,
          id: 'Chris'
        })
      end

      it "has an id" do
        expect(player.id).to eq 'Chris'
      end

      it "has the specified rating" do
        expect(player.rating).to eq 1350
      end

      it "has a score" do
        expect(player.score).to eq 54
      end

      it "is a provisionally rated" do
        expect(player.provisional?).to be true
      end
    end
  end
end
