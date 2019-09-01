
function convert_file {
  local xccovarchive_file="$1"
  local file_name="$2"
  local not_covereged="([0-9][0-9]*): 0.*"
  local covereged="([0-9][0-9]*): [1-9].*"
  echo "  <file path=\"$file_name\">"
  let total=0
  TEMPFILE="/tmp/$$.tmp"
  echo 0 > $TEMPFILE
  xcrun xccov view --file "$file_name" "$xccovarchive_file" | 
  while read -r line_cover; do
    #echo "$line_cover"
      if [[ "$line_cover" =~ $covereged ]]; then 
        #echo "Covereged"
        total=$[$total +1]
      fi 
      if [[ "$line_cover" =~ $not_covereged ]]; then 
        #echo "Not Coverage "
        total=$[$total +1]
      fi
      echo $total > $TEMPFILE
  done
  result=$[$(cat $TEMPFILE)]
  echo " Total lines: $result"
  unlink $TEMPFILE
    # sed -n '
    # s/^ *\([0-9][0-9]*\): 0.*$/    <lineToCover lineNumber="\1" covered="false"\/>/p;
    # s/^ *\([0-9][0-9]*\): [1-9].*$/    <lineToCover lineNumber="\1" covered="true"\/>/p
    # '
  
  echo '  </file>'
}

function xccov_to_generic {
  echo '<coverage version="1">'
  for xccovarchive_file in "$@"; do
    xcrun xccov view --file-list "$xccovarchive_file" | while read -r file_name; do
    local pattern="(.swift)"
    # if [[ $file_name =~ $pattern ]]; then
    #     echo "Valid file"
    # else
    #     echo "Invalid file $file_name"
    # fi
    if [[ $file_name =~ $pattern ]]; then
        #echo "$file_name"
        convert_file "$xccovarchive_file" "$file_name"
    fi
    done
  done
  echo '</coverage>'
}

#Build
#xcodebuild -workspace UpComingMovies.xcworkspace/ -scheme UpComingMovies -derivedDataPath Build/ -enableCodeCoverage YES clean build test CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO -quiet -destination 'platform=iOS Simulator,OS=12.2,name=iPhone 6s'

#View
#xcrun xccov view --json Build/Logs/Test/*.xcresult/*_Test/action.xccovreport > report.json

#"(?i)(ViewModel)(.swift|.docx|.pdf)$"

#xccov_to_generic "$@" > test.xml

xccov_to_generic Build/Logs/Test/*.xcresult/*_Test/*.xccovarchive > test.xml
