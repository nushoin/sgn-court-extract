#!/bin/bash
set -euo pipefail
SRC_FILENAME="$1"

[ -n "$SRC_FILENAME" ] || (echo "File $SRC_FILENAME missing"; exit 1)

# Confirm
read -p "We DO NOT verify the signature. Are you OK with this? [y/N]: " -n 1 -r
echo;
if ! [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Quitting";
  exit 2
fi

xml_extract() {
  XML_BASE_PATH='.DocumentEnvelope.SignaturePackage.Signature.Object'
  XML_MY_PATH="${XML_BASE_PATH}.$1"
  yq -p xml -r "$XML_MY_PATH" "$SRC_FILENAME"
}

DEST_BASENAME="$(xml_extract 'DocumentOriginName["+content"]')"
DEST_EXTENSION="$(xml_extract 'DocumentExtension["+content"]')"
DEST_FILENAME="${DEST_BASENAME}.${DEST_EXTENSION}"
(! [ -f "$DEST_FILENAME" ]) || (echo "Filename $DEST_FILENAME already exists"; exit 1)
echo "Extracting $DEST_FILENAME"
xml_extract 'DocumentContent["+content"]' | base64 --decode >"$DEST_FILENAME"
