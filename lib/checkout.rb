require 'pry'

class Checkout

  attr_reader :total, :cart, :blanket, :lounger, :hotdog, :pre_price, :hotdog_hash, :promotion

  def initialize(promo)
    @promotion = promo
    @cart = []
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {code: 2, desc: 'A sturdy and attractive beach chair', price: 45.0}
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}

    validate_promo(promo)
  end

  def scan(item)
    @cart << item
    pre_price = 0
    cart.each do |item|
      pre_price += item[:price]
    end

    case
    when promotion == '60bucks'
      sixty_bucks_promo(pre_price)
    when promotion == 'hotdogs'
      hot_dog_promo(item, pre_price)
    else
      @total = pre_price
    end
  end

  private
  def validate_promo(promo)
    if !(promo = '60 bucks' || promo = 'hotdogs')
      raise 'Invalid promo'
    end
  end

  def sixty_bucks_promo(pre_price)
    pre_price > 60.0 ?
     @total = pre_price*0.9 : @total = pre_price
  end

  def hot_dog_promo(item, pre_price)
    count = Hash.new(0)
    cart.each do |item| count[item] += 1
    end
    if count[hotdog] >= 2
      @total = pre_price - (count[hotdog]*0.75)
    end
  end
end
