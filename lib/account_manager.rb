require_relative 'card_account'

class AccountManager

  attr_reader :user_accts
  def initialize()
    # allow us to look up users by name
    @user_accts = {}
  end

  def process_line(line)
    inputs = line.split(' ')
    # first word is always the action
    puts line
    case inputs.first
    when 'Add'
      # I think we might want to ignore creation of new accounts with same name
      # ie: creating a 2nd account under name "Tom" would not overwrite the first "Tom"
      @user_accts[inputs[1]] = CardAccount.new(inputs[1], inputs[2], inputs[3])
    when 'Charge'
      puts "charging #{inputs[2]} to #{inputs[1]}"
      @user_accts[inputs[1]].charge(inputs[2])
    when 'Credit'
      puts 'were crediting our lasers'
      @user_accts[inputs[1]].credit(inputs[2])
    end
  end
end

a = AccountManager.new
ARGF.each_line do |line|
  a.process_line(line)
end
a.user_accts.each do |k, v|
  puts v.name
  puts v.balance
  puts v.valid
end