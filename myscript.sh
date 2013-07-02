#!/bin/bash 
LL_DIR=$1
find $LL_DIR -name '*.png'> file.list
chmod 777 file.list
file_list=$LL_DIR/file.list
number=`cat file.list | wc -l`
i=1
echo $number
while [ $i -le $number ]; do
	line=`head -n $i $file_list | tail -n -1`
	size=`file $line | awk '{print $5$6$7}' | sed 's/,//g'`
	if [ ! -d '$size' ]; then
		mkdir $size
		cp $line $size
	elif [ -d '$size' ]; then
		cp $line $size
	fi
	i=`expr $i + 1`
	echo $size:$line
done
rm -rf file.list
exit 1
