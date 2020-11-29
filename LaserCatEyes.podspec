Pod::Spec.new do |s|
  s.name             = 'LaserCatEyes'
  s.version          = '1.0.11'
  s.summary          = 'Alamofire extension to log responses and requests.'
  s.description      = <<-DESC
  Alamofire extension to log responses and requests to Laser Cat Eyes Service.
                       DESC
  s.homepage         = 'https://portal-beta.lasercateyes.com'
  s.license          = { :type => 'BSD-3-Clause', :file => 'LICENSE' }
  s.author           = { "Betalgo" => "mail@betalgo.com" }
  s.source           = { :git => "https://github.com/betalgo/LCE-iOS-SDK.git", :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '10.0'
  s.tvos.deployment_target = '10.0'
  s.swift_versions = ['5.1', '5.2', '5.3']
  s.source_files = 'LaserCatEyes/Classes/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'Alamofire', '~> 5.0'
end
