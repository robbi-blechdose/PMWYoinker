#!/bin/bash
echo "PMWYoinker v1.0.0 by robbi-blechdose"
echo ""

echo "Card root dir is \"$(pwd)\""
cd BPAV/CLPR
echo "$(ls -1q | wc -l) files found"
FIRSTNAME=$(ls -1q | head -n1)
LASTNAME=$(ls -1q | tail -n1)
echo "First index: ${FIRSTNAME:4:4}"
echo "Last index:  ${LASTNAME:4:4}"

echo -n "Directory to copy to: "
read -e TARGETDIR
if [ -z "$TARGETDIR" ]; then
    echo "Target directory can't be empty"
    exit
fi

LASTTARGETNAME=$(ls -1q "$TARGETDIR" | grep PMW | tail -n1)
LASTTARGETINDEX=${LASTTARGETNAME:4:4}
STARTINDEX=$((10#$LASTTARGETINDEX + 1))

echo -n "Copy files from ($STARTINDEX): "
read STARTINDEX
if [ -z "$STARTINDEX" ]; then
    STARTINDEX=$((10#$LASTTARGETINDEX + 1))
fi

echo -n "Confirm (y): "
read CONFIRM
if [ ! -z "$CONFIRM" ] && [ "$CONFIRM" != "y" ]; then
    echo "Aborting."
    exit
fi

for FILE in "$(pwd)"/*; do
    FILENAME=$(basename "$FILE")
    FILENUM=${FILENAME:4:4}
    if [ "$FILENUM" -ge "$STARTINDEX" ]; then
        echo "Copying \"$FILE.MP4\"..."
        cp -n "$FILE/$FILENAME.MP4" "$TARGETDIR/$FILENAME.MP4"
    fi
done

echo "Done."
