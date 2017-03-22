require 'oyster_card'

max_balance = OysterCard::MAX_BALANCE
min_balance = OysterCard::MIN_BALANCE
min_fare =    OysterCard::MIN_FARE

describe OysterCard do
  subject(:oyster_card) {described_class.new}
  let(:origin_station) {double(:origin_station)}
  let(:exit_station) {double(:exit_station)}

  describe "#initialize" do
    it "Has an empty list of journeys as default" do
      expect(oyster_card.journeys).to be_empty
    end
  end

  describe '#balance' do
  it 'responds to balance enquiry' do
    expect(oyster_card).to respond_to(:balance)
  end

  it "new instance has zero balance by default" do
    expect(oyster_card.balance).to eq(0)
  end

    end

  describe '#top_up' do

    it 'expects to receive top_up with an argument and update balance' do
      oyster_card.top_up(max_balance)
      expect(oyster_card.balance).to eq(max_balance)
    end

    it 'expects to top_up to add amount to existing balance' do
      oyster_card.top_up(20)
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq (40)
    end

    it 'expects top up after maximum balance reached to return error' do
      expect {oyster_card.top_up(max_balance + 5)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAX_BALANCE}) exceeded")
    end

  end

  # MOVED TO PRIVATE
  # describe "#deduct" do
  #
  #   # it "expects deduct to remove the specificied amount from balance" do
  #   #   oyster_card.top_up(20)
  #   #   oyster_card.deduct(10)
  #   #   expect(oyster_card.balance).to eq(10)
  #   # end
  #
  #   it "raises exception when user tries to deduct a greater amount of money than is on the card balance" do
  #     expect { oyster_card.deduct(10) }.to raise_error("Cannot deduct money: insufficient funds")
  #   end
  #
  # end

  # NOW PRIVATE
  # describe "#balance_insufficient?" do
  #
  #   it "returns true when amount to be deducted is more than current balance" do
  #     allow(oyster_card).to receive(:balance) {20}
  #     # oyster_card.top_up(20)
  #     expect(oyster_card.balance_insufficient?(25)).to eq(true)
  #   end
  #
  # end

  describe "#in_journey?" do

    it 'returns false if card is not in journey' do
      expect(oyster_card).not_to be_in_journey
    end

  end

  describe "#touch_in" do


    it 'should return in_journey? as true after oyster has called touch_in' do
      allow(oyster_card).to receive(:balance) {max_balance}
      oyster_card.touch_in(origin_station)
      expect(oyster_card).to be_in_journey
    end

    it "raise exception when trying to touch_in twice" do
      allow(oyster_card).to receive(:balance) {max_balance}
      oyster_card.touch_in(origin_station)
      expect { oyster_card.touch_in(origin_station) }.to raise_error("Cannot touch in: already in journey")

    end

    it "raises excepetion when less than minimum_fare on card" do
      expect {oyster_card.touch_in(origin_station) }.to raise_error("Cannot touch in: need at least £1 on card")
    end

    it "saves the origin station when it touches in" do
      allow(oyster_card).to receive(:balance) {max_balance}
      oyster_card.touch_in(origin_station)
      expect(oyster_card.journey[:origin_station]).to eq(origin_station)
    end

  end

  describe "#touch_out" do

    it 'should return in_journey as false after oyster on a journey calls touch_out' do

      allow(oyster_card).to receive(:balance) {max_balance}
      oyster_card.touch_in(origin_station)
      oyster_card.touch_out(exit_station)
      expect(oyster_card).not_to be_in_journey
    end

    it "raise exception when trying to touch_out twice" do
      expect { oyster_card.touch_out(exit_station) }.to raise_error("Cannot touch out: not in journey")
    end

    it "deducts fare from balance after touch_out" do
      oyster_card.top_up(max_balance)
      oyster_card.touch_in(origin_station)
      expect { oyster_card.touch_out(exit_station) }.to change{ oyster_card.balance}.by(-1)
    end

    it "wipes origin station after successful touch out" do
      allow(oyster_card).to receive(:balance) {max_balance}
      oyster_card.touch_in(origin_station)
      oyster_card.touch_out(exit_station)
      expect(oyster_card.journey[:origin_station]).to eq(nil)

    end

    it "saves the exit station when it touches out" do
      allow(oyster_card).to receive(:balance) {max_balance}
      oyster_card.touch_in(origin_station)
      oyster_card.touch_out(exit_station)
      expect(oyster_card.journeys.first[:exit_station]).to eq(exit_station)
    end

    it "saves the origin_station and exit_station in a hash" do




    end


  end


end
