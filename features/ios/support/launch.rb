########################################
#                                      #
#       Important Note                 #
#                                      #
#   When running calabash-ios tests at #
#   www.lesspainful.com                #
#   this file will be overwritten by   #
#   a file which automates             #
#   app launch on devices.             #
#                                      #
#   Don't rely on this file being      #
#   present when running at            #
#   www.lesspainful.com.               #
#                                      #
#  Only put stuff here to automate     #
#  iOS Simulator.                      #
#                                      #
#  You can put your app bundle path    #
#  for automating simulator app start: #
#  Uncomment APP_BUNDLE_PATH =..       #
#                                      #
########################################

require 'calabash-cucumber/launch/simulator_helper'
require 'sim_launcher'

# Uncomment and replace ?? appropriately
# This should point to your Simulator build
# which includes calabash framework
# this is usually the Calabash build configuration
# of your production target.
#APP_BUNDLE_PATH = "~/Library/Developer/Xcode/DerivedData/??/Build/Products/Calabash-iphonesimulator/??.app"
#

def reset_app_jail(sdk=nil, path=nil)
  sdk = sdk || ENV['SDK_VERSION'] || SimLauncher::SdkDetector.new().latest_sdk_version
  path = path || Calabash::Cucumber::SimulatorHelper.app_bundle_or_raise(app_path)
  app = File.basename(path)
  bundle = `find "#{ENV['HOME']}/Library/Application Support/iPhone Simulator/#{sdk}/Applications/" -type d -depth 2 -name #{app} | head -n 1`
  return if bundle.empty? # Assuming we're already clean

  sandbox = File.dirname(bundle)
  ['Library', 'Documents', 'tmp'].each do |dir|
    FileUtils.rm_rf(File.join(sandbox, dir))
  end
end

def relaunch
  if ENV['NO_LAUNCH']!="1"
    sdk = ENV['SDK_VERSION'] || SimLauncher::SdkDetector.new().latest_sdk_version
    path = Calabash::Cucumber::SimulatorHelper.app_bundle_or_raise(app_path)
    Calabash::Cucumber::SimulatorHelper.relaunch(path,sdk,ENV['DEVICE'] || 'iphone')
  end
end

def app_path
  ENV['APP_BUNDLE_PATH'] || (defined?(APP_BUNDLE_PATH) && APP_BUNDLE_PATH)
end

def calabash_notify
  if self.respond_to?(:on_launch)
    self.on_launch
  end
end

AfterConfiguration do |config|
	FeatureNameMemory.feature_name = nil
end

Before do |scenario|
  feature_name = scenario.feature.title
  if FeatureNameMemory.feature_name != feature_name \
      or ENV["RESET_BETWEEN_SCENARIOS"] == "1"
    reset_app_jail
    FeatureNameMemory.feature_name = feature_name
	  FeatureNameMemory.invocation = 1
  else
    FeatureNameMemory.invocation += 1
  end
  relaunch
  calabash_notify
end

FeatureNameMemory = Class.new
class << FeatureNameMemory
  @feature_name = nil
  attr_accessor :feature_name, :invocation
end

at_exit do
  if ENV['NO_LAUNCH']!="1" and ENV['NO_STOP']!="1"
    Calabash::Cucumber::SimulatorHelper.stop
  end
end
