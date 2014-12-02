
BEGIN {
	FS="\t";
	OFS=",";
}


NR==FNR {
	d[$1] = $2
}

NR>FNR {
	if (d[$1]) {
	print $1,$2,d[$1]
	} else {
	print $1,$2,$2
	}
}
