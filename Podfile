# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


def test_pods
  pod 'Quick'
  pod 'Nimble'
  pod 'Fakery'
  pod 'Mocker'
end

target 'AlteaCareTest' do
  use_frameworks!

  pod 'Kingfisher'
  pod 'Alamofire'
  pod 'IQKeyboardManager'
  pod 'ReachabilitySwift'

  target 'AlteaCareTestTests' do
    inherit! :search_paths
    test_pods
  end

end
