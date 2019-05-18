platform :ios, '10.3'
use_frameworks!

def shared_pods
	pod 'Alamofire', '~> 4.7'
	pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'SVProgressHUD'
  pod 'RxSwift', '~> 4.5'
  pod 'RxCocoa', '~> 4.1'
  pod 'RxDataSources', '~> 3.1'
  pod 'SwiftLint'
  pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
  pod 'Kingfisher', '5.1.1'
  pod 'Firebase/Core'
  pod 'OHHTTPStubs/Swift'
end

# Pods for UpComingMovies
target 'UpComingMovies' do
  shared_pods

  target 'UpComingMoviesTests' do
    inherit! :search_paths

  end

end

#post_install do |installer|
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['SWIFT_VERSION'] = '4.2'
#        end
#    end
#end
