FROM golang:1.10-alpine

RUN apk add --no-cache bash build-base nodejs

ENV GOROOT=/usr/local/go-wasm
ADD src $GOROOT/src
ADD misc $GOROOT/misc
ADD test $GOROOT/test
RUN ln -s $GOROOT/misc/wasm/go_js_wasm_exec /usr/local/bin/go_js_wasm_exec

RUN echo "dev" > $GOROOT/VERSION
RUN cd $GOROOT/src && ./make.bash
ENV PATH=$GOROOT/bin:$PATH
RUN cd $GOROOT/test && go build run.go

ENV GOARCH=wasm
ENV GOOS=js
RUN go install -v std
RUN go test -short std
RUN cd $GOROOT/test && ./run -v
