describe "User Stories" do

# In order to use public transport
# As a customer
# I want money on my card

it "so customer can check balance, return balance" do
  oyster = Oyster.new
  expect(oyster).to respond_to(:balance)
end
end
