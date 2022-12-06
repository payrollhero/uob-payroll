$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.minimum_coverage 96
SimpleCov.start 'rails'
require 'uob/payroll'

