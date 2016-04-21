require "spec_helper"

describe UOB::Payroll::TXTFile::Header do

  subject(:header) { described_class.new params }
  let(:string_version) { header.to_s }

  let(:params) {
    {
      company_name: 'PayrollHero',
      creation_date: Date.new(2015,05,05),
      value_date: Date.new(2015,05,06),
      account_number: '3513220373',
      branch_code: 'XXX'
    }
  }

  let(:expected_content) { File.read 'spec/fixtures/header_sample.txt'}

  it do
    expect(string_version).to eq expected_content
  end
end
