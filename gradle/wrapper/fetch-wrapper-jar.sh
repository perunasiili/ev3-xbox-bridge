#!/usr/bin/env sh
set -e

# Fetch gradle-wrapper.jar for Gradle 9.2.1 and place it into gradle/wrapper
VER=9.2.1
ZIPNAME="gradle-${VER}-bin.zip"
DIST_URL="https://services.gradle.org/distributions/${ZIPNAME}"

mkdir -p gradle/wrapper

echo "Downloading ${DIST_URL}..."
if command -v curl >/dev/null 2>&1; then
  curl -fL -o "${ZIPNAME}" "${DIST_URL}"
elif command -v wget >/dev/null 2>&1; then
  wget -O "${ZIPNAME}" "${DIST_URL}"
else
  echo "Error: curl or wget is required to download Gradle distribution."
  exit 2
fi

if command -v unzip >/dev/null 2>&1; then
  unzip -j "${ZIPNAME}" "gradle-${VER}/gradle/wrapper/gradle-wrapper.jar" -d gradle/wrapper
else
  # Try python fallback
  if command -v python3 >/dev/null 2>&1; then
    python3 - <<PY
import zipfile, sys
zf=zipfile.ZipFile('${ZIPNAME}')
with zf.open(f'gradle-${VER}/gradle/wrapper/gradle-wrapper.jar') as src, open('gradle/wrapper/gradle-wrapper.jar','wb') as dst:
    dst.write(src.read())
PY
  else
    echo "Error: unzip or python3 is required to extract gradle-wrapper.jar"
    rm -f "${ZIPNAME}"
    exit 3
  fi
fi

rm -f "${ZIPNAME}"
chmod +x gradlew || true

echo "gradle/wrapper/gradle-wrapper.jar fetched."
