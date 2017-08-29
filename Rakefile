# -*- coding: utf-8 -*-
$:.unshift('/Library/RubyMotion/lib')
require 'motion/project/template/ios'


require 'bundler'
Bundler.require

#require 'json'
require 'bubble-wrap'
require 'bubble-wrap/media'
require 'afmotion'
#require 'ProMotion'
require 'ProMotion-XLForm'
#require 'ruby_motion_query'
#require 'cdq'

#design dependences
require 'moticons'

Motion::Project::App.setup do |app|

  app.name = 'Glubrain'
  app.identifier = 'com.wagnerborba.testprofile.Gluebrain'
  app.short_version = '1.0.1'
  app.version = app.short_version

  # SDK 8 for iOS 8 and above
  app.deployment_target = '10.2'
  app.sdk_version = "10.2"

  app.icons = ["icon@2x.png", "icon-29@2x.png", "icon-40@2x.png", "icon-60@2x.png", "icon-76@2x.png", "icon-512@2x.png"]

  # prerendered_icon is only needed in iOS 6
  app.prerendered_icon = true

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]

  app.files += Dir.glob(File.join(app.project_dir, 'lib/**/*.rb'))

  # Use `rake config' to see complete project settings, here are some examples:
  #
  # app.fonts = ['Oswald-Regular.ttf', 'FontAwesome.otf'] # These go in /resources
  # app.frameworks += %w(QuartzCore CoreGraphics MediaPlayer MessageUI CoreData)
  #
  # app.vendor_project('vendor/Flurry', :static)
  # app.vendor_project('vendor/DSLCalendarView', :static, :cflags => '-fobjc-arc') # Using arc
  #
  app.pods do
    pod 'AFNetworking'
    pod 'FontAwesomeKit'
    #pod 'SVProgressHUD'
    #pod 'JMImageCache'
  end

  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true }
  # {
  #   'NSExceptionDomains' => {
  #     'datamarket.accesscontrol.windows.net' => {
  #       'NSIncludesSubdomains' => true,
  #       'NSExceptionRequiresForwardSecrecy' => false
  #     }
  #   }
  # }


  app.development do

    # To live code reloading - Take off to release
    #app.info_plist["ProjectRootPath"] = File.dirname(__FILE__)

    #app.codesign_certificate = "iOS Developer: Wagner Borba"
    app.provisioning_profile = "/Users/wagner/Library/MobileDevice/Provisioning Profiles/604dff93-0c28-4f4d-9c01-7c1c27ce9cfd.mobileprovision"
  end

  app.release do
    app.entitlements['get-task-allow'] = false
    app.codesign_certificate = 'iPhone Distribution: YOURNAME'
    app.provisioning_profile = "signing/com.wagnerborba.testprofile.Gluebrain"
    app.seed_id = "YOUR_SEED_ID"
    app.entitlements['application-identifier'] = app.seed_id + '.' + app.identifier
    app.entitlements['keychain-access-groups'] = [ app.seed_id + '.' + app.identifier ]
  end

  #puts ENV['RUBYMOTION_ENV']

  puts "Name: #{app.name}"
  puts "Using profile: #{app.provisioning_profile}"
  puts "Using certificate: #{app.codesign_certificate}"

end
task :"build:simulator" => :"schema:build"
