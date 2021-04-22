# Build the Go Binary.
FROM golang:1.16 as build_shipa
ENV CGO_ENABLED 0
ARG VCS_REF

COPY . /shipa

WORKDIR /shipa
RUN go build -ldflags "-X main.build=${VCS_REF}"


# Run the Go Binary in Alpine.
FROM alpine:3.13
ARG BUILD_DATE
ARG VCS_REF
 COPY --from=build_shipa /shipa /shipa
WORKDIR /shipa
CMD ["./shipa"]