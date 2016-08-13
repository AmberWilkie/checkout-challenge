require 'pry'

class Checkout

  attr_reader :total, :cart, :blanket, :lounger, :hotdog, :pre_price, :hotdog_hash, :promotion

  def initialize(promo = {})
    @promotion = promo[:promo]
    @cart = []
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {code: 2, desc: 'A sturdy and attractive beach chair', price: 45.0}
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}

    validate_promo(@promotion)
  end

  def scan(item)
    @cart << item
    pre_price = 0.0
    cart.each do |item|
      pre_price += item[:price]
    end

    case
    when promotion == '60bucks'
      sixty_bucks_promo(pre_price)
      @total.round(2)
    when promotion == 'hotdogs'
      @total = pre_price - hot_dog_promo(item)
      @total.round(2)
    when promotion == 'both'
      @total = sixty_bucks_promo(pre_price - hot_dog_promo(item)).round(2)
    else
      @total = pre_price.round(2)
    end
  end

  def total
    @total.round(2)
  end

  private
  def validate_promo(promo)
    if !(promo == '60bucks' || promo == 'hotdogs' || promo == 'both' || promo == nil)
      raise 'Invalid promo'
    end
  end

  def sixty_bucks_promo(pre_price)
    pre_price > 60.0 ?
     @total = pre_price*0.9 : @total = pre_price
  end

  def hot_dog_promo(item)
    count = Hash.new(0)
    cart.each do |item| count[item] += 1
    end
    count[hotdog] >= 2 ? (count[hotdog]*0.75) : 0

  end
end
