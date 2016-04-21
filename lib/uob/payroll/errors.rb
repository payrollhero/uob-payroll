module UOB
  module Payroll
    module Errors
      class Error < StandardError
      end

      class Invalid < Error
      end
    end
  end
end
