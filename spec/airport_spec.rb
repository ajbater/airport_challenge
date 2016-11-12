require 'airport'

describe Airport do

  let(:plane) { double :plane }
  let(:weather) { double :weather }

  it {is_expected.to respond_to :land}

  it 'allows a plane to land' do
    expect(subject.land(plane)).to include(plane)
  end

  it 'allows you to see landed planes, to confirm that they have landed' do
    subject.land(plane)
    expect(subject.planes).to include(plane)
  end

  it 'allows planes to take off' do
    subject.land(plane)
    expect(subject.take_off(plane)).to eq plane
  end

  it 'can raise an error when weather is too stormy' do
    expect{subject.too_stormy}.to raise_error(RuntimeError, 'weather is too stormy')
  end

  it 'does not allow planes to take off when weather is stormy' do
    stormy_weather
    expect{subject.take_off(plane)}.to raise_error(RuntimeError, 'weather is too stormy')
  end

  it 'does not allow planes to land when weather is stormy' do
    stormy_weather
    expect(subject.land(plane)).to raise_error(RuntimeError, 'weather is too stormy')
  end

  it 'does not allow planes to land when airport capacity is full' do
    Airport::DEFAULT_CAPACITY.times {subject.land(plane)}
    expect{subject.land(plane)}.to raise_error(RuntimeError, 'Airport is full')
  end

  it 'checks that DEFAULT_CAPACITY has been set and is an integer' do
    expect(Airport::DEFAULT_CAPACITY).to be_kind_of(Integer)
  end

  it 'allows the system designer to override default capacity' do
    airport = Airport.new(30)
    expect(airport.capacity).to eq 30
  end

  def stormy_weather
    allow(:weather).to receive(:stormy?) { true }
  end


end
