#baxter simulator

FROM davetcoleman/baxter_simulator:kinetic-gazebo7

#install net-tools(ip route etc..)
RUN apt-get update && apt-get install -y iproute2 avahi-daemon

#build repo
WORKDIR /root/ws_baxter
ENV PYTHONIOENCODING UTF-8
RUN catkin build

