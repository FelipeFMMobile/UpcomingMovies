platform :ios, '13.0'
use_frameworks!

workspace 'UpComingMovies'

project 'UpComingMovies.xcodeproj'
project 'UpcomingMoviesApi/UpcomingMoviesApi.xcodeproj'

def shared_pods
  project 'UpComingMovies.xcodeproj'
	pod 'Alamofire', '~> 4.7'
	pod 'AlamofireObjectMapper', '~> 5.2'
  pod 'SVProgressHUD'
  pod 'RxSwift', '~> 4.5'
  pod 'RxCocoa', '~> 4.1'
  pod 'RxDataSources', '~> 3.1'
  pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
  pod 'Kingfisher', '5.2.0'
  pod 'Firebase/Core'
  pod 'Firebase/Crashlytics'
  # (Recommended) Pod for Google Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Performance'
end

def quality_pods
  pod 'SwiftLint'
end  
# Pods for PodTest
def test_pods
  pod 'OHHTTPStubs/Swift'
  pod 'Quick'
  pod 'Nimble'
end  

# Pods for UpComingMovies
target 'UpComingMovies' do
  shared_pods
  target 'UpComingMoviesTests' do
    inherit! :search_paths
    test_pods
  end
  
  target 'SdkManagerTests' do
    inherit! :search_paths
  end

  target 'UpComingMoviesKIFTests' do
    inherit! :search_paths
    test_pods
    pod 'KIF'
  end
end

# Pods for UpComingMoviesApi - Framework - Setup to work all in same Workplace
target 'UpcomingMoviesApi' do 
  project 'UpcomingMoviesApi/UpcomingMoviesApi.xcodeproj'
  test_pods
  quality_pods
  target 'UpcomingMoviesApiTests' do
    test_pods
  end
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
    end
  end
end
