require 'oyster'

describe Oyster do
  subject(:oyster) {described_class.new}

  it 'responds to balance enquiry' do
    expect(oyster).to respond_to(:balance)
  end

  it "new instance has zero balance by default" do
    expect(oyster.balance).to eq(0)
  end

end
