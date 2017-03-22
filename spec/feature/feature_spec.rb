require "oyster_card"
describe "User Stories" do

let(:station) {double(:station)}
let(:oyster_card) { OysterCard.new }
max_balance = OysterCard::MAX_BALANCE
min_balance = OysterCard::MIN_BALANCE
min_fare =    OysterCard::MIN_FARE
# In order to use public transport
# As a customer
# I want money on my card

  it "so customer can check balance, return balance" do
    expect(oyster_card).to respond_to(:balance)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it "so user can add money to their card, add top up functionality" do
    oyster_card.top_up(max_balance)
    expect(oyster_card.balance).to eq(max_balance)
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card

  it 'so users money is safe, limit maximum balance on card to £90' do
    oyster_card.top_up(max_balance)
    expect {oyster_card.top_up(min_fare)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAX_BALANCE}) exceeded")
  end

  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

  # it "so user can spend money, allow transactions to occur until there is £0 card balance" do
  #     oyster_card.top_up(min_fare)
  #     oyster_card.touch_in(station)
  #     oyster_card.touch_out
  #     oyster_card.touch_in(station)
  #     expect { oyster_card.touch_out }.to raise_error("Cannot deduct money: insufficient funds")
  #
  # end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  it 'so the user can pass the barriers, they need to be able to touch in and out' do
    oyster_card.top_up(max_balance)
    expect(oyster_card).not_to be_in_journey
    oyster_card.touch_in(station)
    expect(oyster_card).to be_in_journey
    oyster_card.touch_out
    expect(oyster_card).not_to be_in_journey
  end

  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount (£1) for a single journey.

  it "so the user can't travel without minimum fare, restrict entry if less than £1 on card" do
    expect{ oyster_card.touch_in(station) }.to raise_error("Cannot touch in: need at least £1 on card")
  end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card

  it "so the user can pay for journey, deduct correct fare from balance when touching out" do
    oyster_card.top_up(max_balance)
    oyster_card.touch_in(station)
    expect{ oyster_card.touch_out }.to change{ oyster_card.balance }.by(-1)

  end

  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from

  it "so the user can be charged correctly, store the origin station on the card" do
    oyster_card.top_up(max_balance)
    oyster_card.touch_in("Aldgate")
    expect(oyster_card.origin_station).to eq("Aldgate")
    oyster_card.touch_out
    expect(oyster_card.origin_station).to eq(nil)

  end


end
