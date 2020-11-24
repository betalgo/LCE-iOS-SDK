#
# Be sure to run `pod lib lint LaserCatEyes.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LaserCatEyes'
  s.version          = '1.0.6'
  s.summary          = 'Alamofire extension to log responses and requests.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Alamofire extension to log responses and requests to Laser Cat Eyes Service.
                       DESC

  s.homepage         = 'https://lasercateyes-portal-beta.azurewebsites.net'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { "Hakki" => "hakkiyigityener@hotmail.com" }
  s.source           = { :git => "https://github.com/betalgo/LCE-iOS-SDK.git", :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.watchos.deployment_target = '3.0'

  s.swift_versions = ['5.1', '5.2', '5.3']
  
  s.source_files = 'LaserCatEyes/Classes/**/*'
  
  # s.resource_bundles = {
  #   'LaserCatEyes' => ['LaserCatEyes/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Alamofire', '~> 5.0'
end
