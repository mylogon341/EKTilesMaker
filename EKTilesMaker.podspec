Pod::Spec.new do |s|
  s.name         = "EKTilesMaker"
  s.version      = "0.9.2"
  s.summary      = "A simple Jigsaw puzzle game."
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Krzysztof Kuc"
  s.homepage     = "https://github.com/mylogon341/EKTilesMaker"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/mylogon341/EKTilesMaker.git", :tag => "#{s.version}" }
  s.source_files = "EKTilesMaker", "EKTilesMaker/**/*.{h,m}", "UIImage+EKTilesMaker/**/*.{h,m}"
end
