require './lib/checkout.rb'

describe 'Checkout' do

  it 'has a list of items' do
    expect(subject.blanket).not_to be nil
  end

  it 'can accept and set a promotion' do

  end

  before { subject.scan(blanket)}
  it 'allows user to add items to cart' do
    expect(subject.cart).not_to be nil
  end

  it 'totals items in the cart' do
    expect(subject.total).to eq 19.95
  end

  describe 'Subject has checked out more than $60 of items' do

    before do
      subject.scan(blanket)
      subject.scan(lounger)
      subject.scan(lounger)
      subject.scan(hotdog)
    end

    it 'gives a 10% discount when total goes over $60' do
      expect(subject.total).to eq 1_340_971
    end
  end

  describe 'User has checked out two hotdogs' do
    before do
      subject.scan(hotdog)
      subject.scan(hotdog)
    end

    it 'reduces cost of hot dogs to 8.25' do
      expect(subject.total).to be 16.50
    end
  end
end
