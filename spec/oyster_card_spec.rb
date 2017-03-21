require 'oystercard'

describe OysterCard do
  subject(:oyster_card) {described_class.new}

  it 'responds to balance enquiry' do
    expect(oyster_card).to respond_to(:balance)
  end

  it "new instance has zero balance by default" do
    expect(oyster_card.balance).to eq(0)
  end

end
