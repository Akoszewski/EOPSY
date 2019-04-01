function assert ()
{
    if [ "`find "folder 1" "folder 2"`" == "$output" ]
    then
        echo "Test $count OK"
    else
        failed="true"
        echo "Test $count FAILED"
        if [ "$arg" == "-a" ]
        then
            echo "Output is: `find "folder 1" "folder 2"`"
            echo "Should be: $output"
        fi
    fi
    count=$((count + 1))
}

count=0
arg="$1"

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/file inside deep 1
folder 1/folder inside/file inside deep 2
folder 1/file inside 2
folder 1/file inside 1
folder 2
folder 2/file inside.txt"
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/FILE INSIDE DEEP 1
folder 1/folder inside/file inside deep 2
folder 1/FILE INSIDE 1
folder 1/file inside 2
folder 2
folder 2/file inside.txt"
./modify -u "folder 1/file inside 1" "folder 1/folder inside/file inside deep 1"
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/file inside deep 1
folder 1/folder inside/file inside deep 2
folder 1/file inside 2
folder 1/file inside 1
folder 2
folder 2/file inside.txt"
./modify -l "folder 1/FILE INSIDE 1" "folder 1/folder inside/FILE INSIDE DEEP 1"
assert

./setup.sh
output="folder 1
folder 1/file
folder 1/folder inside
folder 1/folder inside/file inside deep 1
folder 1/folder inside/file inside deep 2
folder 1/file inside 2
folder 2
folder 2/file"
./modify -r "s/\([a-z]*\).*/\1/" "folder 1/file inside 1" "folder 2/"
assert


./setup.sh
output="folder 1
folder 1/file
folder 1/folder inside
folder 1/folder inside/file inside deep 1
folder 1/folder inside/file inside deep 2
folder 1/file inside 2
folder 2
folder 2/file inside.txt"
./modify "s/\([a-z]*\).*/\1/" "folder 1/file inside 1" "folder 2/"
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/file inside deep 1
folder 1/folder inside/file inside deep 2
folder 1/file inside 2
folder 1/file inside 1
folder 2
folder 2/file inside.txt"
./modify -r "folder 1"
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/FILE INSIDE DEEP 1
folder 1/folder inside/FILE INSIDE DEEP 2
folder 1/FILE INSIDE 2
folder 1/FILE INSIDE 1
folder 2
folder 2/file inside.txt"
./modify -r -u "folder 1"
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/FILE INSIDE DEEP 2
folder 1/folder inside/file inside deep 1
folder 1/FILE INSIDE 2
folder 1/FILE INSIDE 1
folder 2
folder 2/file inside.txt"
./modify -u "folder 1/file inside 1" "folder 1/file inside 2" "folder 1/folder inside/file inside deep 2"
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/FILE INSIDE DEEP 1
folder 1/folder inside/FILE INSIDE DEEP 2
folder 1/FILE INSIDE 2
folder 1/FILE INSIDE 1
folder 2
folder 2/file inside.txt"
./modify -r -u "./folder 1/"*
assert

./setup.sh
output="folder 1
folder 1/folder inside
folder 1/folder inside/file inside deep 1
folder 1/folder inside/file inside deep 2
folder 1/FILE INSIDE 2
folder 1/FILE INSIDE 1
folder 2
folder 2/file inside.txt"
./modify -u "./folder 1/"*
assert

if [ "$failed" == "true" ]
then
    echo "Some tests failed"
else
    echo "All tests passed"
fi