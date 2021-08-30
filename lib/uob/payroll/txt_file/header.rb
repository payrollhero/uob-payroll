require 'active_model'

module UOB
  module Payroll
    class TXTFile::Header
      include ActiveModel::Model
#       include PhUtility::TxtData::TxtDataRowDSL

      number :record_type, 1..1, value: 1
      text :filename, 2..11
      text :payment_type, 12..12, value: 'R'
      text :service_type, 13..22, value: 'NORMAL', just: :left
      text :processing_mode, 23..23, value: ' '
      spaces 24..35
      text :originating_bic_code, 36..46
      text :originating_account_currency, 47..49, value: 'SGD'
      text :originating_account_number, 50..83, just: :left
      text :originating_account_name, 84..223, just: :left
      text :formatted_creation_date, 224..231
      text :formatted_value_date, 232..239
      text :ultimate_originating_customer, 240..379, just: :left, value: ' '
      text :bulk_customer_reference, 380..395, just: :left
      text :software_label, 396..405, value: 'PH', just: :left
      spaces 406..615

      attr_reader :company_name, :account_number, :branch_code, :creation_date, :value_date

      # @param [String] company_name
      # @param [String] account_number The originating 10 digit UOB bank account number
      # @param [String] branch_code The originating UOB branch code
      # @param [Date] creation_date Date when the bank file was created
      # @param [Date] value_date Date when the amounts will be credited to the receiving party
      def initialize(company_name:, account_number:, branch_code:, creation_date:, value_date:)
        @company_name = company_name
        @account_number = account_number
        @branch_code = branch_code
        @creation_date = creation_date
        @value_date = value_date

        raise Errors::Invalid, errors.full_messages.to_sentence unless valid?
      end

      def filename
        "UGBI#{creation_date.strftime('%d%m')}01"
      end

      def originating_bic_code
        "UOVBSGSG#{branch_code}"
      end

      def originating_account_number
        account_number
      end

      def originating_account_name
        String(company_name).upcase.ljust 140
      end

      def formatted_creation_date
        creation_date.strftime '%Y%m%d'
      end

      def formatted_value_date
        value_date.strftime '%Y%m%d'
      end

      def bulk_customer_reference
        "PAYROLL#{creation_date.strftime('%d%m')}"
      end
    end
  end
end
