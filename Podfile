platform :ios, '10.3'
use_frameworks!

def shared_pods
	pod 'Alamofire', '~> 4.7'
	pod 'AlamofireObjectMapper', '~> 4.0'
  pod 'SVProgressHUD'
  pod 'RxSwift',    '~> 3.0'
  pod 'RxCocoa',    '~> 3.0'
  pod 'RxDataSources', '~> 1.0'
  pod 'SwiftLint'
  pod 'Fabric', '~> 1.7.2'
  pod 'Crashlytics', '~> 3.9.3'
  pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
  pod 'Kingfisher', '~> 4.0'
end

# Pods for UpComingMovies
target 'UpComingMovies' do
  shared_pods

  target 'UpComingMoviesTests' do
    inherit! :search_paths

  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
