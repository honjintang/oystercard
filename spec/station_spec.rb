require 'station'

describe Station do

  subject(:station) { described_class.new("Aldgate", 2) }

  it "station has a name" do
    expect(station.name).to eq "Aldgate"
  end

  it "station has a zone" do
    expect(station.zone).to eq 2
  end
end
