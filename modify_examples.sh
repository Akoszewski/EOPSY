#!/bin/bash

touch "test 1"

./modify -h
echo "---------------"
./modify -u "test 1"
echo "---------------"
./modify -l "TEST 1"
echo "---------------"
./modify "s/\([a-z]*\).*/\1/" "test 1" # deletes other words in filename
echo "---------------"

rm test*
rm TEST*