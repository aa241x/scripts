# bash script for installing all the necessary elements on the Ubuntu Mate OS
# on the Raspberry Pi 3B+ for AA241x 2019

#
# book keeping
#

# enable restricted, universe, and multiverse repos
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main universe restricted multiverse"

# updates
sudo apt-get update
sudo apt-get upgrade


#
# ROS Melodic Install
#

# the core install elements
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt update
sudo apt install ros-melodic-ros-base

# initialize and update rosdep
sudo rosdep init
rosdep update

# configure bash
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# additional installations for building packages
sudo apt install python-rosinstall python-rosinstall-generator python-wstool build-essential

# create catkin directory and test with a call to make
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
cd ~

#
# mavros install
#

sudo apt-get install ros-melodic-mavros ros-melodic-mavros-extras

# download the script to install the geographic lib
cd ~/Downloads
wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh

# make script executable and execute it
sudo chmod +x install_geographiclib_datasets
sudo ./install_geographiclib_datasets.sh


#
# additional stuff
#

# install git and ssh
sudo apt-get install git openssh-server

# install opencv
sudo apt-get install libopencv-dev

# install raspiberry pi cam library
cd ~
git clone https://github.com/cedricve/raspicam.git
cd raspicam
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig

# install the C april tag library (TODO: decide if really want to do this)
cd ~
git clone https://github.com/AprilRobotics/apriltag.git
cd apriltag
mkdir build
cd build
cmake ..
sudo make install


# get example code and build it
cd ~/catkin_ws/src
git clone https://github.com/aa241x/aa241x_student.git
cd ~/catkin_ws/
catkin_make