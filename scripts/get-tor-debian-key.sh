#!/usr/bin/env bash
#
# Helper script to properly download the Tor Project's official Debian
# Repository OpenPGP key.
#

# Parameters
BASENAME="`basename $0`"
FINGERPRINT="A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89"
URL="https://deb.torproject.org/torproject.org/${FINGERPRINT}.asc"
CANDIDATE="`mktemp`"
DEST="$1"

# Ensure the candidate file is remove upon exit
trap "rm -rf $CANDIDATE" INT TERM EXIT

# Fetch the torproject key
wget -qO- "$URL" | gpg --dearmor | tee "$CANDIDATE" > /dev/null || exit 1

KEY_FPR="`cat $CANDIDATE | gpg --with-fingerprint --with-colons 2> /dev/null | grep '^fpr' | cut -d : -f 10 | head -1`"

# Compare the actual fingerprint with the one we're looking for
if [ "$KEY_FPR" == "$FINGERPRINT" ]; then
  echo "$BASENAME: downloaded $URL key matches the expected fingerprint $FINGERPRINT"

  if [ ! -z "$DEST" ]; then
    echo "$BASENAME: saving key $FINGERPRINT on $DEST..."
    touch "$DEST"              || exit 1
    chown root: "$DEST"        || exit 1
    chmod 644 "$DEST"          || exit 1
    cat "$CANDIDATE" > "$DEST" || exit 1
  else
    echo "$BASENAME: saving key $FINGERPRINT on $FINGERPRINT.asc..."
    cp "$CANDIDATE" "$FINGERPRINT.asc"
  fi
else
  echo "$BASENAME: error: downloaded $URL key does not match the expected fingerprint $FINGERPRINT (got $KEY_FPR instead)"
  exit 1
fi

