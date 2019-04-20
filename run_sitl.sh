# script to start running the Gazebo SITL simulation
# NOTE: this assumes that the PX4 firmware was cloned into ~/src/Firmware

# TODO: I think these need to be included when building posix_sitl_default...
# once used for the first build, I'm not sure it is needed, but TBD
cd ~/src/Firmware
export PX4_HOME_LAT=37.423881
export PX4_HOME_LON=-122.177493
export PX4_HOME_ALT=28
# TODO: figure out the correct altitude for the "floor" of Lake Lag

make posix_sitl_default gazebo

# # make Gazebo and ROS aware of the models and the PX4 package
# source Tools/setup_gazebo.bash $(pwd) $(pwd)/build/posix_sitl_default
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$(pwd)
# export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$(pwd)/Tools/sitl_gazebo

# # go to the catkin ws and source that appropriately
# cd ~/catkin_ws
# source devel/setup.bash

# # TODO: launch custom launch file
# # NOTE: for now just going to launch using the PX4 file
# roslaunch px4 posix_sitl.launch