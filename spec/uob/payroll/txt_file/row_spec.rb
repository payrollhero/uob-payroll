require "spec_helper"

describe UOB::Payroll::TXTFile::Row do

  subject(:row) { described_class.new params }
  let(:string_version) { row.to_s }

  let(:params) {
    {
      bic_code: 'UOVBSGSG351',
      account_number: '3513220403',
      account_name: 'Juan de la Cruz',
      amount: 43.35
    }
  }

  let(:expected_content) { File.read 'spec/fixtures/row_sample.txt'}

  it { expect(string_version).to eq expected_content }

  describe "formatted_amount" do
    let(:params) {
      {
       bic_code: 'UOVBSGSG351',
       account_number: '3513220403',
       account_name: 'Juan de la Cruz',
       amount: "2000.565"
      }
    }

    it "returns a proper value" do
      expect(row.formatted_amount).to eq "0000000200057"
    end
  end
end
