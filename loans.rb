require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'

class LoanSettler
  def initialize(loans)
    @loans = loans
  end

  def settle_up
    @loans.map do |loan|
      { from: loan.to, to: loan.from, amount: loan.amount }
    end
  end
end

class Loan
  attr_accessor :from, :to, :amount

  def initialize(options)
    @from = options[:from]
    @to = options[:to]
    @amount = options[:amount]
  end
end


class LoanSettlerTest < Minitest::Test
  def test_that_zero_loans_returns_empty
    loans = []
    loan_settler = LoanSettler.new loans

    assert_equal [], loan_settler.settle_up
  end

  def test_that_one_loan_is_paid_back
    loans = [Loan.new(from: "Alice", to: "Bob", amount: 100)]
    loan_settler = LoanSettler.new loans

    assert_equal [{from: "Bob", to: "Alice", amount: 100}], loan_settler.settle_up
  end
end
