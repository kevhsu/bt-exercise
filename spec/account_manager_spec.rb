require_relative '../lib/account_manager'

describe AccountManager do
  let(:manager) {AccountManager.new}
  describe "#process_line" do
    context "Given valid lines of actions" do
      it "completes user transactions" do
        manager.process_line("Add Tom 4111111111111111 $1000")
        expect(manager.user_accts.include?('Tom')).to be true
        manager.process_line("Charge Tom $500")
        expect(manager.user_accts['Tom'].balance).to be 500
        manager.process_line("Credit Tom $300")
        expect(manager.user_accts['Tom'].balance).to be 200
      end
    end
  end
end