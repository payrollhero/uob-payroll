require_relative 'string_calculator'

# See https://payrollhero.atlassian.net/wiki/download/attachments/12288081/FAST-GIRO%20without%20Advice%20File%20Format%20for%20BIBPlus%20%28v3.03%29.pdf?version=1&modificationDate=1460018775794&api=v2
# Appendix 2 for the Hash Algorithm
module UOB
  module Payroll
    class HashCalculator

      def initialize(header:, rows:)
        @header = header
        @rows = rows
      end

      def calculate
        sum_header +
          sum_rows +
          22 # Payment Type is always 'R' for Payroll and Hash Code will always be 1. See p16.
      end

      attr_reader :header, :rows

      def sum_header
        calculate_string(header.originating_bic_code) +
          calculate_padded_string(string: header.originating_account_number, size: 34) +
          calculate_padded_string(string: header.originating_account_name, size: 140)
      end

      def sum_rows
        rows.each.with_index(1).map { |row, index|
          calculate_string(row.receiving_bic_code) +
            index * calculate_padded_string(string: row.receiving_account_number, size: 34) +
            index * calculate_padded_string(string: row.receiving_account_name, size: 140) +
            calculate_payment_type(index) +
            calculate_string('SGD') +
            calculate_padded_string(string: row.formatted_amount, size: 18, pad: '0', just: :right) +
            calculate_string('SALA')
        }.reduce(0, :+)
      end

      private

      # Payment Type is always 'R', so Payment Code = 22
      def calculate_payment_type(index)
        22 * (index)
      end

      def calculate_padded_string(string:, size:, pad: ' ', just: :left)
        if just == :left
          calculate_string string[0...size].ljust(size, pad)
        else
          calculate_string string[0...size].rjust(size, pad)
        end
      end

      def calculate_string(string)
        StringCalculator.calculate(string)
      end

    end
  end
end