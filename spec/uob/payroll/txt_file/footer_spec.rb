require "spec_helper"

describe UOB::Payroll::TXTFile::Footer do

  subject(:footer) { described_class.new **params }
  let(:string_version) { footer.to_s }

  let(:params) {
    {
      total_amount: 1200,
      header: header,
      rows: rows
    }
  }

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
      UOB::Payroll::TXTFile::Row.new(**first_row_params)
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

  let(:expected_content) { File.read 'spec/fixtures/footer_sample.txt'}

  it { expect(string_version).to eq expected_content }
end
