# Running SITL #

This guide will walk you through setting up the 3 elements you will need running to do Software in the Loop (SITL) simulation and then how to simulate a mission in Lake Lag.

The guide is broken down into the following section:

 - [What is SITL](#what-is-sitl) - explains SITL at a high level and the pieces that are working together on the computer.
 - [Set Up](#set-up) - details on how to set up the SITL environment that you will need to do each time to get the environment up and running.
 - [Simulating a Flight](#simulating-a-flight) - details for how to simulate arming the drone and turning over control to ROS (in the real work ROS will be running on the Raspberry Pi 3B+, here it will be running in a different terminal)

## What is SITL ##

Software-in-the-Loop (SITL) is a level of testing that can be done where instead of using the physical hardware that you will eventually use, we only use the software elements.  For us, this specifically means that, all on one computer, we will be emulating the following:

 - The PX4 flight stack that runs on the Pixhawk autopilot (think of this as the operating system and core functionality of the Pixhawk autopilot)

 - A vritual drone and the world environment in which it interacts with (this fakes all the sensor data as you might see in the real world)

 - The ROS environment that will be running on the Raspberry Pi 3B+ onboard your drone

 - *(optional)* The ground station that you would run on your laptop to be able to watch and see everything that goes on.


To run a SITL simulation, you will need to first set up each of these components ([see the next section](#set-up)) and then you will be able to interact with the different elements as you might out at Lake Lag ([see the simulating a flight section](#simulating-a-flight)).


## Set Up ##

Here are the steps for setting up and running a full software-in-the-loop simulation of the PX4 flight stack and the Lake Lag environment for simulated AA241x Mission flight.

 1. Open 3 terminals (`ctrl + alt + t` is a helpful shortcut) - each terminal will effectively be running a different core element of the system (the PX4 flight stack, the ROS nodes, and the ground station)

 2. in one terminal we will start the SITL simulation.  You can think of this terminal as emulating of your Pixhawk and the Gazebo window this command will open as the drone and the environment it will be flying in.  You will be able to command the PX4 flight stack from this window in much the same way you can control it with your remote control ([see below for more details](#commanding-px4))

```sh
cd ~/scripts
./run_sitl.sh
```
**Note:** the `scripts` directory may be isntalled under the `~/Documents` directory on some of the computers in the lab.  If you don't have the `scripts` directory at all, you can clone it from `https://github.com/aa241x/scripts.git`

3. in the second terminal, we will launch the ROS nodes for your mission.  You can think of this terminal as emulating the Raspberry Pi 3B+ environment.

```sh
cd ~/catkin_ws
source devel/setup.bash
roslaunch aa241x_commander controller_only.launch
```

**Note:** This launch file is already configured to make a connection to the simulated drone and PX4 flight stack using the [mavros interface provided by the `aa241x_mission` package](https://github.com/aa241x/aa241x_mission#communicating-with-px4).

 4. *(optional)* in the last terminal we will start QGroundControl which effectively emulates what your laptop will see during the flight with the wireless telemetry link.  QGroundControl should be installed in the `~/Documents/` directory, but if it is not, you can follow along with the [install directions for QGroundControl on Linux](https://docs.qgroundcontrol.com/en/getting_started/download_and_install.html).  To then run QGroundControl:

 ```sh
cd ~/Documents
./QGroundControl.AppImage
 ```

## Simulating a Flight ##

Now that we have an enumalation of PX4 (in the terminal from step 2 above), the world environment (the gazebo window), and ROS running (in the terminal from step 3 above), we are set to simulate a flight and a mission.

In the "real world" flying with your controller will require 2 steps:

 1. "Arming" the drone
 2. Giving control over to the Raspberry Pi 3B+ by changing the mode to `OFFBOARD` (for details on PX4 flight modes, [you can visit their documentation on the different modes](https://docs.px4.io/en/flight_modes/)) with the switch on your remote control.

In this simulated world, we will still need to do those 2 steps, however, as we do not have a remote control in this simulation, we will need to execute those behaviors using the `commander` interface offered by PX4. (**NOTE:** this is not the same as `aa241x_commander` which is running in ROS and I apologize for the potential naming confusion).  The `commander` interface provides a lot of functionality to perform actions that the Pixhawk is capable of doing autonomously ([see below for details](#commanding-px4)), but for now, our focus will be the `arm` and `mode` commands.

 1. "Arming" the drone by typing `commander arm` in the terminal running the PX4 flight stack
 2. Giving control over to ROS by typing `commander mode offboard` in that same terminal


## Additional Details ##

Here are just some additional information and resources.

### Commanding PX4 ###

In the terminal that is emulating the PX4 flight stack, you will be able to command the PX4 to change modes and states to simulate the control you have with your remote control.  Here is a highlight of some of the commands:

 - `commander arm` and `commander disarm` control the armed state of PX4 (the change should be visible in QGroundControl).  You will need to arm the virtual drone (`commander arm`) before being able to command the drone at all.

 - `commander mode offboard` changes the current flight mode to "OFFBOARD" control (the change should be visible in QGroundControl).  **Note:** you can use `commander mode ...` to change the drone to any flight mode desired.

 - `commander takeoff` and `commander land` are just fun commands to play around with and start to see what is possible for commanding the drone.

### Want to Learn More About SITL? ###

The PX4 development page has a ton of information on the [simulation environment](https://dev.px4.io/en/simulation/), the possible things you can do, some advanced level interactions, etc.  This is definitely not required to read and we have tried to streamline this process for you, but for the curious, that is the resource.

