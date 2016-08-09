require_relative '../lib/card_account'

describe CardAccount do
  let(:account) {CardAccount.new("John", "4111111111111111", '$5000')}
  describe "#valid_card?" do
    context "given a valid luhr 10 number" do
      it "returns true" do
        expect(CardAccount.valid_card?("4111111111111111")).to be true
        expect(CardAccount.valid_card?("5454545454545454")).to be true
      end
    end
    context "given invalid inputs" do
      it "returns false on number over 19 digits" do
        expect(CardAccount.valid_card?("12345678901234567890")).to be false
      end
      it "returns false on numbers that dont pass luhr 10" do
        expect(CardAccount.valid_card?("4111111111114111")).to be false
        expect(CardAccount.valid_card?("1234567890123456")).to be false
      end
    end
  end

  describe "#charge" do
    context "given a charge that goes over the user's credit limit" do
      it "does not change the balance" do
        expect(account.balance).to eql 0
        account.charge('$5001')
        expect(account.balance).to eql 0
      end
    end

    context "given valid charges" do
      it "adjusts the balance correctly" do
        account.charge('$30')
        expect(account.balance).to eql 30
        account.charge('$100')
        expect(account.balance).to eql 130
      end
    end
  end

  describe "#credit" do
    context "given amount to credit" do
      it "changes the balance appropriately" do
        account.credit('$20')
        expect(account.balance).to eql -20
        account.credit('$30')
        expect(account.balance).to eql -50
      end
    end
  end
end
