Pod::Spec.new do |s|
  s.name             = "TAKLogger"
  s.version          = "1.0.0"
  s.summary          = "Logger"
  s.homepage         = "https://github.com/taka0125/TAKLogger"
  s.license          = 'MIT'
  s.author           = { "Takahiro Ooishi" => "taka0125@gmail.com" }
  s.source           = { :git => "https://github.com/taka0125/TAKLogger.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/taka0125'

  s.platform     = :ios, '8.0'

  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TAKLogger' => ['Pod/Assets/*.png']
  }
end
