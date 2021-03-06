require 'chefspec'
require 'chefspec/berkshelf'

# This is not generated by "chef generate cookbook"
RSpec.configure do |config|

  # Make the output show what tests were run and do it in color
  config.color     = true
  config.formatter = :documentation

  # Specify the operating platform to mock Ohai data from (default: nil)
  config.platform = 'centos'

  # Specify the operating version to mock Ohai data from (default: nil)
  config.version = '7.0'
end

at_exit { ChefSpec::Coverage.report! }
