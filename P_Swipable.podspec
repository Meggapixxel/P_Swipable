#
# Be sure to run `pod lib lint P_Swipable.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'P_Swipable'
  s.version          = '0.1.0'
  s.summary          = 'P_Swipable is the library to config swipe action to expand or collapse UIView'
  s.description      = <<-DESC
P_Swipable is the library to config swipe action to expand or collapse UIView.
Target view can be place at bottom (swipeDirection = .up) or top (swipeDirection = .down).
                       DESC

  s.homepage         = 'https://github.com/Meggapixxel/P_Swipable'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Meggapixxel' => 'zhydenkodeveloper@gmail.com' }
  s.source           = { :git => 'https://github.com/Meggapixxel/P_Swipable.git', :tag => s.version.to_s }
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.source_files = 'Source/**/*'
  s.frameworks = 'UIKit'
  
end
