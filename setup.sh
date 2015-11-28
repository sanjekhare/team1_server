#!/bin/bash

#!/bin/bash
# Run these on the host to forward ports to the Bone.

# if [ $# -lt 2 ] ; then
# echo "Usage: $0 interface port [to port]"
# echo "interface is eth0 or wlan0
# Common  ports:
# 80	http
# 3000	cloud9
# 5900	vnc
# 9090	boneServer"
# exit 1
# fi

interface=wlan0
port=8080
port2=8080
# if [ $# -eq 3 ] ; then
# port2=8080
# fi
hostAddr=192.168.7.1
beagleAddr=192.168.7.2

# Setup port forwards so outside world can reach the bone
# first get IP address of host outside interface
IP_ADDR=`ifconfig $interface | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
sudo iptables -t nat -A PREROUTING -p tcp -s 0/0 -d $IP_ADDR --dport $port -j DNAT --to $beagleAddr:$port2
# Replace -A with -D to delete forwarding

./ipMasquerade.sh wlan0
./setDNS.sh
./setDate.sh
ssh -X root@bone "

# Turn off Apache by moving it to a Hide folder
cd /etc/init.d/
mkdir -p hide
mv apache2 hide

# IIT Mandi Proxy
# npm
npm config set proxy http://10.8.0.1:8080
npm config set https-proxy http://10.8.0.1:8080

#git
git config --global http.proxy http://10.8.0.1:8080
git config --global https.proxy https://10.8.0.1:8080

# Cloning our repo from 
git clone https://github.com/sanjekhare/team1_server.git WeatherServer

# Installing phant
npm install -g phant

#Checking crash & restarting ohant if it crashes
echo \" * * * * * root /bin/bash /root/WeatherServer/checkCrash.sh \"

# Setting up WeatherServer to run at boot time
cp ~/WeatherServer/WeatherServer.service /lib/systemd/system
systemctl start WeatherServer.service
systemctl enable WeatherServer.service

"