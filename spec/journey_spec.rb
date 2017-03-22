require 'journey'

describe Journey do

  let (:journey) { described_class.new }
  let (:oyster_card) { double(:oyster_card) }
  let (:origin_station) { double(:origin_station) }
  let (:exit_station) { double(:exit_station) }

  describe "#in_journey?" do

    it 'returns false if card is not in journey' do
      expect(journey).not_to be_in_journey
    end
  end

  describe "#update origin station" do

    it "saves the origin station when it touches in" do
      journey.update_origin_station(origin_station)
      expect(journey.current_journey[:origin_station]).to eq(origin_station)
    end
  end

  describe "#update exit station" do

    it "saves the exit station when it touches out" do
      journey.update_exit_station(exit_station)
      expect(journey.current_journey[:exit_station]).to eq(exit_station)
    end
  end


end
