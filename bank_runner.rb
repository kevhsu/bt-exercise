require_relative 'lib/account_manager'

a = AccountManager.new
ARGF.each_line do |line|
  a.process_line(line)
end
a.print_all_accounts