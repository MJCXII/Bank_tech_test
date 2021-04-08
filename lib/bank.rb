# frozen_string_literal: true

require 'date'
require 'hirb'

class Account
  def initialize(funds = 0)
    @funds = funds
    @transaction = []
  end

  def balance
    puts "Account balance: #{'%.2f' % @funds}"
    @funds
  end

  def deposit(amount)
    @funds += amount
    @transaction << {Balance: '%.2f' % @funds, Debit: "", Credit: '%.2f' % amount, Date: date}
  end

  def withdraw(amount)
    skint?(amount)
    @funds -= amount
    @transaction << {Balance: '%.2f' % @funds, Debit: '%.2f' % amount, Credit: "", Date: date}
  end

  def statement
    puts Hirb::Helpers::AutoTable.render(@transaction, fields: %i[Date Credit Debit Balance])
  end

  def date
    Time.now.strftime('%d/%m/%Y')
  end

  private
  def skint?(amount)
    raise 'Insufficient Funds' if @funds < amount
  end
end
