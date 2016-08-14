require './lib/checkout.rb'

describe Checkout do
  subject {described_class.new promo: '60bucks' }
  it 'has a list of items' do
    expect(subject.products).not_to be nil
  end

  describe 'Invalid promo' do

    subject { described_class.new promo: 'grumpy'}
    it 'throws error if invalid promo entered' do
      expect do
        subject {described_class.new promo: 'invalid'}
      end.to raise_error 'Invalid promo'
    end

  end

  describe 'Basics' do
    subject {described_class.new promo: '60bucks' }
    before { subject.scan('blanket') }

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
      subject.scan('lounger')
      subject.scan('lounger')
      subject.scan('lounger')
    end

    it 'allows for multiple items in cart' do
      expect(subject.total).to be > 60
    end

    it 'gives a 10% discount when total goes over $60' do
      expect(subject.total).to eq 121.5
    end
  end

  describe 'User has scanned two hotdogs' do
    subject {described_class.new promo: 'hotdogs' }
    before do
      subject.scan('blanket')
      subject.scan('hotdog')
      subject.scan('hotdog')
    end

    it 'reduces cost of hot dogs to 8.25' do
      expect(subject.total).to be 36.95
    end
  end

  describe 'User meets both discount requirements' do
    subject {described_class.new promo: 'both' }
    before do
      subject.scan('blanket')
      subject.scan('lounger')
      subject.scan('hotdog')
      subject.scan('hotdog')
    end

    it 'subtracts 10% AND reduces hot dog price' do
      expect(subject.total).to be 73.76
    end
  end

  describe 'Customer removes a hot dog from cart' do

    before do
      subject.scan('blanket')
      subject.scan('lounger')
      subject.scan('hotdog')
      subject.scan('hotdog')
      subject.remove_from_cart('hotdog')
    end

    it 'removes item from cart' do
      expect(subject.cart.length).to be 3
    end

    it 'removes discounts when requirements no longer met' do
      expect(subject.total).to be 66.78
    end
  end

  describe 'Customer goes under $60 by removing item' do
    before do
      subject.scan('blanket')
      subject.scan('lounger')
      subject.scan('hotdog')
      subject.scan('hotdog')
      subject.remove_from_cart('lounger')

    it 'takes away 10% discount' do
      expect(subject.total).to be 36.95
    end
    end
  end
end

#Might want to let a user remove a product from their cart
