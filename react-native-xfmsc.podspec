require 'json'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name           = package['name']
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = package['homepage']
  s.source         = { :git => 'https://www.npmjs.com/package/react-native-xfmsc', :tag => s.version }

  s.requires_arc   = true
  s.platform       = :ios, '8.0'

  s.source_files   = "ios/**/*.{h,m}"

  s.frameworks     = 'SystemConfiguration', 'CoreTelephony', 'QuartzCore', 'CoreLocation', 'CoreGraphics', 'UIKit', 'Foundation', 'AVFoundation', 'AddressBook', 'AudioToolbox'
  s.library        = 'z'
  s.vendored_framework = 'ios/iflyMSC.framework'
  
  s.dependency 'React'
end
