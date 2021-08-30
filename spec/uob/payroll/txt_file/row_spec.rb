require "spec_helper"

describe UOB::Payroll::TXTFile::Row do

  subject(:row) { described_class.new params }
  let(:string_version) { row.to_s }
  let(:amount) { 43.35 }

  let(:params) {
    {
      bic_code: 'UOVBSGSG351',
      account_number: '3513220403',
      account_name: 'Juan de la Cruz',
      amount: amount
    }
  }

  let(:expected_content) { File.read 'spec/fixtures/row_sample.txt'}

  it { expect(string_version).to eq expected_content }

  describe "formatted_amount" do
    describe "with an amount as a string param" do
      let(:amount) { "2000.565" }

      it "returns a proper value" do
        expect(row.formatted_amount).to eq "0000000200057"
      end
    end
    describe "with an amount as a float param" do
      let(:amount) { 2000.565 }

      it "returns a proper value" do
        expect(row.formatted_amount).to eq "0000000200057"
      end
    end
    describe "with an amount as a big decimal param" do
      let(:amount) { BigDecimal("2000.565") }

      it "returns a proper value" do
        expect(row.formatted_amount).to eq "0000000200057"
      end
    end
  end
end
