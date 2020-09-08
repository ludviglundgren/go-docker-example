FROM golang:1.15.1-alpine3.12 AS builder

WORKDIR /app

COPY go.mod go.sum .

RUN go mod download

COPY . .

RUN make build

FROM alpine:3.12 AS 

WORKDIR /app

COPY --from=builder /app/bin/server /app/server

RUN ["/app/server"]
