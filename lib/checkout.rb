require 'pry'

class Checkout

  attr_accessor :total, :cart, :blanket, :lounger, :hotdog

  def initalize
    #some kind of switch between promotions

  end

  def scan(item)
    @cart << item
    binding.pry

  end

  def create_items
    @cart = []
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {code: 2, desc: 'A sturdy and attractive beach chair', price: 45}
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}
  end


end
