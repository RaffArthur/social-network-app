platform :ios, '13.0'

use_frameworks!

target 'Social_Network' do
  pod 'SnapKit', '~> 5.0.0'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'RealmSwift'
  pod 'IQKeyboardManagerSwift'
  
  target 'Social_NetworkTests' do
    end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
