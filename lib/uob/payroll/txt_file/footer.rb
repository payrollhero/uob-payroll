require 'active_model'
require 'ph_utility'

module UOB
  module Payroll
    class TXTFile::Footer
      include ActiveModel::Model
      include PhUtility::TxtData::TxtDataRowDSL

      number :record_type, 1..1, value: 9
      text :formatted_total_amount, 2..19, just: :right, pad: '0'
      text :formatted_number_of_records, 20..26, just: :right, pad: '0'
      text :hash_total, 27..42, just: :right, pad: '0'
      spaces 43..615

      attr_reader :total_amount, :number_of_records

      def initialize(total_amount:, number_of_records:)
        @total_amount = total_amount
        @number_of_records = number_of_records
        raise Errors::Invalid, errors.full_messages.to_sentence unless valid?
      end

      def hash_total

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
