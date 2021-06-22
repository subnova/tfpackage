#!/usr/bin/env sh

export HOME=$TEST_TMPDIR

TFLINT_BINARY=$(find $RUNFILES_DIR -name tflint)
if [[ -z TFLINT_BINARY ]]
then
    TFLINT_BINARY=$(find $RUNFILES_DIR -name 'tflint.exe')
fi

if [[ -z TFLINT_BINARY ]]
then
    echo "unable to find tflint binary, did you include it as a data dependency?"
    exit 1
fi

echo Using tflint binary $TFLINT_BINARY

TFDIR=$(dirname `find . -name '*.tf' | head -1`)

cd $TFDIR
$TFLINT_BINARY --init --no-color
$TFLINT_BINARY --no-color
