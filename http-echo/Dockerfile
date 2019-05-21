############################
# STEP 1 build executable binary
############################
# golang alpine 1.12
FROM golang:1.12-alpine as builder

# Install git + SSL ca certificates.
# Git is required for fetching the dependencies.
# Ca-certificates is required to call HTTPS endpoints.
RUN apk update && apk add --no-cache git ca-certificates tzdata && update-ca-certificates

# Fetch dependencies.
RUN go get -d -v github.com/jswank/http-echo-server

# Build the binary
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o /go/bin/http-echo-server github.com/jswank/http-echo-server

############################
# STEP 2 build a small image
############################
FROM scratch

# Import from builder.
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable
COPY --from=builder /go/bin/http-echo-server /app/http-echo-server

# Use an unprivileged user.
USER nobody

EXPOSE 7000
# Run the hello binary.
ENTRYPOINT ["/app/http-echo-server"]
