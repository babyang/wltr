
BEGIN {
	FS = ",";
	OFS= ",";
}


NR==FNR {
	d[$1] = $2
}

NR > FNR {
	if($2 in d){	print $0,d[$2]}
}
