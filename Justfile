# Justfile for Munition project

wasm_target := "wasm32-unknown-unknown"
wasm_out := "test/fixtures"

# Default: show available commands
default:
    @just --list

# Build test WASM modules
build-wasm:
    cd test_wasm && cargo build --target {{wasm_target}} --release
    mkdir -p {{wasm_out}}
    cp test_wasm/target/{{wasm_target}}/release/munition_test_wasm.wasm {{wasm_out}}/test.wasm
    @echo "Built test WASM to {{wasm_out}}/test.wasm"

# Clean WASM build artifacts
clean-wasm:
    cd test_wasm && cargo clean
    rm -f {{wasm_out}}/test.wasm

# Get dependencies
deps:
    mix deps.get

# Compile the project
compile:
    mix compile

# Run all tests
test: build-wasm
    mix test

# Run only unit tests (no WASM required)
test-unit:
    mix test --exclude integration

# Run only integration tests (requires WASM)
test-integration: build-wasm
    mix test --only integration

# Run benchmarks
bench: build-wasm
    mix run bench/startup_bench.exs

# Format all code
fmt:
    mix format
    cd test_wasm && cargo fmt

# Check formatting
fmt-check:
    mix format --check-formatted
    cd test_wasm && cargo fmt --check

# Run linters
lint:
    mix compile --warnings-as-errors
    mix credo --strict
    cd test_wasm && cargo clippy -- -D warnings

# Run dialyzer
dialyzer:
    mix dialyzer

# Full check (format, lint, test)
check: fmt-check lint test

# Generate documentation
docs:
    mix docs

# Interactive shell
iex:
    iex -S mix

# Clean all build artifacts
clean:
    mix clean
    just clean-wasm

# Setup development environment
setup:
    just deps
    just build-wasm
    @echo "Development environment ready!"
