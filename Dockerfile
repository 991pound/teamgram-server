FROM golang:1.21 AS build

WORKDIR /app
COPY . .

RUN go mod download
RUN go build -o server ./cmd/server

FROM debian:stable-slim

WORKDIR /app
COPY --from=build /app/server .

EXPOSE 8080
CMD ["./server"]
