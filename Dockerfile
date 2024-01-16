FROM golang:latest as builder

WORKDIR /SRC
ADD go.mod go.sum ./

RUN CGO_ENABLED=0 GOPROXY=https://goproxy.cn go mod download && go build -o ./app .

FROM apline
VOLUME /etc/godns.conf
COPY --from=builder /SRC/app /usr/bin/godns
ENTRYPOINT [ "/usr/bin/godns", "-c", "/etc/godns.conf" ]
