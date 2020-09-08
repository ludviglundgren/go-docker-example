# Build binary
FROM golang:1.15.1-alpine AS builder

# Add packages
RUN apk update && apk add --no-cache make

WORKDIR /app

# Copy go mod and download packages
COPY go.mod go.sum ./
RUN go mod download

# Copy rest of code
COPY . .

# Build binary
RUN make build

# Final container
FROM alpine:3.12

WORKDIR /app

# Copy binary from builder step
COPY --from=builder /app/bin/server /app/server

ENTRYPOINT ["/app/server"]
