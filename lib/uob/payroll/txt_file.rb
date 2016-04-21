require 'active_model'

module UOB
  module Payroll
    class TXTFile
      extend ActiveSupport::Autoload

      autoload :Header
      autoload :Row
      autoload :Footer

      include ActiveModel::Model

      def initialize(company_name:, date:, transactions:)
        @header = Header.new company_name: company_name, date: date
        @rows = transactions.map { |transaction| Row.new transaction }
        @footer = Footer.new number_of_records: rows.count, total_amount: rows.sum(&:amount)
      end

      def content
        [
          header,
          rows,
          footer,
        ].join("\r\n")
      end

      private

      attr_accessor :header, :rows, :footer
    end
  end
end
