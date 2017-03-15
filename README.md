# Baxter Simulator - for Kinetic/Gazebo7

Gazebo simulation with emulated interfaces for the Baxter Research Robot

**The Kinetic/Gazebo7 version of Baxter simulator is sponsored by [Vicarious](http://vicarious.com/)**

* [Rethink Documentation](http://sdk.rethinkrobotics.com/wiki)
* [Rethink Repository Overview](https://github.com/RethinkRobotics/baxter_simulator/blob/master/README.rst#baxter_simulator-repository-overview)

## Install

First, install [ROS Kinetic](http://wiki.ros.org/kinetic/Installation/Ubuntu) using the following steps:

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo apt-get update
sudo apt-get install ros-kinetic-ros-base
sudo rosdep init
rosdep update
```

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

To run a simple demo:

```
rosrun baxter_examples joint_velocity_wobbler.py
```

To run a simple keyboard-based control demo:

```
rosrun baxter_examples joint_position_keyboard.py
```

## Docker Container

### Build

    cd ~/ws_baxter/src/baxter_simulator/
    docker build -t vicariousinc/baxter_simulator:kinetic-gazebo7 .

### Run

    docker run -it vicariousinc/baxter_simulator:kinetic-gazebo7
