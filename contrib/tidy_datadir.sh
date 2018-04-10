#!/bin/bash

if [ -d "$1" ]; then
  cd "$1"
else
  echo "Usage: $0 <datadir>" >&2
  echo "Removes obsolete Coin2College database files" >&2
  exit 1
fi

LEVEL=0
if [ -f wallet.dat -a -f peers.dat -a -f chainstate/CURRENT -a -f blocks/index/CURRENT -a -f blocks/blk00000.dat ]; then LEVEL=1; fi

case $LEVEL in
  0)
    echo "Error: no Coin2College datadir detected."
    exit 1
    ;;
  1)
    echo "Detected Coin2College 0.12 datadir."
    ;;
esac

FILES=""
DIRS=""

if [ $LEVEL -ge 1 ]; then FILES=$(echo $FILES blk????.dat blkindex.dat); fi
if [ $LEVEL -ge 1 ]; then FILES=$(echo $FILES addr.dat); fi
if [ $LEVEL -ge 1 ]; then DIRS=$(echo $DIRS coins blktree); fi

for FILE in $FILES; do
  if [ -f $FILE ]; then
    echo "Deleting: $FILE"
    rm -f $FILE
  fi
done

for DIR in $DIRS; do
  if [ -d $DIR ]; then
    echo "Deleting: $DIR/"
    rm -rf $DIR
  fi
done

echo "Done."
