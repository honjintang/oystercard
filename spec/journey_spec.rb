require 'journey'

describe Journey do

  let (:origin_station) { double(:origin_station, :name => "Aldgate") }
  let (:journey) { described_class.new(origin_station) }
  let (:oyster_card) { double(:oyster_card) }

  let (:exit_station) { double(:exit_station) }

  describe "#in_journey?" do

    it 'returns false if card is not in journey' do
      expect(journey).not_to be_in_journey
    end
  end

  describe "#update origin station" do

    it "saves the origin station when it touches in" do
      allow(origin_station).to receive(:name) {"Aldgate"}
      journey.update_origin_station(origin_station)
      expect(journey.current_journey[:origin_station]).to eq(origin_station.name)
    end
  end

  describe "#update exit station" do

    it "saves the exit station when it touches out" do
      allow(exit_station).to receive(:name) {"London Bridge"}
      journey.update_exit_station(exit_station)
      expect(journey.current_journey[:exit_station]).to eq(exit_station.name)
    end
  end


end
