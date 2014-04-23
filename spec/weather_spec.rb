require 'weather'

describe Weather do

  let(:weather) { Weather.new }
  
  context 'random weather conditions' do

    it 'will be sunny half the time' do
      expect(Random).to receive(:rand).with(0..1).and_return(0)

      expect(weather.state).to eq :sunny
    end

    it 'will be stormy half the time' do
      expect(Random).to receive(:rand).with(0..1).and_return(1)

      expect(weather.state).to eq :stormy
    end

  end

end