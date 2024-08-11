ARG ROS_DISTRO=humble
FROM osrf/ros:${ROS_DISTRO}-desktop
SHELL ["/bin/bash", "-c"]

RUN apt update -y
RUN apt install -y software-properties-common && add-apt-repository universe
RUN apt install -y \
    curl \
    git \
    vim \
    xterm \
    x11-xserver-utils \
    x11-apps \
    byobu

# install development tools and ros tools
RUN apt install -y \
    python3-flake8-docstrings \
    python3-pip \
    python3-pytest-cov \
    ros-dev-tools

RUN apt install -y \
    python3-flake8-blind-except \
    python3-flake8-builtins \
    python3-flake8-class-newline \
    python3-flake8-comprehensions \
    python3-flake8-deprecated \
    python3-flake8-import-order \
    python3-flake8-quotes \
    python3-pytest-repeat \
    python3-pytest-rerunfailures

# create workspace
WORKDIR /root
RUN mkdir /root/pymoveit2
COPY . /root/pymoveit2
RUN rm /root/pymoveit2/build_panda_ign_moveit2.sh
RUN git clone https://github.com/AndrejOrsula/panda_ign_moveit2.git
RUN vcs import < panda_ign_moveit2/panda_ign_moveit2.repos
COPY build_panda_ign_moveit2.sh /root/panda_ign_moveit2/build_panda_ign_moveit2.sh

# rosdep
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN rosdep init
RUN rosdep update

# add to .bashrc
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> .bashrc
RUN echo 'source /root/panda_ign_moveit2/install/local_setup.bash' >> .bashrc
RUN echo 'source /root/pymoveit2/install/local_setup.bash' >> .bashrc

RUN source /opt/ros/${ROS_DISTRO}/setup.bash