require 'weather'

describe Weather do

  let(:weather) { Weather.new }
  
  context 'random weather conditions' do

    it 'will be sunny sometimes' do
      expect(Random).to receive(:rand).with(0..1).and_return(0)

      expect(weather.conditions).to eq :sunny
    end

    it 'will be stormy sometimes' do
      expect(Random).to receive(:rand).with(0..1).and_return(1)

      expect(weather.conditions).to eq :stormy
    end

  end

end