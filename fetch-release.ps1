
if ($Env:INPUT_FILE -eq $null) {
    echo  "Missing file input in the action"
    exit 1
}

if ($Env:GITHUB_REPOSITORY -eq $null) {
  echo "Missing GITHUB_REPOSITORY env variable"
  exit 1
}

$REPO=$Env:GITHUB_REPOSITORY
if ($Env:INPUT_REPO -ne $null -and $env:INPUT_REPO -ne "") {
  $REPO=$INPUT_REPO
}

# Optional target file path
$TARGET=$Env:INPUT_FILE
if ($Env:INPUT_TARGET -ne $null -and $Env:INPUT_TARGET -ne "") {
  $TARGET=$Env:INPUT_TARGET
}

# Optional personal access token for external repository
$TOKEN=$Env:GITHUB_TOKEN
if ($Env:INPUT_TOKEN -ne $null -and $Env:INPUT_TOKEN -ne "") {
  $TOKEN=$Env:INPUT_TOKEN
}

echo "Input file: $Env:INPUT_FILE"
echo "GitHub Token: $Env:GITHUB_TOKEN"
echo "Input Token: $Env:INPUT_TOKEN"
echo "Token: $TOKEN"
echo "GitHub repo: $Env:GITHUB_REPOSITORY"
echo "Repo: $REPO"
echo "Version: $Env:INPUT_VERSION"

$API_URL="https://api.github.com/repos/$REPO"
if ($TOKEN -ne $null) {
    $HEADER="-H """"Authorization: token $TOKEN"""""
}
echo "API URL: $API_URL"
echo "Header: $HEADER"
$RELEASE_DATA=$(curl $HEADER "$API_URL/releases/$Env:INPUT_VERSION")
echo $RELEASE_DATA
$MESSAGE=$(echo "$RELEASE_DATA" | & "$Env:GITHUB_ACTION_PATH\bin\jq-win64.exe" -r ".message")

echo "Message $MESSAGE"

exit 0
