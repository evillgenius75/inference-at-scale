# Stage 1: Build the application
FROM golang:1.23.3-alpine AS builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .
RUN go build -o main cmd/main.go

# Stage 2: Create the final image
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/main ./main

# Install necessary packages (adjust as needed)
RUN apk add --no-cache curl

# Set environment variables (replace with your actual values)
ENV BASE_URL=""

# Expose the port
EXPOSE 8000

# Set the entrypoint
ENTRYPOINT ["./main"]
