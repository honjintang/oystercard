class OysterCard
  attr_reader :balance
  MAX_BALANCE = 90
  MIN_BALANCE = 0
  def initialize
    @balance = 0
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAX_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end


  def deduct(amount_of_money)
    fail "Cannot deduct money: insufficient funds" if balance_insufficient?(amount_of_money)
    self.balance -= amount_of_money
  end



  private

  attr_writer :balance

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAX_BALANCE
  end

  def balance_insufficient?(amount_of_money)
    balance - amount_of_money < MIN_BALANCE
  end

end
