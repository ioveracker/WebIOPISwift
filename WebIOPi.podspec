Pod::Spec.new do |s|
  s.name             = 'WebIOPI'
  s.version          = '0.1.0'
  s.summary          = 'A Swift wrapper for the WebIOPI API.'
  s.description      = <<-DESC
Interact with your Raspberry Pi running WebIOPI from Swift!
                       DESC
  s.homepage         = 'https://github.com/ioveracker/WebIOPI'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Isaac Overacker' => 'isaac@overacker.me' }
  s.source           = { :git => 'https://github.com/ioveracker/WebIOPI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/ioveracker'
  s.ios.deployment_target = '8.0'
  s.source_files = 'WebIOPI/Classes/**/*'
end
