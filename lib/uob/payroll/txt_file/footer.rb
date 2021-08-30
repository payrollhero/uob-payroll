require 'active_model'
require_relative '../hash_calculator'
require 'txt_data/txt_data_row_dsl'

module UOB
  module Payroll
    class TXTFile::Footer
      include ActiveModel::Model
      include TxtData::TxtDataRowDSL

      number :record_type, 1..1, value: 9
      text :formatted_total_amount, 2..19, just: :right, pad: '0'
      text :formatted_number_of_records, 20..26, just: :right, pad: '0'
      text :hash_total, 27..42, just: :right, pad: '0'
      spaces 43..615

      attr_reader :total_amount, :number_of_records, :header, :rows

      # @param [BigDecimal] total_amount The total amount to be transferred
      # @param [TXTFile::Header] header The header details used for the hash computation
      # @param [Array<TXTFile::Row>] rows The row details used for the has computation
      def initialize(total_amount:, header:, rows:)
        @total_amount = total_amount
        @number_of_records = rows.count
        @header = header
        @rows = rows
        raise Errors::Invalid, errors.full_messages.to_sentence unless valid?
      end

      def hash_total
        HashCalculator.calculate(header: header, rows: rows)
      end

      def formatted_number_of_records
        format '%06d', number_of_records
      end

      def formatted_total_amount
        (format '%015.2f', total_amount).gsub('.','')
      end
    end
  end
end
