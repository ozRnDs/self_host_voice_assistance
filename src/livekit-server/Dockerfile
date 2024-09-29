FROM golang:1.22-alpine as builder

ARG TARGETPLATFORM
ARG TARGETARCH
RUN echo building for "$TARGETPLATFORM"

# Install git
RUN apk add --no-cache git

WORKDIR /workspace

# Clone the LiveKit repository
RUN git clone https://github.com/livekit/livekit.git

WORKDIR /workspace/livekit
RUN go mod download

# Build the livekit-server binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=$TARGETARCH GO111MODULE=on go build -a -o livekit-server ./cmd/server

# Final stage
FROM alpine

# Install bash for script support
RUN apk add --no-cache bash coreutils

# Copy the livekit-server binary from the builder stage
COPY --from=builder /workspace/livekit/livekit-server /livekit-server

# Add the script that generates the config.yaml file
COPY generate_config.sh /generate_config.sh

# Ensure the script has executable permissions
RUN chmod +x /generate_config.sh

# Set the entrypoint to run livekit-server
ENTRYPOINT ["/livekit-server"]
