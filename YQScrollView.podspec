
Pod::Spec.new do |s|

  s.name         = "YQScrollView"
  s.version      = "1.0.0"
  s.summary      = "scrollView 互相嵌套 实现平滑滚动 解决手势冲突 丝滑般顺溜"
  s.homepage     = "https://github.com/gyg6/YQScrollViewNested"
  s.license      = "MIT"
  s.author             = { "郭宇琪" => "18738193980@163.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "git@github.com:gyg6/YQScrollViewNested.git", :tag => "1.0.0" }
  s.source_files  = "YQScrollView"
  s.requires_arc = true
  s.dependency "TYPagerController", "~> 2.1.0"

end
