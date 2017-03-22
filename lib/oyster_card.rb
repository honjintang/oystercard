class OysterCard

  MAX_BALANCE = 90
  MIN_BALANCE = 0
  MIN_FARE = 1


attr_reader :balance, :origin_station

  def initialize
    @balance = 0
    @origin_station = nil
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAX_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def in_journey?
    !!origin_station
  end

  def touch_in(origin_station)

    fail "Cannot touch in: already in journey" if in_journey?
    fail "Cannot touch in: need at least £1 on card" if minimum_balance_not_on_card?
    self.origin_station = origin_station

    self.in_journey = true
  end

  def touch_out
    fail "Cannot touch out: not in journey" if !in_journey?
    deduct(MIN_FARE)
    self.origin_station = nil
    self.in_journey = false
  end

  private

  attr_accessor :in_journey
  attr_writer :balance, :origin_station

  def deduct(amount_of_money)
    fail "Cannot deduct money: insufficient funds" if balance_insufficient?(amount_of_money)
    self.balance -= amount_of_money
  end

  def minimum_balance_not_on_card?
    balance < MIN_FARE
  end

  def balance_exceeded?(amount_of_money)
    (balance + amount_of_money) > MAX_BALANCE
  end

  def balance_insufficient?(amount_of_money)
    balance - amount_of_money < MIN_BALANCE
  end

end
