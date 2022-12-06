require 'uob/payroll/version'
require 'uob/payroll/errors'

require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/enumerable'

require 'ph_model'

module UOB
  module Payroll
    extend ActiveSupport::Autoload

    autoload :Errors
    autoload :TXTFile
    autoload :StringCalculator
    autoload :HashCalculator

    GEM_ROOT = File.expand_path(File.dirname(__FILE__) + '/../..')
  end
end
