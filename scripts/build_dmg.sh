#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${BUILD_DIR:-$ROOT_DIR/build}"
CONFIGURATION="${CONFIGURATION:-Release}"
CODE_SIGNING_ALLOWED="${CODE_SIGNING_ALLOWED:-NO}"
SKIP_BUILD="${SKIP_BUILD:-NO}"
APP_NAME="TexoOCR"
APP_PATH="$BUILD_DIR/Products/$CONFIGURATION/$APP_NAME.app"
DIST_DIR="${DIST_DIR:-$BUILD_DIR/Dist}"
STAGING_DIR="$BUILD_DIR/DMG"

VERSION="$(
    xcodebuild \
        -project "$ROOT_DIR/TexoOCR.xcodeproj" \
        -scheme TexoOCR \
        -configuration "$CONFIGURATION" \
        -showBuildSettings 2>/dev/null |
        awk '/MARKETING_VERSION =/ { print $3; exit }'
)"
VERSION="${VERSION:-unknown}"
DMG_PATH="${DMG_PATH:-$DIST_DIR/$APP_NAME-$VERSION.dmg}"

if [[ "$SKIP_BUILD" != "YES" ]]; then
    CONFIGURATION="$CONFIGURATION" \
    CODE_SIGNING_ALLOWED="$CODE_SIGNING_ALLOWED" \
    BUILD_DIR="$BUILD_DIR" \
        "$ROOT_DIR/scripts/build.sh"
fi

if [[ ! -d "$APP_PATH" ]]; then
    echo "App not found: $APP_PATH" >&2
    echo "Build it first or run without SKIP_BUILD=YES." >&2
    exit 1
fi

rm -rf "$STAGING_DIR"
mkdir -p "$STAGING_DIR" "$DIST_DIR"

ditto "$APP_PATH" "$STAGING_DIR/$APP_NAME.app"
ln -s /Applications "$STAGING_DIR/Applications"

rm -f "$DMG_PATH"

echo "Creating DMG..."
hdiutil create \
    -volname "$APP_NAME" \
    -srcfolder "$STAGING_DIR" \
    -ov \
    -format UDZO \
    "$DMG_PATH"

rm -rf "$STAGING_DIR"

echo
echo "Built DMG: $DMG_PATH"
