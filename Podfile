platform :ios, '11.0'

use_frameworks!

target 'Data' do
  # Pods for Data
  target 'DataTests' do
    # Pods for testing
  end

end

target 'Domain' do
end

target 'Presentation' do
  target 'PresentationTests' do
  end
end

target 'UI' do

  target 'UITests' do
    pod 'Nimble', '~> 9.0.1'
    pod 'Nimble-Snapshots', '~> 9.1.0'
    pod 'Quick' , '~> 3.1.2'
  end

end

target 'Infra' do
  use_frameworks!

  pod 'Alamofire', '5.4.3'

  target 'InfraTests' do
    # Pods for testing
  end

end

target 'UseCaseIntegrationTests' do
    pod 'Alamofire', '5.4.3'
end

target 'Main' do
  target 'MainTests' do
  end
end
