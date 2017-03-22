class Journey

  attr_reader :current_journey

  def initialize
    reset
  end

  def reset
    @current_journey = {
      origin_station: nil,
      exit_station: nil
    }
  end

  def update_origin_station(origin_station)
    @current_journey[:origin_station] = origin_station
  end

  def update_exit_station(exit_station)
    @current_journey[:exit_station] = exit_station
  end

  def in_journey?
    !!current_journey[:origin_station]
  end

end
