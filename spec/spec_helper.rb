$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.minimum_coverage 91
SimpleCov.start 'rails'
require 'uob/payroll'

