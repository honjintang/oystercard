describe "User Stories" do

# In order to use public transport
# As a customer
# I want money on my card

  it "so customer can check balance, return balance" do
    oyster_card = OysterCard.new
    expect(oyster_card).to respond_to(:balance)
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it "so user can add money to their card, add top up functionality" do
    oyster_card = OysterCard.new
    oyster_card.top_up(20)
    expect(oyster_card.balance).to eq(20)
  end

  # In order to protect my money from theft or loss
  # As a customer
  # I want a maximum limit (of £90) on my card

  it 'so users money is safe, limit maximum balance on card to £90' do
    oyster_card = OysterCard.new
    oyster_card.top_up(90)
    expect {oyster_card.top_up(1)}.to raise_error("Cannot top up: maximum balance (£#{OysterCard::MAX_BALANCE}) exceeded")
  end

end
