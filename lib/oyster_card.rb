require_relative "station"
class OysterCard

  public

  MAX_BALANCE = 90
  MIN_BALANCE = 0
  MIN_FARE = 1


  attr_reader :balance, :journeys # :journey
  attr_reader :journey

  def initialize
    @balance = 0
    @journeys = []
    reset_journey
  end

  def top_up(amount_of_money)
    fail "Cannot top up: maximum balance (£#{MAX_BALANCE}) exceeded" if balance_exceeded?(amount_of_money)
    self.balance += amount_of_money
  end

  def in_journey?
    !!journey[:origin_station]
  end

  def touch_in(origin_station)
    fail "Cannot touch in: need at least £1 on card" if minimum_balance_not_on_card?
    fail "Cannot touch in: already in journey" if in_journey?
    reset_journey
    update_origin_station(origin_station)
  end

  def touch_out(exit_station)
    fail "Cannot touch out: not in journey" if !in_journey?
    deduct(MIN_FARE)
    update_exit_station(exit_station)
    self.journeys << journey
    reset_journey
  end

  private


  attr_writer :balance

  def reset_journey
    @journey = {
      origin_station: nil,
      exit_station: nil
    }
  end

  def update_origin_station(origin_station)
    @journey[:origin_station] = origin_station
  end

  def update_exit_station(exit_station)
    @journey[:exit_station] = exit_station
  end

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
