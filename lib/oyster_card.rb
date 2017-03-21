class OysterCard
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount_of_money)
    fail 'Cannot top up: maximum balance exceeded' if invalid_top_up?(amount_of_money)
    self.balance += amount_of_money
  end

  def invalid_top_up?(amount_of_money)
    new_balance = balance + amount_of_money
    new_balance > 90
  end

private

attr_writer :balance



end
