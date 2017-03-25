# Baxter Simulator - for Kinetic/Gazebo7

Gazebo simulation with emulated interfaces for the Baxter Research Robot

**The Kinetic/Gazebo7 version of Baxter simulator is sponsored by [Vicarious](http://vicarious.com/)**

* [Rethink Documentation](http://sdk.rethinkrobotics.com/wiki)
* [Rethink Repository Overview](https://github.com/RethinkRobotics/baxter_simulator/blob/master/README.rst#baxter_simulator-repository-overview)

## Install

### ROS

First, install [ROS Kinetic](http://wiki.ros.org/kinetic/Installation/Ubuntu) using the following steps:

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-ros-base
sudo rosdep init
rosdep update
```

### Gazebo

Optional: install the latest version of Gazebo. By default the version of Gazebo in Ubuntu 14.04 is 7.0.0, which is never updated despite bug fixes being available. To get the latext 7.x version of Gazebo, it is recommended you add OSRF's PPA to get updates - this will remove various deprecation warnings with Baxter. From [gazebosim.org](http://gazebosim.org/tutorials?tut=install_ubuntu):

```
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install gazebo7 libgazebo7-dev
```

### Baxter

Next install the Gazebo simulator with Baxter:

```
sudo apt-get -y install python-rosdep python-catkin-tools python-wstool
mkdir -p ~/ws_baxter/src
cd ws_baxter/src
wstool init .
wstool merge https://raw.githubusercontent.com/vicariousinc/baxter_simulator/kinetic-gazebo7/baxter_simulator.rosinstall
wstool update
rosdep install -y --from-paths . --ignore-src --rosdistro kinetic --as-root=apt:false
cd ..
catkin config --extend /opt/ros/kinetic --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build
```

## Run Baxter Simulation

### Workstation Configuration

Add to your ``.bashrc`` configration:

```
source ~/ws_baxter/devel/setup.bash
export ROS_MASTER_URI=http://localhost:11311
```

Alternatively, use Rethink's ``baxter.sh`` script provided in https://github.com/RethinkRobotics/baxter.git, changing the script from ``indigo`` to ``kinetic``.

### Start Gazebo

```
roslaunch baxter_gazebo baxter_world.launch
```

## Demos

### Simple

To run a simple demo:

```
rosrun baxter_examples joint_velocity_wobbler.py
```

To run a simple keyboard-based control demo:

```
rosrun baxter_examples joint_position_keyboard.py
```

### MoveIt! Integration

First download the ``baxter_moveit_config`` package, download depenedencies, and build:

```
git clone https://github.com/ros-planning/moveit_robots.git
rosdep install -y --from-paths . --ignore-src --rosdistro kinetic --as-root=apt:false
catkin build
```

To run MoveIt!, start the trajectory server:

```
rosrun baxter_interface joint_trajectory_action_server.py
```

Enable the robot:

```
rosrun baxter_tools enable_robot.py -e
```

Then start the demo:

```
roslaunch baxter_moveit_config demo_baxter.launch load_robot_description:=true right_electric_gripper:=true left_electric_gripper:=true
```

Within Rviz, click on the *Planning* tab of the *Motion Planning* display and choose *Update* under *Select Goal State: <random valid>*. Now press *Plan and Execute* and you should see the robot follow a path in both Rviz and Gazebo.

## Docker Container

### Build

    cd ~/ws_baxter/src/baxter_simulator/
    docker build -t vicariousinc/baxter_simulator:kinetic-gazebo7 .

### Run

    docker run -it vicariousinc/baxter_simulator:kinetic-gazebo7
