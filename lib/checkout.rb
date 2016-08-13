require 'pry'

class Checkout

  attr_reader :total, :cart, :blanket, :lounger,
  :hotdog, :pre_price, :hotdog_hash,
  :promotion

  def initialize(promo = {})
    @promotion = promo[:promo]
    @cart = []
    set_products
    validate_promo(@promotion)
  end

  def scan(item)
    @cart << item
    pre_price = 0.0
    cart.each do |x|
      pre_price += x[:price]
    end

    case promotion
    when '60bucks'
      sixty_bucks_promo(pre_price)
    when 'hotdogs'
      @total = pre_price - hot_dog_promo
    when 'both'
      @total = sixty_bucks_promo(pre_price) - hot_dog_promo*0.9
    else
      @total = pre_price
    end
    total
  end

  def total
    @total.round(2)
  end

  private
  def validate_promo(promo)
    unless promo == '60bucks' || promo == 'hotdogs' || promo == 'both' || promo.nil?
      raise 'Invalid promo'
    end
  end

  def sixty_bucks_promo(pre_price)
    pre_price > 60.0 ?
     @total = pre_price*0.9 : @total = pre_price
  end

  def hot_dog_promo
    count = Hash.new(0)
    cart.each do |x|
      count[x] += 1
    end
    count[hotdog] >= 2 ? (count[hotdog]*0.75) : 0
  end

  def set_products
    @blanket = {code: 1, desc: 'A soft and fluffy blanket', price: 19.95}
    @lounger = {
      code: 2,
      desc: 'A sturdy and
       attractive beach chair',
      price: 45.0
    }
    @hotdog = {code: 3, desc: 'An overpriced meat product', price: 9.25}
  end
end
