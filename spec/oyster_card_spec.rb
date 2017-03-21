require 'oyster_card'

describe OysterCard do
  subject(:oyster_card) {described_class.new}

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
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq(20)
    end

    it 'expects to top_up to add amount to existing balance' do
      oyster_card.top_up(20)
      oyster_card.top_up(20)
      expect(oyster_card.balance).to eq (40)
    end
  end


end
