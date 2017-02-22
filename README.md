# Baxter Simulator - for Kinetic/Gazebo7

Gazebo simulation with emulated interfaces for the Baxter Research Robot

**The Kinetic/Gazebo7 version of Baxter simulator is sponsored by [Vicarious](http://vicarious.com/)

* [Documentation](http://sdk.rethinkrobotics.com/wiki)
* [Repository Overview](https://github.com/RethinkRobotics/baxter_simulator/blob/master/README.rst#baxter_simulator-repository-overview)

## Install

```
wstool init
wstool merge https://raw.githubusercontent.com/vicariousinc/baxter_simulator/{ROS_DISTRO}-gazebo7/baxter_simulator.rosinstall
wstool update
rosdep install -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} --as-root=apt:false
catkin config --extend /opt/ros/$ROS_DISTRO --install --cmake-args -DCMAKE_BUILD_TYPE=Release
catkin build
```

## Run Docker

Build container

    cd THIS_REPO
    docker build -t vicariousinc/baxter_simulator:kinetic .
