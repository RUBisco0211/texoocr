#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIGURATION="${CONFIGURATION:-Debug}"
CODE_SIGNING_ALLOWED="${CODE_SIGNING_ALLOWED:-NO}"
BUILD_DIR="${BUILD_DIR:-$ROOT_DIR/build}"
PRODUCTS_DIR="$BUILD_DIR/Products/$CONFIGURATION"
DERIVED_DATA_DIR="$BUILD_DIR/DerivedData"
APP_PATH="$PRODUCTS_DIR/TexoOCR.app"

echo "Building TexoOCR ($CONFIGURATION)..."

xcodebuild \
    -project "$ROOT_DIR/TexoOCR.xcodeproj" \
    -scheme TexoOCR \
    -configuration "$CONFIGURATION" \
    -destination "platform=macOS" \
    -derivedDataPath "$DERIVED_DATA_DIR" \
    CONFIGURATION_BUILD_DIR="$PRODUCTS_DIR" \
    CODE_SIGNING_ALLOWED="$CODE_SIGNING_ALLOWED" \
    build

echo
echo "Built app: $APP_PATH"
