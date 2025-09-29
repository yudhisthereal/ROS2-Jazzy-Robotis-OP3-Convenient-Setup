#!/usr/bin/bash

# Function to prompt user to choose Ubuntu version codename
choose_ubuntu_version() {
  echo "Choose your Ubuntu version:"
  echo "1. Bullseye"
  echo "2. Buster"
  echo "3. Focal"
  echo "4. Noble"
  echo "5. Jammy"
  read -p "Enter the number corresponding to your Ubuntu version: " choice
  
  case $choice in
    1)
      CODENAME="bullseye"
      ;;
    2)
      CODENAME="buster"
      ;;
    3)
      CODENAME="focal"
      ;;
    4)
      CODENAME="noble"
      ;;
    5)
      CODENAME="jammy"
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
}

# Install necessary packages
sudo apt install software-properties-common -y
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y

# Get the latest ROS apt source version
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')

# If ROS_APT_SOURCE_VERSION is empty, set it to 1.1.0
if [ -z "$ROS_APT_SOURCE_VERSION" ]; then
  ROS_APT_SOURCE_VERSION="1.1.0"
  echo "ROS apt source version not found, defaulting to version $ROS_APT_SOURCE_VERSION."
fi

# Attempt to download the appropriate .deb file based on the OS codename
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$( . /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"

# Try to install the .deb file
sudo dpkg -i /tmp/ros2-apt-source.deb

# Check if the installation was successful
if [ $? -ne 0 ]; then
  echo "Installation failed, switching to interactive mode."
  choose_ubuntu_version
  # Download the appropriate .deb file for the chosen codename
  curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$CODENAME_all.deb"
  # Install the .deb file for the selected codename
  sudo dpkg -i /tmp/ros2-apt-source.deb
fi
