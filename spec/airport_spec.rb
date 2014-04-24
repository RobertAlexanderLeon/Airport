require 'airport'

describe Airport do

  let(:weather) { double :Weather }
  let(:airport) { Airport.new(0, 10, weather) }
  let(:airplane) { double :airplane }
  
  it "should have it's own weather" do
    expect(airport.weather).to eq weather
  end

  it 'should start without the treat of alien invasion' do
    expect(airport).not_to have_an_alien_invasion
  end

  context 'can have an alien invasion which should' do

    it 'cause widespread panic' do
      airport.alien_invasion_alert
      expect(airport).to have_an_alien_invasion
    end

    it 'be defeated' do
      airport.alien_invasion_alert
      airport.defeat_alien_invasion
      expect(airport).not_to have_an_alien_invasion
    end

  end

  context 'should have a hanger' do

    it 'with a maximum capacity' do
      expect(airport.capacity).to eq 10
    end

    it 'with a number of airplanes' do
      airport = Airport.new(1, 10, weather)
      expect(airport.hanger.count).to eq 1
    end

    it 'which cannot hold more airplanes than there is capacity for' do
      expect {
        airport = Airport.new(10, 5, weather)
      }.to raise_error(ArgumentError,
        'Hanger is full, no capacity for more airplanes.')
    end

  end

  context 'should have a runway' do

    it 'that starts empty' do
      expect(airport.runway).to be_nil
    end

    it 'that cannot accomodate more than one airplane' do
      airplane2 = double :airplane
      airport.move_to_runway(airplane)
      airport.move_to_runway(airplane2)

      expect(airport.runway).to eq airplane
    end

    it 'and an airplane can taxi there from the hanger' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(airplane)
      airport.move_to_runway(airplane)

      expect(airport.hanger).not_to include airplane
      expect(airport.runway).to eq airplane
    end

  end

  context 'should let airplanes land' do

    it 'if there space in the hanger, sunny weather and no an alien invasion' do
      expect(weather).to receive(:conditions).and_return :sunny
      expect(airport).to be_clear_to_land
    end

    it 'and put them in the hanger' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(airplane)

      expect(airport.hanger).to include airplane
    end

  end

  context 'should not land airplanes if there is' do

    it 'stormy weather' do
      expect(weather).to receive(:conditions).and_return :stormy
      expect(airport).not_to be_clear_to_land
    end

    it 'no space in the hanger' do
      airport = Airport.new(50, 50, weather)
      expect(airport).not_to be_clear_to_land
    end

    it 'an alien invasion' do
      expect(weather).to receive(:conditions).and_return :sunny
      airport.alien_invasion_alert

      expect(airport).not_to be_clear_to_land
    end

  end

  context 'should let airplanes take off' do

    it 'if there is sunny weather and no alien invasion' do
      expect(weather).to receive(:conditions).and_return :sunny
      expect(airport).to be_clear_to_take_off
    end

    it 'from the runway and remove them from the airport' do
      expect(airport).to receive(:clear_to_land?).and_return true
      airport.land(airplane)
      expect(airport).to receive(:clear_to_take_off?).and_return true
      airport.take_off(airplane)

      expect(airport.hanger).not_to include airplane
      expect(airport.runway).to eq nil
    end

  end

  context 'should not let airplanes take off' do

    it 'in stormy weather conditions' do
      expect(weather).to receive(:conditions).and_return :stormy
      expect(airport).not_to be_clear_to_take_off
    end

    it 'during an alien invasion' do
      expect(weather).to receive(:conditions).and_return :sunny
      airport.alien_invasion_alert

      expect(airport).not_to be_clear_to_take_off
    end

  end

end