class Plane

  def initialize(airport)
    @airport = airport
  end

  def parked_at?(airport)
    @airport == airport
  end

end