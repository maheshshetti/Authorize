Pod::Spec.new do |s|
  s.name            = 'MSSAuthorize'
  s.version         = '1.0'
  s.summary      = 'MSS Authorize'
 
  s.description   = <<-DESC
	MSS Authorize - Uses App Auth Framework
                       DESC
 
  s.homepage   = 'https://github.com/maheshshetti/Authorize'
  s.license         = { :type => 'MIT', :text => <<-LICENSE
                   Copyright 2012
                   Permission is granted to...
                LICENSE
               }
  s.author          = { 'Mahesh Sammatashetti' => 'maheshsam@cybage.com' }
  s.source         = { :git => 'https://github.com/maheshshetti/Authorize.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.3'
  s.source_files = 'Authorize/*.{h, m, swift}'

  s.dependency 'AppAuth'
end