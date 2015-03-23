require 'spec_helper'

module Elominati
  describe Calculator do
    let(:provisional) do
      Elominati::Player.new({
        provisional: true,
        rating: 1200,
        score: 45,
        id: 'Player1'
      })
    end

    let(:expert) do
      Elominati::Player.new({
        rating: 2500,
        score: 52,
        id: 'Player2'
      })
    end

    let(:vanilla) do
      Elominati::Player.new({
        rating: 1300,
        score: 45,
        id: 'Player3'
      })
    end

    let(:almost_expert) do
      Elominati::Player.new({
        rating: 2300,
        score: 49,
        id: 'Player4'
      })
    end

    subject(:calculator) { Elominati::Calculator.new() }

    context "when creating a Calculator with no args" do
      it "has a k_value of 20" do
        expect(calculator.k_value).to eql 20
      end

      it "has a provisional_k_value of 40" do
        expect(calculator.provisional_k_value).to eq 40
      end

      it "has an expert_k_value of 10" do
        expect(calculator.expert_k_value).to eq 10
      end

      it "has an expert_threshold of 2400" do
        expect(calculator.expert_threshold).to eq 2400
      end
    end

    context "when creating a Calculator specifying all attributes" do
      subject(:custom_calculator) do
        Elominati::Calculator.new({
          provisional_k_value: 50,
          expert_threshold:    3000,
          expert_k_value:      15,
          k_value:             25
        })
      end

      it "has a k_value of 25" do
        expect(custom_calculator.k_value).to eql 25
      end

      it "has a provisional_k_value of 50" do
        expect(custom_calculator.provisional_k_value).to eq 50
      end

      it "has an expert_k_value of 15" do
        expect(custom_calculator.expert_k_value).to eq 15
      end

      it "has an expert_threshold of 3000" do
        expect(custom_calculator.expert_threshold).to eq 3000
      end
    end

    context "when determining which k value to use" do
      it "will use the standard k value when the primary player " +
         "is not provisional and is not an expect" do
          expect(calculator.determine_k_value(vanilla)).to eq calculator.k_value
      end

      it "will use the provisional k value when the player is provisional" do
        expect(calculator.determine_k_value(provisional)).to eq calculator.provisional_k_value
      end

      it "will use the expert k value when the player is an expert" do
        expect(calculator.determine_k_value(expert)).to eq calculator.expert_k_value
      end
    end

    context "when calculating the expected score" do
      it "will calculate the correct value when the primary " +
         "player's rating is greater than the opponent's" do
        expect(
          calculator.determine_expected_score(
            vanilla, provisional
          )
        ).to be_within(0.001).of(0.6400)
      end
    end

    context "when determining the actual score" do
      it "will give the priamry player a win when her score is " +
         "greater than her opponents'" do
          expect(calculator.determine_actual_score(expert, vanilla)).to eq 1
      end

      it "will give the priamry player a loss when her score is " +
         "loss than her opponents'" do
          expect(calculator.determine_actual_score(vanilla, expert)).to eq 0
      end

      it "will give the priamry player a draw when her score is " +
         "the same as her opponents'" do
          expect(calculator.determine_actual_score(provisional, vanilla)).to eql 0.5
      end
    end

    context "when calculating a new rating" do
      it "gets the correct rating when the priamry player is an expert" do
        expect(calculator.get_new_rating(expert, almost_expert)).to eq 2502
      end

      it "will calculate new ratings for provisional players correctly" do
        expect(calculator.get_new_rating(provisional, vanilla)).to eq 1205
      end
    end
  end
end