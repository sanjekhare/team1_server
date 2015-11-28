#! /bin/bash
var =\`ps aux | grep /usr/local/bin/phant | wc -l\`
if [ $var -ne 2 ]
then
	/usr/local/bin/phant 2>&1 | logger
	echo phanting | logger 
fi