class Plane

  def initialize(airport)
    @airport = airport
  end

  def parked_at?(airport)
    @airport == airport
  end

  def taxi_to_runway
    @airport.move_to_runway(self)
  end

end