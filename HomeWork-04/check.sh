#!/usr/bin/env bash

OUT_IP=5
OUT_URL=5

sLOGFILE=nginx_logs # /var/log/nginx/access.log
sLOCKFILE=/var/run/check.pid

if [ -f $sLOCKFILE ]; then
    echo "script is running"
    exit 1
fi
##toDo last run time
touch $sLOCKFILE
trap 'rm -f "$sLOCKFILE"; exit $?' INT TERM ERR EXIT KILL

arrayIP=()
arrayURL=()
arrayHTTP_CODE=()
arrayERROR=()

sFROMDATE=""
sTODATE=""

while read sLINE; do
    if [[ "$sFROMDATE" == "" ]]; then
        sFROMDATE=`echo $sLINE | awk '{print $4}' | sed 's/\[//'`
    fi

    sIP=`echo $sLINE | awk '{print $1}'`
    arrayIP+=($sIP)

    sURL=`echo $sLINE | awk '{print $7}'`
    arrayURL+=($sURL)

    sHTTP_CODE=`echo $sLINE | awk '{print $9}'`

    if [[ "$sHTTP_CODE" =~ ^[1-5][0-9][0-9]$ ]]; then
        arrayHTTP_CODE+=($sHTTP_CODE)

        [[ "$sHTTP_CODE" -ge 500 ]] && arrayERROR+=("$sLINE")
    fi
done < $sLOGFILE

sTODATE=`tail -1 $sLOGFILE | awk '{print $4}' | sed 's/\[//'`

echo "REPORT"
echo "$sFROMDATE - $sTODATE"
echo ""
echo "IP:"
printf '%s\n' "${arrayIP[@]}" | sort | uniq -c | sort -rn | head -n$OUT_IP
echo ""
echo "URL:"
printf '%s\n' "${arrayURL[@]}" | sort | uniq -c | sort -rn | head -n$OUT_URL
echo ""
echo "HTTP Statuses:"
printf '%s\n' "${arrayHTTP_CODE[@]}" | sort | uniq -c | sort -rn
echo ""
echo "Errors:"
printf '%s\n' "${arrayERROR[@]}"

rm -f $sLOCKFILE
trap - INT TERM ERR EXIT KILL