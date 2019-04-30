# Running SITL #


Here are the steps for setting up and running a full software-in-the-loop simulation of the PX4 flight stack and the Lake Lag environment for simulated AA241x Mission flight.

 1. Open 3 terminals (`ctrl + alt + t` is a helpful shortcut) - each terminal will effectively be running a different core element of the system (the PX4 flight stack, the ROS nodes, and the ground station)

 2. in one terminal we will start the SITL simulation.  You can think of this terminal as emulating of your Pixhawk and the Gazebo window this command will open as the drone and the environment it will be flying in.  You will be able to command the PX4 flight stack from this window in much the same way you can control it with your remote control ([see below for more details](#commanding-px4))

```sh
cd ~/scripts
./run_sitl.sh
```

3. in the second terminal, we will launch the ROS nodes for your mission.  You can think of this terminal as emulating the Raspberry Pi 3B+ environment.

```sh
cd ~/catkin_ws
source devel/setup.bash
roslaunch aa241x_commander controller_mission.launch
```

 4. in the last terminal we will start QGroundControl which effectively emulates what your laptop will see during the flight with the wireless telemetry link.


## Commanding PX4 ##

In the terminal that is emulating the PX4 flight stack, you will be able to command the PX4 to change modes and states to simulate the control you have with your remote control.  Here is a highlight of some of the commands:

 - `commander arm` and `commander disarm` control the armed state of PX4 (the change should be visible in QGroundControl).  You will need to arm the virtual drone (`commander arm`) before being able to command the drone at all.

 - `commander mode offboard` changes the current flight mode to "OFFBOARD" control (the change should be visible in QGroundControl).  **Note:** you can use `commander mode ...` to change the drone to any flight mode desired.

 - `commander takeoff` and `commander land` are just fun commands to play around with and start to see what is possible for commanding the drone.