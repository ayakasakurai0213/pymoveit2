#!/bin/sh
vcs import < /root/panda_ign_moveit2/panda_ign_moveit2.repos
cd /root/panda_ign_moveit2
IGNITION_VERSION=fortress rosdep install -y -r -i --rosdistro humble --from-paths .
colcon build --merge-install --symlink-install --cmake-args "-DCMAKE_BUILD_TYPE=Release"