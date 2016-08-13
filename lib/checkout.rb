require 'pry'

class Checkout

  attr_accessor :total, :cart, :blanket, :lounger, :hotdog, :pre_price

  def initialize
    #some kind of switch between promotions
    @cart = []
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {code: 2, desc: 'A sturdy and attractive beach chair', price: 45}
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}
  end

  def scan(item)
    @cart << item
    #the search of the hash and the values paired with "price" added together.
    # hash_of_all_prices = cart.select {|item| item.include? }
    pre_price = 0
    cart.each do |item|
      pre_price += item[:price]
    end
    # binding.pry
    pre_price > 60.0 ? @total = pre_price*0.9 : @total = pre_price

  end




end
