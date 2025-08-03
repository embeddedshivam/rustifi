# Build stage with musl for static linking
FROM rustlang/rust:nightly-slim as builder

WORKDIR /app

RUN apt-get update && apt-get install -y musl-tools pkg-config build-essential

# Set target to musl
RUN rustup target add x86_64-unknown-linux-musl

COPY . .

# Build statically-linked binary
RUN cargo build --release --target x86_64-unknown-linux-musl

# Final minimal image
FROM scratch

WORKDIR /app

# Copy statically-linked binary from build stage
COPY --from=builder /app/target/x86_64-unknown-linux-musl/release/rustifi /app/rustifi

ENTRYPOINT ["/app/rustifi"]

