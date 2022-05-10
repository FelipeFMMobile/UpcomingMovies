platform :ios, '11.0'
use_frameworks!

workspace 'UpComingMovies'

project 'UpComingMovies.xcodeproj'
project 'UpcomingMoviesApi/UpcomingMoviesApi.xcodeproj'

def shared_pods
  project 'UpComingMovies.xcodeproj'
  pod 'SVProgressHUD'
  pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
  pod 'Kingfisher', '~> 6.3.0'
  pod 'SwiftGen', '~> 6.0'
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
  inhibit_all_warnings!
  shared_pods
  quality_pods
  target 'UpComingMoviesTests' do
    inherit! :search_paths
    test_pods
  end

  target 'UpComingMoviesKIFTests' do
    inherit! :search_paths
    test_pods
    pod 'KIF'
  end

  target 'UpComingMoviesUITests' do
    test_pods
  end
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
      config.build_settings['SWIFT_SUPPRESS_WARNINGS'] = "YES"
    end
  end
end
