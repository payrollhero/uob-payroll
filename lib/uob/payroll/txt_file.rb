require 'active_model'

module UOB
  module Payroll
    class TXTFile
      extend ActiveSupport::Autoload

      autoload :Header
      autoload :Row
      autoload :Footer

      include ActiveModel::Model

      def initialize(company_name:, account_number:, branch_code:, date:, payable_date:, transactions:)
        @header = Header.new(
          company_name: company_name,
          account_number: account_number,
          branch_code: branch_code,
          creation_date: date,
          value_date: payable_date
        )
        @rows = transactions.map { |transaction| Row.new transaction }
        @footer = Footer.new total_amount: rows.sum(&:amount), header: header, rows: rows
      end

      def content
        [
          header,
          rows,
          footer,
        ].join("\n")
      end

      private

      attr_accessor :header, :rows, :footer
    end
  end
end
