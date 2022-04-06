
patternFiles="(ViewModel)(.swift)"

function coverage_file {
  local xccovarchive_file="$1"
  local file_name="$2"
  local not_covereged="([0-9][0-9]*): 0.*"
  local covereged="([0-9][0-9]*): [1-9].*"
  let totalLines=0
  let coveraged=0
  let cover=0
  TEMPFILE="/tmp/$$.tmp"
  echo 0 > $TEMPFILE
  xcrun xccov view --file "$file_name" "$xccovarchive_file" | 
  while read -r line_cover; do
      if [[ "$line_cover" =~ $covereged ]]; then 
        totalLines=$[$totalLines +1]
        coverage=$[$coverage +1]
      fi 
      if [[ "$line_cover" =~ $not_covereged ]]; then 
        totalLines=$[$totalLines +1]
      fi
      if [[ $totalLines > 0 ]]; then
        cover=$(echo "$[$coverage]/$[$totalLines]" | bc -l)
      fi
      echo $cover > $TEMPFILE
  done
  result=$(cat $TEMPFILE)
  #echo " Coveraged for $file_name: $result"
  unlink $TEMPFILE
}

function getCoverage {
  local testPath="$2" #"Build/Logs/Test/*.xcresult/*_Test/*.xccovarchive"
  local fileCount=0
  local sumCoverage=0
  local averageCoverage=0
  local result
  TEMPFILE="/tmp/$$.tmp"
  echo 0 > $TEMPFILE
  for xccovarchive_file in $testPath; do
    xcrun xccov view --file-list "$xccovarchive_file" | while read -r file_name; do
    local pattern="$1"
    if [ "$1" ]; then
      if [[ $file_name =~ $pattern ]]; then
          coverage_file "$xccovarchive_file" "$file_name"
          #echo $result
          fileCount=$(echo $fileCount +1 | bc -l)
          sumCoverage=$(echo "$sumCoverage+$result" | bc -l)
          #echo "$sumCoverage / $fileCount"
          averageCoverage=$(echo "$sumCoverage/$fileCount" | bc -l)
          echo $averageCoverage > $TEMPFILE
      fi
    fi
    done
  done
  averageCoverage=$(cat $TEMPFILE)
  percent=$(echo "scale=0; $averageCoverage*100" | bc)
  echo $(echo "$percent")
  #echo "Total coverage: $percent% for '$@' pattern files"
}

#Build
#xcodebuild -workspace UpComingMovies.xcworkspace/ -scheme UpComingMovies -derivedDataPath Build/ -enableCodeCoverage YES clean build test CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO -quiet -destination 'platform=iOS Simulator,OS=12.2,name=iPhone 6s'

#View
#xcrun xccov view --json Build/Logs/Test/*.xcresult/*_Test/action.xccovreport > report.json

#"(?i)(ViewModel)(.swift|.docx|.pdf)$"

#xccov_to_generic "$@" > test.xml

getCoverage $patternFiles $@
