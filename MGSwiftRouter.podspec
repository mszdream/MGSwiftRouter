#
# Be sure to run `pod lib lint MGSwiftRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MGSwiftRouter'
  s.version          = '1.1.1'
  s.summary          = 'A router library.'
  s.swift_versions   = '4.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
General routing, through which we can access our module entrance and pass relevant information to our module entrance function
                       DESC

  s.homepage         = 'https://github.com/mszdream/MGSwiftRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mszdream' => 'mszdream@126.com' }
  s.source           = { :git => 'https://github.com/mszdream/MGSwiftRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

#  s.source_files = 'MGSwiftRouter/Classes/**/*'
  s.subspec 'Core' do |ss|
    ss.source_files = 'MGSwiftRouter/Classes/Core/**/*'
    ss.xcconfig = {
      "OTHER_SWIFT_FLAGS" => "-D #{ss.name.tr!("//", "_")}"
    }
  end
  s.subspec 'RouterService' do |ss|
    ss.source_files = 'MGSwiftRouter/Classes/RouterService/**/*'
    ss.dependency 'MGSwiftRouter/Core'
    ss.xcconfig = {
      "OTHER_SWIFT_FLAGS" => "-D #{ss.name.tr!("//", "_")}"
    }
  end


  # s.resource_bundles = {
  #   'MGSwiftRouter' => ['MGSwiftRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
