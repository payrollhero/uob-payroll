require 'spec_helper'

describe Uob::Payroll do
  it 'has a version number' do
    expect(Uob::Payroll::VERSION).not_to be nil
    expect(Uob::Payroll::VERSION).to be >= '1.2'
  end
end
