# Upcoming Movies
<img src = "https://user-images.githubusercontent.com/3279991/161863557-7281beb9-157f-403c-9fd3-cfda5bc1c6d2.png" width=200px />

A sample project that explore Swift techniques for iOS development.

[![Swift](https://img.shields.io/badge/Swift-5.5-red)](https://img.shields.io/badge/Swift-5.5-red)
[![XCode](https://img.shields.io/badge/Xcode-13.1-blue)](https://img.shields.io/badge/Xcode-13.1-blue)
[![Platforms](https://img.shields.io/badge/Plataform-iOS-lightgrey)](https://img.shields.io/badge/Plataform-iOS-lightgrey)
[![CocoaPods Compatible](https://img.shields.io/badge/cocoapods-1.11.2-green)](https://img.shields.io/badge/cocoapods-1.11.2-green)
[![iOS Version](https://img.shields.io/badge/Version-iOS%2015-orange)](https://img.shields.io/badge/Version-iOS%2015-orange)
[![Bitrise](https://img.shields.io/badge/CI-Bitrise-green)](https://img.shields.io/badge/CI-Bitrise-green)
[![Build Status](https://app.bitrise.io/app/143a2abe7a76121d/status.svg?token=3LB_ifoJAaSuz6nnZ6yAaw&branch=develop)](https://app.bitrise.io/app/143a2abe7a76121d)

A project that presents the list of upcoming movies, using Api <img src = "https://www.themoviedb.org/assets/2/v4/logos/v2/blue_short-8e7b30f73a4020692ccca9c88bafe5dcb6f8a62a4c6bc55cd9ba82bb2cd95f6c.svg" width=100px /> Api

## Getting Started

### Installing

Install Cocoapods v1.11.2

Clone the repository and run:
```
pod install
```

### Overview

# Architeture

* MVVM+[Coordinator](https://github.com/FelipeFMMobile/UpcomingMovies/wiki/Coordinator) with Networking

* SwiftUI Version

# Framework

* A abstraction network framework created exported as XCFramework
[UpcomingMoviesApi](https://github.com/FelipeFMMobile/UpcomingMovies/wiki/UpcomingMoviesApi)

# Quality

## Testing
* XCTest
* XCUITests
* KIF (for UI Testing)
* Swiftlint

## Coverage
* 100% over ViewModel's MVVM 
* Coverage checked on CI Control 
* Bitrise

# Swift & UX

* SwiftUI
* Async / Await
* DarkMode 
<image src="https://user-images.githubusercontent.com/3279991/156679793-150e1dbb-8a06-4592-8b62-5d35123b8321.png" width="150px"/> <image src="https://user-images.githubusercontent.com/3279991/156680343-fa1f95f7-b15c-4b3c-82ee-eef5fa504cb1.png" width="150px"/>
* Acessibility 
preview: https://user-images.githubusercontent.com/3279991/156943301-42dddfd3-5e23-4bf5-94b5-a9d4a7bf0600.mp4

## Other dependencies

```
pod 'Alamofire', '~> 4.7'
pod 'AlamofireObjectMapper', '~> 5.2'
pod 'SVProgressHUD'
pod 'RxSwift', '~> 4.5'
pod 'RxCocoa', '~> 4.1'
pod 'RxDataSources', '~> 3.1'
pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
pod 'Kingfisher', '~> 6.3.0'
pod 'SwiftGen', '~> 6.0'
pod 'Firebase/Core'
pod 'Firebase/Crashlytics'
pod 'Firebase/Analytics'
pod 'Firebase/Performance'
pod 'SwiftLint'
pod 'OHHTTPStubs/Swift'
pod 'Quick'
pod 'Nimble'
```

## Authors

Felipe Menezes, SÊnior iOS Developer, Software Enginieer
[![Swift](https://img.shields.io/badge/Linkedin-profile-blue)](https://www.linkedin.com/in/felipe-menezes-dev)


## Version History
* 2022 
  * Swift update, Async/Await, SwiftUI
* 2021
  * api improvement, code revision, CI improvement  
* 2019
  * get started project, using MMV + RXSwift

## License

This project is licensed under the MIT License

