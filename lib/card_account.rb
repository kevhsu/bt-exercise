class CardAccount

  attr_reader :balance, :name, :valid

  def initialize(name, cc_num, limit)
    @balance = 0
    @name = name
    @valid = CardAccount.valid_card?(cc_num)
    @limit = normalize_money(limit)
  end

  # Luhn 10 check. Takes a string
  def self.valid_card?(cc_num)
    if cc_num.size > 19
      return false
    end
    int_digits = []
    cc_num.each_char do |digit|
      int_digits << digit.to_i
    end
    sum = 0
    for i in ((cc_num.size-1).downto(0))
      # double every other digit from the right
      if (cc_num.size-i) % 2 == 0
        if int_digits[i] < 5
          sum += int_digits[i]*2 
        else
          sum += (int_digits[i]*2 % 10) + 1
        end
      else
        sum += int_digits[i]
      end
    end
    (sum % 10) == 0
  end

  def charge(charge)
    charge_amt = normalize_money(charge)
    # decline charge if it bring balance above credit limit
    @balance += charge_amt unless (@balance + charge_amt) > @limit
  end

  def credit(credit)
    @balance -= normalize_money(credit)
  end

  # get dollar amount assuming our input looks like '$500'
  def normalize_money(monies)
    (monies[1..-1]).to_i if monies[0] == '$'
  end
end
