platform :ios, '15.0'
use_frameworks!

target 'mehus-shop' do
  pod 'IQKeyboardManagerSwift'
  pod 'ActionKit', '~> 2.5.2'
  pod 'Alamofire'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Kingfisher', '~> 7.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |bc|
       bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
    end
  end
end
