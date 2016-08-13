require './lib/checkout.rb'

describe Checkout do
  subject {described_class.new promo: '60bucks' }
  it 'has a list of items' do
    expect(subject.blanket).not_to be nil
  end

  describe 'Invalid promo' do

    subject { described_class.new promo: 'grumpy'}
    it 'throws error if invalid promo entered' do
      expect{ subject {described_class.new promo: 'invalid'}}.to raise_error 'Invalid promo'
    end

  end

  describe 'Basics' do
    subject {described_class.new promo: '60bucks' }
    before { subject.scan(subject.blanket) }

    it 'allows user to add items to cart' do
      expect(subject.cart).not_to eq []
    end

    it 'totals items in the cart' do
      expect(subject.total).to eq 19.95
    end
  end
  describe 'Subject has checked out more than $60 of items' do
    subject {described_class.new promo: '60bucks' }

    before do
      subject.scan(subject.blanket)
      subject.scan(subject.lounger)
      subject.scan(subject.lounger)
      subject.scan(subject.hotdog)
    end

    it 'allows for multiple items in cart' do
      expect(subject.total).to be > 100
    end

    it 'gives a 10% discount when total goes over $60' do
      expect(subject.total).to eq 119.2*0.9
    end
  end

  describe 'User has scanned two hotdogs' do
    subject {described_class.new promo: 'hotdogs' }
    before do
      subject.scan(subject.hotdog)
      subject.scan(subject.hotdog)
    end

    it 'reduces cost of hot dogs to 8.25' do
      expect(subject.total).to be 17.0
    end

#Need to deal with having a product hash instead of just set variables
#Might want to let a user remove a product from their cart (affecting hotdog discounts)
#Need to set my tests to match Scope tests
  end

  describe 'User meets both discount requirements' do
    subject {described_class.new promo: 'both' }
    before do
      subject.scan(subject.blanket)
      subject.scan(subject.lounger)
      subject.scan(subject.hotdog)
      subject.scan(subject.hotdog)
    end

    it 'subtracts 10% AND reduces hot dog price' do
      expect(subject.total).to be 73.76
    end
  end
end
