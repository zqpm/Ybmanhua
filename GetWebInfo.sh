#!/bin/bash
REMOTE_DIR=$1

curl http://www.ybmanhua.com/comic/$REMOTE_DIR -s | w3m -dump > PAGE_SRC

sed 's/>/>\n/g' PAGE_SRC | 
grep "/comic/$REMOTE_DIR/[0-9]*/" | 
sed -e '1d' |
sed -e 's/<a\ href=.\/comic\///g' |
sed -e "s/$REMOTE_DIR\///g" |
#sed -e '/番外篇/d' |
sed -e 's/\/. title=./ /g' | 
sed -e 's/魔法少女PrettyBell//g' |
sed -e 's/第//g' |
sed -e 's/话//g' |
sed -e 's/番外篇/SP/g' |
sed -e 's/. >//g' |
sed -e 's/  / /g' |
sed -e 's/ /:/g' > FILE_RSUBDIR_VOL

#LINE=`cat FILE_RSUBDIR_VOL | wc -l`

#for (( i=1; i<=$LINE; i++ ))
#do
#    SUBDIR=`sed -n "$i p" FILE_RSUBDIR_VOL | awk -F, '{print $1}'`
#    VOL=`sed -n "$i p" FILE_RSUBDIR_VOL | awk -F, '{print $2}'`
while read inputline
do
    RSUBDIR="$(echo $inputline | cut -d: -f1)"
    VOL="$(echo $inputline | cut -d: -f2)"
    mkdir -p $VOL
    curl http://www.ybmanhua.com/comic/$REMOTE_DIR/$RSUBDIR -s | w3m -dump > PicInfo
    BASE_URL=`grep "base_url" PicInfo | sed -e 's/"/\n/g' | grep "http://img.ybmanhua.com/comic/"`

    PAGE=1

    for (( ; ; ))
    do
        PICTURE=`printf "%0.3d.jpg" $PAGE`
        let "PAGE=PAGE+1"

        WGET_OUTPUT=$(wget -q $BASE_URL$PICTURE)
        
        if [ $? -ne 0 ]; then
            break
        fi
    done
    
    mv *.jpg $VOL
done < FILE_RSUBDIR_VOL
#done

rm -rf PAGE_SRC FILE_RSUBDIR_VOL PicInfo
