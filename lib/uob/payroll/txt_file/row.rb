require 'active_model'
require 'ph_utility'

module UOB
  module Payroll
    class TXTFile::Row
      include ActiveModel::Model
      include PhUtility::TxtData::TxtDataRowDSL

      number :record_type, 1..1, value: 2
      text :receiving_bic_code, 2..12, just: :left
      text :receiving_account_number, 13..46, just: :left
      text :receiving_account_name, 47..186, just: :left
      text :receiving_account_currency, 187..189, value: 'SGD'
      text :formatted_amount, 190..207, just: :right, pad: '0'
      text :end_to_end_id, 208..242, just: :left
      text :mandate_id, 243..277, value: ' '
      text :purpose_code, 278..281, value: 'SALA'
      spaces 282..615

      attr_reader :bic_code, :account_number, :account_name, :amount

      validates :amount, numericality: { greater_than: 0, less_than_or_equal_to: 50_000 }

      # @param [String] bic_code The Bank Identifier Code or SWIFT code
      # @param [String] account_number The receiving bank account number
      # @param [String] account_name The receiving name of the account
      # @param [BigDecimal] amount The amount to be received
      def initialize(bic_code:, account_number:, account_name:, amount:)
        @bic_code = bic_code
        @account_number = account_number
        @account_name = account_name
        @amount = amount

        raise Errors::Invalid, errors.full_messages.to_sentence unless valid?
      end

      def formatted_amount
        (format '%014.2f', amount).gsub('.','')
      end

      def receiving_bic_code
        String(bic_code).upcase
      end

      def receiving_account_number
        account_number
      end

      def receiving_account_name
        String(account_name).ljust 140
      end

      def end_to_end_id
        'SALARY'
      end

    end
  end
end
