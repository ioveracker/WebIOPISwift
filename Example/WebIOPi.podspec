Pod::Spec.new do |s|
  s.name             = 'WebIOPi'
  s.version          = '0.1.0'
  s.summary          = 'A Swift wrapper for the WebIOPi API.'
  s.description      = <<-DESC
Interact with your Raspberry Pi running WebIOPi from Swift!
                       DESC
  s.homepage         = 'https://github.com/ioveracker/WebIOPi'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Isaac Overacker' => 'isaac@overacker.me' }
  s.source           = { :git => 'https://github.com/ioveracker/WebIOPi.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ioveracker'
  s.ios.deployment_target = '8.0'
  s.source_files = 'WebIOPi/Classes/**/*'
end
