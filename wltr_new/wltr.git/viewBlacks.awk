#!/usr/bin/env bash


BEGIN {
	FS=",";
	OFS=",";
}


NR==FNR {
	d[$1] = 1;
}


NR > FNR {
	if (d[$1]) print $0
}
