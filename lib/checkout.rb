require 'pry'

class Checkout

  attr_accessor :total, :cart, :blanket, :lounger, :hotdog, :pre_price

  def initalize
    #some kind of switch between promotions

  end

  def scan(item)
    @cart << item
    #the search of the hash and the values paired with "price" added together.
    # hash_of_all_prices = cart.select {|item| item.include? }
    pre_price = 0
    cart.each do |item|
      pre_price += item[:price]
      # item.map { |iterate|
      #   case
      #   when iterate = :price
      #     pre_price += item[:price]
      #   else
      #   end
      #   binding.pry
      #
      # }
    end
    @total = pre_price
  end

  def create_items
    @cart = []
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {code: 2, desc: 'A sturdy and attractive beach chair', price: 45}
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}
  end


end
