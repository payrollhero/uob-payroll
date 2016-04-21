require "spec_helper"

describe UOB::Payroll::StringCalculator do
  subject(:calculator) { described_class.new string }

  let(:string) { 'PAYROLLHERO' }

  # P 80*1
  # A 65*2
  # Y 89*3
  # R 82*4
  # O 79*5
  # L 76*6
  # L 76*7
  # H 72*8
  # E 69*9
  # R 82*10
  # O 79*11
  it { expect(calculator.calculate).to eq 5074 }
end
