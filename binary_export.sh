# DERIVED_DATA_PATH=`xcodebuild -project "UpComingMovies.xcodeproj" -scheme "UpcomingMoviesApi" -showBuildSettings | grep OBJROOT | #cut -d "=" -f 2 - | sed 's/^ *//'`
# DERIVED_DATA_PATH=`dirname "$DERIVED_DATA_PATH"`
# echo "Found derived data path: $DERIVED_DATA_PATH"

rm -r "$@.xcframework"

xcodebuild -workspace 'UpComingMovies.xcworkspace' archive -scheme "$@" -sdk iphoneos -archivePath './Build/iphone'

xcodebuild -workspace 'UpComingMovies.xcworkspace' archive -scheme "$@" -sdk iphonesimulator -archivePath './Build/iphonesimulator'

xcodebuild -create-xcframework -output "$@".xcframework -framework "./Build/iphone.xcarchive/Products/Library/Frameworks/$@.framework"  -framework "./Build/iphonesimulator.xcarchive/Products/Library/Frameworks/$@.framework"