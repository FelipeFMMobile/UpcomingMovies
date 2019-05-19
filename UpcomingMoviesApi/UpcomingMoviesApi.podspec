#
# Be sure to run `pod lib lint msawsuploader.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UpcomingMoviesApi'
  s.version          = '0.0.1'
  s.summary          = 'UpcomingMoviesApi for connections managers'
  s.swift_version = '4.2'

  s.description      = <<-DESC
  UpcomingMoviesApi is a api to serve a control api for project UpcomingMovies
            DESC
  s.homepage         = 'https://github.com/FelipeFMMobile/UpcomingMoviesApi'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'FelipeMenezes' => 'fmmobile@live.com' }
  s.source           = { :git => 'https://github.com/FelipeFMMobile/UpcomingMoviesApi.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.3'

  s.source_files = 'UpcomingMoviesApi/UpcomingMoviesApi/**/*.{swift}'

  # s.public_header_files = 'Pod/Classes/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
  s.dependency 'RxKeyboard'
  s.dependency 'msawsuploader'
  s.dependency 'CPF-CNPJ-Validator'
  s.dependency 'Atributika'
end
