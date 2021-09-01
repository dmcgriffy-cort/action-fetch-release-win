
if ($Env:INPUT_FILE -eq $null) {
    echo  "Missing file input in the action"
    exit 1
}

echo "Input file: " $Env:INPUT_FILE

exit 0
