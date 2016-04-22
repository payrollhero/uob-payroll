require "spec_helper"

describe UOB::Payroll::TXTFile do

  subject(:file) { described_class.new params }

  let(:params) {
    {
      company_name: 'PayrollHero',
      account_number: '3513220373',
      branch_code: '351',
      date: Date.new(2015,05,05),
      payable_date: Date.new(2015,05,06),
      transactions: transactions
    }
  }

  let(:transactions) {
    [
      {
        bic_code: 'UOVBSGSG351',
        account_number: '3513220403',
        account_name: 'Juan de la Cruz',
        amount: 43.35
      }
    ]
  }

  let(:expected_content) { File.read 'spec/fixtures/payroll_sample.txt'}

  it { expect(file.content).to eq expected_content }
end

