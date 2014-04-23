require 'airplane'

describe Plane do

  let(:airport) { double :Airport }
  let(:plane) { Plane.new(airport) }

  it 'should be parked at an airport' do
    expect(plane).to be_parked_at(airport)
  end

  context 'While parked at an airport the plane will' do

  it "taxi to the runway before taking off" do
      expect(airport).to receive(:move_to_runway).with(plane)
      plane.taxi_to_runway
    end

  end



end