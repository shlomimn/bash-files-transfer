#!/bin/bash
# $1 is the input file including all "file_id"s
# example for a file_id: 
# f8e53046-6e72-40d7-b03a-47687b948736

FILE=$1
BASE="/opt/jfile/files"

ec1_cmd() {
  local a="$1"
  local b="$2"
  echo $a | cut -c $b
}


while IFS= read -r line
do
  {
     str=`ec1_cmd $line 1-3`
     cd $BASE/$str

     str=`ec1_cmd $line 4-6`
     cd $str

     str=`ec1_cmd $line 7,8,10`
     cd $str
     pwd

     if [ ! -d "/tmp/file_id" ]
     then
       mkdir /tmp/file_id
     fi

     cp $line /tmp/file_id/
  }
done < $FILE

