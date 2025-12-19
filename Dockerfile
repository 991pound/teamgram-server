FROM golang:1.21 AS build

WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .
RUN go build -o server ./cmd/server

FROM debian:stable-slim

WORKDIR /app
COPY --from=build /app/server .

EXPOSE 8080
CMD ["./server"]
