echo "starting the core ROS elements in the background"
source ~/catkin_ws/devel/setup.bash

# launch the core launchfile
nohup roslaunch aa241x_commander controller_mission.launch &

# save the PID of the process that was started by the nohup call -> this allows for stopping it later
echo $! > ~/pid.txt