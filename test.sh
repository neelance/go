#!/bin/bash
set -ex

# cd src/cmd/compile/internal/ssa/gen
# go run *.go
# cd -

env GOROOT=$PWD toolstash go install -v -toolexec=toolstash cmd

# env GOOS=js GOARCH=wasm GOSSAFUNC=$SSA ./bin/go build -gcflags '-l -c 1' runtime/internal/sys
env GOOS=js GOARCH=wasm GOSSAFUNC=$SSA ./bin/go build -a -gcflags '-l -c 1' -o ~/src/test2/test.wasm test2
# env GOOS=js GOARCH=wasm GOSSAFUNC=$SSA ./bin/go test -c -a -gcflags '-l -c 1' -o ~/src/test2/test.wasm go/printer

# wasm2wast --no-check ~/src/test2/test.wasm > ~/src/test2/test.wat
# wast2wasm ~/src/test2/test.wat > /dev/null

go_js_wasm_exec ~/src/test2/test.wasm -test.v -test.short -test.run=TestLargeStringWrites

# cd ~/src/test2/
# wasm-opt test.wasm -o test.wasm --debuginfo
# wasm2wast test.wasm > test.wat

# wasm-opt test.wasm -o test-opt.wasm --debuginfo -Oz
# wasm2wast test-opt.wasm > test-opt.wat

# diff -w -u test.wat test-opt.wat > wat.diff
