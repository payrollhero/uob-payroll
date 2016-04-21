require "spec_helper"

describe UOB::Payroll::TXTFile::Footer do

  subject(:footer) { described_class.new params }
  let(:string_version) { footer.to_s }

  let(:params) {
    {
      total_amount: 43.35,
      number_of_records: 1
    }
  }

  let(:expected_content) { File.read 'spec/fixtures/footer_sample.txt'}

  it { expect(string_version).to eq expected_content }
end
