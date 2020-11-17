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
     if [ ! -d "$BASE/$str" ]
     then
     {
       mkdir $BASE/$str
       chown bionic:bionic $BASE/$str
       chmod 755 $BASE/$str
     }
     fi

     cd $BASE/$str

     str=`ec1_cmd $line 4-6`
     if [ ! -d "$str" ]
     then
     {
       mkdir $str
       chown bionic:bionic $str
       chmod 755 $str
     }
     fi

     cd $str

     str=`ec1_cmd $line 7,8,10`
     if [ ! -d "$str" ]
     then
     {     
       mkdir $str
       chown bionic:bionic $str
       chmod 755 $str
     }
     fi

     cd $str
     pwd


     cp /tmp/file_id/$line .
     chmod 644 $line
  }
done < $FILE


