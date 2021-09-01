
if ($INPUT_FILE -eq $null) {
    echo  "Missing file input in the action"
    exit 1
} endif

echo "Input file: " ${{ inputs.file }}

exit 0
