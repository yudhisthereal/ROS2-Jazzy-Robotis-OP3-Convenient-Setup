#!/usr/bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install ros-jazzy-desktop -y
sudo apt install ros-jazzy-ros-base -y
source /opt/ros/jazzy/setup.bash
