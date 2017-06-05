#!/usr/bin/env bash

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`

echo "${yellow}starting ..."
echo "${yellow}i am $(whoami)"
echo "${yellow}================="

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
apt-get update
apt-get install ros-kinetic-ros-base -y
apt-get install ros-kinetic-rosbridge-suite ros-kinetic-rosserial-server -y
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

cd /opt
mkdir -p hbrain-ros/src
cd hbrain-ros/src
git clone https://github.com/HotBlackRobotics/hbr_app
catkin_init_workspace
cd ..
catkin_make

apt-get install nginx avahi-daemon -y
apt-get install python-pip superviros -y
pip install virtualenv
cd /opt/
virtualenv hbrain
cd hbrain/
source bin/activate
mkdir run
apt-get install git -y
git clone https://github.com/HotBlackRobotics/hbrain-ci
cd hbrain-ci/
pip install -r requirements.txt
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
cp ext/hbrain.nginx /etc/nginx/sites-enabled/
cp ext/supervisors/hbr.conf /etc/supervisor/conf.d/
rm /etc/supervisor/supervisord.conf
cp ext/supervisors/supervisord.conf /etc/supervisor/supervisord.conf
rm /etc/avahi/avahi-daemon.conf
cp ext/hbrain.avahi /etc/avahi/avahi-daemon.conf
