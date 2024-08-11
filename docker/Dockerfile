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

RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

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
COPY ../../pymoveit2 /root/pymoveit2
RUN rm -r /root/pymoveit2/bin /root/pymoveit2/docker
RUN git clone https://github.com/AndrejOrsula/panda_ign_moveit2.git

# rosdep
RUN rm /etc/ros/rosdep/sources.list.d/20-default.list
RUN rosdep init
RUN rosdep update

RUN mkdir /root/bin
COPY ../bin /root/bin

# add to .bashrc
RUN echo 'export PATH=$PATH:/root/bin' >> .bashrc
RUN echo 'source /opt/ros/${ROS_DISTRO}/setup.bash' >> .bashrc