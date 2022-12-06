require "spec_helper"

describe UOB::Payroll::HashCalculator do
  subject(:calculator) { described_class.new(header: header, rows: rows) }

  let(:header) { UOB::Payroll::TXTFile::Header.new(**header_params) }

  let(:header_params) {
    {
      company_name: 'ABC SINGAPORE PTE LTD',
      creation_date: Date.new(2015,05,05),
      value_date: Date.new(2015,05,06),
      account_number: '1013320075',
      branch_code: 'XXX'
    }
  }

  let(:rows) {
    [
      UOB::Payroll::TXTFile::Row.new(**first_row_params),
      UOB::Payroll::TXTFile::Row.new(**second_row_params),
      UOB::Payroll::TXTFile::Row.new(**third_row_params)
    ]
  }

  let(:first_row_params) {
    {
      bic_code: 'DBSSSGSGXXX',
      account_number: '301234567',
      account_name: 'Tan Ah Kow',
      amount: 1200
    }
  }
  let(:second_row_params) {
    {
      bic_code: 'OCBCSGSGXXX',
      account_number: '50140399867195',
      account_name: 'Ronald Lee',
      amount: 2400.50
    }
  }
  let(:third_row_params) {
    {
      bic_code: 'HSBCSGSGXXX',
      account_number: '234908439123',
      account_name: 'Susan Wong Sui Cheng',
      amount: 3210.30
    }
  }

  # Based on UOB Manual with slight changes.
  # See Appendix 2, page 18 for calculations.
  it { expect(calculator.calculate).to eq 2459661 }
end
