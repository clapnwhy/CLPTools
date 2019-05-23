#
# Be sure to run `pod lib lint CLPTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CLPTools'
  s.version          = '1.0.0'
  s.summary          = 'A simple tool.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/clapnwhy/CLPTools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'clapnwhy' => '421822615@qq.com' }

   # s.source           = { :git => '/Users/clapn/CLPoschina/CLPTools', :tag => s.version.to_s }
  # s.source           = { :git => '/Users/caolangpeng/gitOsChina/CLPTools', :tag => s.version.to_s }
  s.source           = { :git => '/Users/caolangpeng/Documents/OsChina/CLPTools', :tag => s.version.to_s }
  # s.source           = { :git => 'https://github.com/clapnwhy/CLPTools.git', :tag => s.version.to_s }



  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CLPTools/Classes/**/*'
  
  #s.resource_bundles = {
      # 'CLPTools' => ['CLPTools/Assets/*.png']
      #'CLPTools' => ['CLPTools/Assets/*']
  #}

  s.public_header_files = 'CLPTools/Classes/**/*.h'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'Foundation', 'CoreGraphics', 'SystemConfiguration', 'MobileCoreServices', 'CFNetwork', 'QuartzCore'

  s.dependency 'AFNetworking', '~> 3.2.1'
  # s.dependency 'MBProgressHUD', '~> 1.1.0'
  # s.dependency 'SVProgressHUD', '~> 2.2.2'
  s.dependency 'CYLTabBarController', '~> 1.17.22'
  s.dependency 'ViewDeck', '~> 3.1.0'

  # , 'Cocoa'


end
