
num=`cat a.txt | wc -l`
if [ $num -gt 10000 ];then
	echo $num
fi
