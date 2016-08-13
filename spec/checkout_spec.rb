require './lib/checkout.rb'

describe Checkout do
  # let(:promo) {'60 percent'}
  subject {Checkout.new}
  it 'has a list of items' do
    expect(subject.blanket).not_to be nil
  end

  it 'can accept and set a promotion' do

  end

  describe 'Basics' do

    before { subject.scan(subject.blanket) }

    it 'allows user to add items to cart' do
      expect(subject.cart).not_to eq []
    end

    it 'totals items in the cart' do
      expect(subject.total).to eq 19.95
    end
  end
  describe 'Subject has checked out more than $60 of items' do

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

  describe 'User has checked out two hotdogs' do
    before do
      subject.scan(subject.hotdog)
      subject.scan(subject.hotdog)
    end

    # it 'counts the number of hot dogs in cart' do
    #   expect(subject.count).not_to be nil
    # end

    it 'reduces cost of hot dogs to 8.25' do
      expect(subject.total).to be 16.50
    end

    #Need to deal with combining promos
    #Need to deal with having a product hash instead of just set variables
    #Might want to let a user remove a product from their cart (affecting hotdog discounts)
  end
end
