require_relative 'airplane'

class Airport

  attr_reader :capacity, :hanger, :weather, :runway

  def initialize(no_of_airplanes, capacity, weather)
    check_arguments(no_of_airplanes, capacity)
    @capacity, @weather = capacity, weather
    @alien_invasion, @hanger, @runway = false, [], nil
    put_new_airplanes_in_hanger(no_of_airplanes)
  end

  def clear_to_land?
    has_space_in_hanger? and has_sunny_weather_and_no_alien_invasion?
  end

  def clear_to_take_off?
    has_sunny_weather_and_no_alien_invasion?
  end

  def land(airplane)
    @hanger << airplane if clear_to_land?
  end

  def move_to_runway(airplane)
    if @runway.nil?
      @hanger.delete(airplane)
      @runway = airplane
    end
  end

  def take_off(airplane)
    if clear_to_take_off?
      move_to_runway(airplane)
      @runway = nil if @runway = airplane
    end
  end

  def has_an_alien_invasion?
    @alien_invasion
  end

  def alien_invasion_alert
    @alien_invasion = true
  end

  def defeat_alien_invasion
    @alien_invasion = false
  end

  private

  def check_arguments(no_of_airplanes, capacity)
    raise ArgumentError.new(
      'Hanger is full, no capacity for more airplanes.'
    ) if no_of_airplanes > capacity
  end

  def put_new_airplanes_in_hanger(no_of_airplanes)
    no_of_airplanes.times { @hanger << new_airplane }
  end

  def new_airplane
    Airplane.new(self)
  end

  def sunny_weather?
    @weather.conditions == :sunny
  end

  def has_space_in_hanger?
    hanger.count < capacity
  end

  def has_sunny_weather_and_no_alien_invasion?
    sunny_weather? and !has_an_alien_invasion?
  end

end