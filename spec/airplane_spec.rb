require 'airplane'

describe Plane do

  let(:airport) { double :Airport }
  let(:plane) { Plane.new(airport) }

  it 'should be parked at an airport' do
    expect(plane).to be_parked_at(airport)
  end

end