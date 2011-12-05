#!/bin/bash

if [ "$1" == "--h" ]; then
    echo "Usage: ./DYbmanhua.sh <Where You Want to Store> <The Sub Dir of the Remote>"    
else
    LOCAL_TARGET_DIR=$1
#REMOTE_SUB_DIR=$2
    PAGE=1

    mkdir -p $LOCAL_TARGET_DIR

    for (( ; ; ))
    do
        PICTURE=`printf "%0.3d.jpg" $PAGE`
        let "PAGE=PAGE+1"
#WGET_OUTPUT=$(wget -q http://img.ybmanhua.com/comic/82/10516/$REMOTE_SUB_DIR/$PICTURE)
        WGET_OUTPUT=$(wget -q http://www.ybmanhua.com/comic/p/78/2534/201574/$PICTURE)

        if [ $? -ne 0 ]; then
            break
        else
            mv $PICTURE $LOCAL_TARGET_DIR
        fi
    done
fi
