#
# Be sure to run `pod lib lint HYAnimationSmallTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYAnimationSmallTool'
  s.version          = '0.1.2'
  s.summary          = 'The HYAnimationSmallTool is a simple of animation tool for iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The HYAnimationSmallTool is a simple of animation tool for iOS. It is easy to use and understand.
                       DESC

  s.homepage         = 'https://github.com/HYAdonisCoding/HYAnimationSmallTool'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HYAdonisCoding' => '296786475@qq.com' }
  s.source           = { :git => 'https://github.com/HYAdonisCoding/HYAnimationSmallTool.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HYAnimationSmallTool/Classes/**/*'
  
  s.resource_bundles = {
    'HYAnimationSmallTool' => ['HYAnimationSmallTool/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
