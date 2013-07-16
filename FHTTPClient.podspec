Pod::Spec.new do |s|
  s.name         = "FHTTPClient"
  s.version      = "0.0.1"
  s.license      = { :type => 'Apache License Version 2.0', :file => 'LICENSE' }
  s.summary      = "A simple iOS HTTP Client for REST services."
  s.homepage     = "https://github.com/furymobile/FHTTPClient"
  s.author       = { "DarkestOne" => "darkestone@furymobile.com" }
  s.source       = { :git => "https://github.com/furymobile/FHTTPClient.git", :tag => "0.0.1" }
  s.source_files = 'FHTTPClient/FHTTPClient/**/*.{h,m}'
  s.ios.deployment_target = '5.0'
  s.frameworks =  'Foundation'
  s.requires_arc = true
end
