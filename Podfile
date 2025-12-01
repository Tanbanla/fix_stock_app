# Thêm dòng này ngay sau comment đầu tiên
platform :ios, '13.0'

target 'BIVN' do
  use_frameworks!
  
  pod 'Moya', '~> 15.0'
  pod 'R.swift'
  pod 'Kingfisher', '~> 7.9'
  pod 'netfox'
  pod 'DropDown', '2.3.13'
  pod 'SnapKit'
  pod 'IQKeyboardManagerSwift'
  pod 'Localize-Swift', '~> 3.2'

  target 'BIVNTests' do
    inherit! :search_paths
  end

  target 'BIVNUITests' do
    # Thêm $(inherited) để fix warning
  end
  
  post_install do |installer|
    installer.generated_projects.each do |project|
      project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
      end
    end
  end
end