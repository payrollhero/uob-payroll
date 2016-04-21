module UOB
  module Payroll
    class StringCalculator

      attr_reader :string

      class << self
        def calculate(string)
          new(string).calculate
        end
      end

      def initialize(string)
        @string = string
      end

      # The sum of each byte converted into ASCII multiplied to it's index.
      # For example:
      # BLA #=> 413
      # B ~> 66 * 1
      # L ~> 76 * 2
      # A ~> 65 * 3
      def calculate
        string.
          each_byte.
          to_a.
          each_with_index.
          map { |byte, index| (index + 1) * byte }.
          reduce(0, :+)
      end

    end
  end
end
