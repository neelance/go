#!/bin/bash
set -ex

env GOROOT=$PWD toolstash go install -v -toolexec=toolstash cmd

export PATH=$PWD/bin:$PATH
export GOOS=js
export GOARCH=wasm

cd test
./run -v
