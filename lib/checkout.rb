require 'pry'

class Checkout

  attr_accessor :total, :cart, :blanket, :lounger, :hotdog, :pre_price, :hotdog_hash

  def initialize
    #some kind of switch between promotions
    @cart = []
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {code: 2, desc: 'A sturdy and attractive beach chair', price: 45.0}
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}
  end

  def scan(item)
    @cart << item

    #give us the count of each item in the cart
    count = Hash.new(0)
    cart.each do |item| count[item] += 1
    end

    #give us just the hot dogs from the count
    if count[hotdog] >= 2
       rewrite_cart
    end

    pre_price = 0
    cart.each do |item|
      pre_price += item[:price]
    end
    # binding.pry
    pre_price > 60.0 ? @total = pre_price*0.9 : @total = pre_price
  end

  private
  def rewrite_cart
    cart.each do |item|
      if item[:code] == 3
        item[:price] = 8.25
      end
    end
  end



end
