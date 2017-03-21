class OysterCard
  attr_reader :balance
  MAX_BALANCE = 90
  def initialize
    @balance = 0
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAX_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def balance_exceeded?(amount_of_money)
  (balance + amount_of_money) > MAX_BALANCE
  end

private

attr_writer :balance



end
