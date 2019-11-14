FROM alpine:3.10

COPY teapot /bin/teapot

ENTRYPOINT exec /bin/teapot
