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
    case inputs.first
    when 'Add'
      # I think we might want to ignore creation of new accounts with same name
      # ie: creating a 2nd account under name "Tom" would not overwrite the first "Tom"
      @user_accts[inputs[1]] = CardAccount.new(inputs[1], inputs[2], inputs[3])
    when 'Charge'
      @user_accts[inputs[1]].charge(inputs[2])
    when 'Credit'
      @user_accts[inputs[1]].credit(inputs[2])
    end
  end

  # prints account info in order of account name
  def print_all_accounts
    @user_accts.sort_by{ |name, user| name.downcase }.each do |name, user|
      user.print_user
    end
  end
end
