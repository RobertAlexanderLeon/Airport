require 'airplane'

describe Airplane do

  let(:airport) { double :Airport }
  let(:airplane) { Airplane.new(airport) }

  it 'should be parked at an airport' do
    expect(airplane).to be_parked_at(airport)
  end

  context 'While parked at an airport the airplane will' do

  it "taxi to the runway before taking off" do
      expect(airport).to receive(:move_to_runway).with(airplane)
      airplane.taxi_to_runway
    end


  it 'take off with clearance' do
      expect(airport).to receive(:move_to_runway).with(airplane)
      expect(airport).to receive(:clear_for_take_off?).and_return true
      airplane.take_off

      expect(airplane).not_to be_parked_at(airport)
  end

  it 'not take off without clearance' do
      expect(airport).to receive(:move_to_runway).with(airplane)
      expect(airport).to receive(:clear_for_take_off?).and_return false
      airplane.take_off

      expect(airplane).to be_parked_at(airport)
  end

end   
   
  context 'While airborne the airplane can' do

  let(:airplane) { Airplane.new(nil) }

  it 'land at an airport with clearance' do
      expect(airport).to receive(:clear_for_landing?).and_return true
      airplane.land_at(airport)

      expect(airplane).to be_parked_at(airport)
  end

  it 'not land without clearance' do
      expect(airport).to receive(:clear_for_landing?).and_return false
      airplane.land_at(airport)

      expect(airplane).not_to be_parked_at(airport)
  end

end






end