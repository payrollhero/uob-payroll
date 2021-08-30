module TxtData
  # DSL for defining a class which gives you back a row of a txt data file.
  # @example
  # class MyTxtRow
  #   include TxtData::TxtDataRowDSL
  #   text :date, 1..6
  #   spaces 7..51
  #   number :my_number, 52..55
  #   text :my_text, 56..58
  #   text :my_fixed_text, 58..71, value: '1234'
  #
  #   def date
  #     '151201'
  #   end
  #
  #   def my_number
  #     12
  #   end
  #
  #   def my_text
  #     "barf"
  #   end
  # end
  # Use #text to define some text, it is by default left padded with spaces
  # Use #number fo define a number, it is by default left padded with zeroes
  # Use #spaces to add spaces in that field.
  module TxtDataRowDSL
    extend ActiveSupport::Concern
    extend ActiveSupport::Autoload
    autoload :Field

    class_methods do
      def fields
        @fields ||= []
      end

      # Add a text field, right justified with space padding by default.
      # @param [Symbol] symbol
      # @param [Range] range
      # @param [:right|:left] just
      # @param [String] pad
      # @param [String] value
      def text(symbol, range, just: :right, pad: ' ', value: nil, sanitize: true)
        data(symbol, range, just: just, pad: pad, format: :text, value: value, sanitize: sanitize)
      end

      def money(symbol, range, just: :right, pad: '0', value: nil)
        data(symbol, range, just: just, pad: pad, format: :money, value: value)
      end

      # Add a number field, right justified with zero padding by default.
      # @param [Symbol] symbol
      # @param [Range] range
      # @param [:right|:left] just
      # @param [String] pad
      # @param [String] value
      def number(symbol, range, just: :right, pad: '0', value: nil)
        data(symbol, range, just: just, pad: pad, format: :number, value: value)
      end

      # @param [Range] range
      def spaces(range)
        data(:spaces, range, just: :left, pad: ' ', format: :text, value: ' ' * range.size)
      end

      private

      def data(symbol, range, just: :none, pad:, value: nil, format: :text, sanitize: true)
        fields << Field.new(symbol, range, just, pad, value, format, sanitize)
      end
    end

    def to_s
      self.class.fields.map { |field|
        field.to_s(self)
      }.join("")
    end
  end
end
