class Journey

  attr_reader :journey_info

  def initialize(origin_station)
    @journey_info = {
      origin_station: origin_station.name,
      exit_station: nil
    }
  end

  def update_origin_station(origin_station)
    @journey_info[:origin_station] = origin_station.name
  end

  def update_exit_station(exit_station)
    @journey_info[:exit_station] = exit_station.name
  end

  def in_journey?
    !!current_journey[:exit_station]
  end

end
