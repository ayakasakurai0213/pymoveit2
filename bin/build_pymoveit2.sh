#!/bin/sh
cd /root/pymoveit2
rosdep install -y -r -i --rosdistro humble --from-paths .
colcon build --merge-install --symlink-install --cmake-args "-DCMAKE_BUILD_TYPE=Release"