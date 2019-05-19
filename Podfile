platform :ios, '10.3'
use_frameworks!

workspace 'UpComingMovies'

xcodeproj 'UpComingMovies.xcodeproj'
xcodeproj 'UpcomingMoviesApi/UpcomingMoviesApi.xcodeproj'

def shared_pods
  xcodeproj 'UpComingMovies.xcodeproj'
	pod 'Alamofire', '~> 4.7'
	pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'SVProgressHUD'
  pod 'RxSwift', '~> 4.5'
  pod 'RxCocoa', '~> 4.1'
  pod 'RxDataSources', '~> 3.1'
  pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
  pod 'Kingfisher', '5.1.1'
  pod 'Firebase/Core'
end

def quality_pods
  pod 'SwiftLint'
end  

def test_pods
  pod 'OHHTTPStubs/Swift'
end  

# Pods for UpComingMovies
target 'UpComingMovies' do
  shared_pods
  quality_pods
  test_pods
  target 'UpComingMoviesTests' do
    inherit! :search_paths
  end
  
  target 'SdkManagerTests' do
    inherit! :search_paths
  end
end

target 'UpcomingMoviesApi' do 
  xcodeproj 'UpcomingMoviesApi/UpcomingMoviesApi.xcodeproj'
  test_pods
  
  target 'UpcomingMoviesApiTests' do
    test_pods
  end
  
#  target 'ParamsTests' do
#    test_pods
#  end
  
end

#post_install do |installer|
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['SWIFT_VERSION'] = '4.2'
#        end
#    end
#end
