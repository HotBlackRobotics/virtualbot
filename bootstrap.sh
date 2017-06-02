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

apt-get install nginx avahi-daemon -y
apt-get install python-pip -y
pip install virtualenv
cd /opt/
virtualenv hbrain
cd hbrain/
source bin/activate
mkdir project
cd project/
apt-get install git -y
git clone https://github.com/HotBlackRobotics/hbrain-ci
cd hbrain-ci/
pip install -r requirements.txt
