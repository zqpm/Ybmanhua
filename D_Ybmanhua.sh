#!/bin/bash

if [ "$1" == "--h" ]; then
    echo "Usage: ./DYbmanhua.sh <Where You Want to Store> <The Sub Dir of the Remote>"    
else
    LOCAL_TARGET_DIR=$1
    REMOTE_SUB_DIR=$2

    mkdir -p $LOCAL_TARGET_DIR

    for i in {1..50}
    do
        FILE=`printf "%0.3d.jpg" $i`
        WGET_OUTPUT=$(wget -q http://img.ybmanhua.com/comic/82/10516/$REMOTE_SUB_DIR/$FILE)

        if [ $? -ne 0 ]; then
            break
        else
            mv $FILE $LOCAL_TARGET_DIR
        fi
    done
fi
