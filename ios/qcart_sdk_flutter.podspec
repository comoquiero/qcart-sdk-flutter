Pod::Spec.new do |s|
  s.name             = 'qcart_sdk_flutter'
  s.version          = '0.0.1'
  s.summary          = 'Flutter wrapper around the native Qcart SDK.'
  s.description      = <<-DESC
Qcart Flutter plugin that bridges to the native Qcart iOS SDK and Android SDK.
  DESC
  s.homepage         = 'https://github.com/qcart/qcart-sdk-flutter'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Qcart' => 'dev@qcart.com' }
  s.source           = { :path => '.' }

  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform         = :ios, '13.0'

  # 👇 Add dependency on your iOS SDK (assuming it’s a CocoaPod or local podspec)
  s.dependency 'QcartSDK', :git => 'https://github.com/qcart/qcart-sdk-ios.git'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'
  }
  s.swift_version = '5.0'
end