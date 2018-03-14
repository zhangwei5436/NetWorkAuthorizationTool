#
# Be sure to run `pod lib lint NetWorkAuthorizationTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetWorkAuthorizationTool'
  s.version          = '0.2.1'
  s.summary          = 'NetWorkAuthorizationTool 库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 检测蜂窝数据针对APP的链接状态，以及对于状态的一个监控.
                       DESC

  s.homepage         = 'https://github.com/zhangwei5436/NetWorkAuthorizationTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhangwei5436' => '825460068@qq.com' }
  s.source           = { :git => 'https://github.com/zhangwei5436/NetWorkAuthorizationTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NetWorkAuthorizationTool/Classes/**/*'
  
  # s.resource_bundles = {
  #   'NetWorkAuthorizationTool' => ['NetWorkAuthorizationTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'CoreTelephony'
  s.dependency 'AFNetworking/Reachability'
end
