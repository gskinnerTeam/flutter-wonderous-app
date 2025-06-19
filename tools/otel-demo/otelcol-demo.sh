#!/usr/bin/env bash
# Requires otelcol on the path
# https://opentelemetry.io/docs/collector/installation/
# For example, for Macs:
# curl --proto '=https' --tlsv1.2 -fOL https://github.com/open-telemetry/opentelemetry-collector-releases/releases/download/v0.128.0/otelcol_0.128.0_darwin_amd64.tar.gz
# tar -xvf otelcol_0.128.0_darwin_amd64.tar.gz

# Once on the path, run this locally to see a log of spans from the demo
otelcol --config=./tools/otel-demo/otelcol-demo-config.yaml
