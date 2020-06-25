FROM golang:1.13-alpine AS build
ARG VERSION=v0.73.0
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GO111MODULE=on
RUN apk add --no-cache git \
 && apk add --no-cache ca-certificates

WORKDIR /go/src/github.com/gohugoio/hugo
RUN git clone https://github.com/gohugoio/hugo . && git checkout ${VERSION}
RUN go get github.com/magefile/mage
RUN mage install

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /go/bin/hugo /go/bin/hugo
WORKDIR /site
EXPOSE 1313
ENTRYPOINT ["/go/bin/hugo"]
CMD ["--help"]
