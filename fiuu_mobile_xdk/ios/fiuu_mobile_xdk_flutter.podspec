#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fiuu_mobile_xdk_flutter.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fiuu_mobile_xdk_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Fiuu Mobile Payment for Flutter'
  s.description      = <<-DESC
Fiuu Mobile Payment for Flutter
                       DESC
  s.homepage         = 'https://github.com/FiuuPayment/Mobile-XDK-Fiuu_Flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'Fiuu' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'fiuu-mobile-xdk-cocoapods', '~> 3.34.2'
  # s.resource = 'MOLPayXDK.bundle'
  # s.vendored_frameworks = 'MOLPayXDK.framework'
  s.static_framework = true
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386 arm64' }
end
