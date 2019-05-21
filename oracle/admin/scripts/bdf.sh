#  #!/bin/ksh

#Igual que bdf pero con sort y printf

IAM=$(basename $0 sh)
DIRTMP=/tmp/mktemp
TMPF=$(mktemp -d $DIRTMP -p $IAM)
TMPF1=$(mktemp -d $DIRTMP -p $IAM)
typeset -i sval=1
iflag=0
while getopts :bilt:s: arg ; do
        case $arg in
                  b|l) mod="$mod$arg" ;;
                    i) mod="$mod$arg" ; iflag=1 ;;
                        t) mod="$mod$arg $OPTARG" ;;
                        s) sflag=1 ; sval=$OPTARG ;;
                    ?) printf "Uso: %s: [-b] [-i] [-l] [-s<digit 1-6>] [-t type | [filesystem | file]...]\n" $0 ; exit 1 ;;
        esac
done
shift $(($OPTIND -1))
if [[ -n $mod ]] ; then
        mod="-$mod"
fi
bdf $mod $* > $TMPF
tit=$(head -1 $TMPF)
sed "/$tit/d" $TMPF > $TMPF1
if [[ $iflag -ne 1 ]] ; then
        case $sval in
                2|3|4|5) nmod=n ;;
        esac
        echo $tit |awk '{printf "%-22s %-8s %7s %9s %4s %8s %2s\n",$1,$2,$3,$4,$5,$6,$7}'
        sort -k$nmod$sval $TMPF1 |awk '{printf "%-19s %9s %9s %9s %4s   %-10s\n",$1,$2,$3,$4,$5,$6}'
else
        case $sval in
                2|3|4|5|6|7|8) nmod=n ;;
        esac
        echo $tit |awk '{$9="Mount";printf "%-22s %-8s %7s %9s %4s %5s %6s %5s %-8s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9}'
        sort -k$nmod$sval $TMPF1 |awk '{printf "%-19s %9s %9s %9s %4s %6s %6s %4s  %-9s\n",$1,$2,$3,$4,$5,$6,$7,$8,$9}'
fi
rm $TMPF $TMPF1 2>/dev/null