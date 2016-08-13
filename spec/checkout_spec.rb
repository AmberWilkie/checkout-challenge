require './lib/checkout.rb'

describe 'Checkout' do

  it 'has a list of items' do
    expect(subject.blanket).not_to be nil
  end

  before { subject.scan(blanket)}
  it 'allows user to add items to cart' do
    expect(subject.cart).not_to be nil
  end


end
