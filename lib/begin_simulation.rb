require_relative 'airport'
require_relative 'weather'

class Begin_sim

  attr_reader :airports

  def initialize(no_of_airports=1)
    @airports = []
    no_of_airports.times { @airports << standard_airport }
  end

  def standard_airport
    Airport.new(5, 10, Weather.new)
  end

end