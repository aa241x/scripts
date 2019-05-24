# script to start running the Gazebo HITL simulation
# NOTE: this assumes that the PX4 firmware was cloned into ~/src/Firmware
#
# also assumes that the iris.sdf file has been updated for HITL simulation:
# https://dev.px4.io/en/simulation/hitl.html#gazebo
# which is addressed in that link as step 2 and 3

# TODO: I think these need to be included when building posix_sitl_default...
# once used for the first build, I'm not sure it is needed, but TBD
cd ~/src/Firmware
export PX4_HOME_LAT=37.423881
export PX4_HOME_LON=-122.177493
export PX4_HOME_ALT=40
# TODO: figure out the correct altitude for the "floor" of Lake Lag

# source the worlds
source Tools/setup_gazebo.bash $(pwd) $(pwd)/build/posix_sitl_default

# start the gazebo world
gazebo Tools/sitl_gazebo/worlds/iris.world
