Pod::Spec.new do |s|
  s.name         = 'QcartSDK'
  s.version      = '1.0.0'
  s.summary      = 'Qcart iOS SDK'
  s.homepage     = 'https://github.com/comoquiero/qcart-sdk-ios'
  s.license      = { :type => 'MIT' }
  s.author       = { 'Qcart' => 'dev@qcart.com' }
  s.source       = { :git => 'https://github.com/comoquiero/qcart-sdk-ios.git', :tag => 'main' }
  s.platform     = :ios, '15.0'
  s.swift_version = '5.0'
  s.source_files = 'Sources/**/*'  # adjust based on repo structure
end