function go_test
    set -l test_dir $argv[1]
    if test -z $test_dir
        echo "Error: missing test directory argument."
        return 1
    end
    go test -p 1 -count 1 -coverpkg=./... -coverprofile=bin/coverage.out $test_dir
end
