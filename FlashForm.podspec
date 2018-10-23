Pod::Spec.new do |s|
  s.name         = "FlashForm"
  s.version      = "0.1.2"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.summary      = "Create a form in swift in a flash"
  s.homepage     = "https://github.com/isxq/FlashForm"
  s.source       = { :git => "https://github.com/isxq/FlashForm.git", :tag => s.version }

  swift_version = '4.2'

  s.source_files = "Source/*.swift"
  s.platform = :ios, "9.0"
  s.frameworks = 'UIKit', 'Foundation'
  
  s.author             = { "申小强" => "shen_x_q@163.com" }
  s.social_media_url   = "http://isxq.github.io"

end
