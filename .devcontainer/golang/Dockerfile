FROM golang:1.22-alpine as builder

ARG TARGETPLATFORM
ARG TARGETARCH
RUN echo building for "$TARGETPLATFORM"

# Install git
RUN apk add --no-cache git

WORKDIR /workspace

RUN git clone https://github.com/livekit/livekit.git /livekit