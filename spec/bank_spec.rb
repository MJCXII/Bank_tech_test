# frozen_string_literal: true

require 'bank'
require 'date'

describe Account do
  it 'balance method returns balance' do
    account = Account.new(10)
    expect(account.balance).to eq(10)
  end
  it 'deposited money is add to balance' do
    account = Account.new(10)
    account.deposit(20)
    expect(account.balance).to eq(30)
  end
  it 'withdrawn money is removed from balance' do
    account = Account.new(10)
    account.withdraw(5)
    expect(account.balance).to eq(5)
  end
  it 'date returns current date' do
    account = Account.new(10)
    expect(account.date).to eq(Time.now.strftime('%d/%m/%Y'))
  end
  it 'displays information in table' do
    table = Hirb::Helpers::AutoTable.render([{ Balance: '5.00', Debit: '5.00', Credit: '', Date: '07/04/2021' }])
    expect { puts table }
      .to output("+---------+--------+------------+-------+\n| Balance | Credit | Date       | Debit |\n+---------+--------+------------+-------+\n| 5.00    |        | 07/04/2021 | 5.00  |\n+---------+--------+------------+-------+\n1 row in set\n").to_stdout_from_any_process
  end
end

describe 'account_errors' do
  it 'withdrawing move than account balance' do
    account = Account.new(5)
    expect { account.withdraw(10) }.to raise_error('Insufficient Funds')
  end
end
