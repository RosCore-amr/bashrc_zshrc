# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="gozilla"
plugins=(python git jsontools)
plugins=(zsh-syntax-highlighting)
plugins=(zsh-autosuggestions)

# plugins=(conda-zsh-completion)

source $ZSH/oh-my-zsh.sh

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# PATH AND SOURCE
# PATH=/bin:/usr/bin:/usr/local/bin:${PATH}
export PATH="$HOME/.local/bin:$PATH"
export PATH
export ROS_HOSTNAME=localhost
export ROS_MASTER_URI=http://localhost:11311
export ROS_SETING="/opt/ros/jazzy"
export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity} {time}] [{name}][{line_number}]: {message}"
# export ROS_LOG_DIR=~/my_logs

# export ROS_DOMAIN_ID=2
# export ROS_LOCALHOST_ONLY=2
export ROS_AUTOMATIC_DISCOVERY_RANGE=LOCALHOST
# export ROS_STATIC_PEERS=192.168.1.10,192.168.1.11


export WS="ws"
export ROS_WS="$HOME/$WS"
export _colcon_cd_root=${ROS_WS}
# export _colcon_cd_root=~/ws_learn

# export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
# export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
# export CC="/usr/lib/ccache/gcc"
# export CXX="/usr/lib/ccache/g++"
# export CXX=clang++
# export CC=clang
# export AMENT_PREFIX_PATH=''
# export CMAKE_PREFIX_PATH='' 
# export COLCON_PREFIX_PATH=''
# export ROS_DISTRO=jazzy && \
# export GAZEBO_MODEL_PATH=`ros pkg prefix turtlebot3_gazebo`/share/turtlebot3_gazebo/models/ && \

# SIMULATION TURTELBOT
export TURTLEBOT3_MODEL=burger
# export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/${ROS_DISTRO}/share/turtlebot3_gazebo/models/
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:${ROS_WS}/src/turtlebot3_gazebo/models/
export PYTHONDONTWRITEBYTECODE=1



source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
source /usr/share/colcon_cd/function/colcon_cd.sh
source ${ROS_WS}/install/setup.zsh
source ${ROS_WS}/install/local_setup.zsh
source ${ROS_SETING}/setup.zsh
# source /usr/share/gazebo/setup.sh

# EVAL
eval "$(register-python-argcomplete ros2)"
eval "$(register-python-argcomplete colcon)"
eval "$(register-python-argcomplete colcon_cd)"


# SHORTCUT COMMAND
cmo() { cd $ROS_WS && colcon build --symlink-install --packages-select "$@" ;}
cmdp() {cd $ROS_WS && colcon build --packages-up-to "$@" ;}
_permision () { sudo chmod +x "$@" && sudo chmod 777 "$@" ;}
_gcc() { g++ -o output "$@" && ./output && rm output;}
_remove() { sudo rm -rf "$@" ;}
_vpn() {sudo systemctl "$@" openvpn-server@server;}
_kport() {sudo fuser -k -n tcp "$@";}
_port() {sudo  sudo fuser "$@"/tcp;}
_pip() {pip install "$@" --break-system-packages;}

_ip() { dig -"$@" TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}' ;}
expose() { cloudflared tunnel --url http://localhost:"$@" ;}

rtopic() {ros2 run risk_management echo_topic "$@";}
_rtopic() {
    local topics
    topics=(${(f)"$(ros2 topic list 2>/dev/null)"})
    _describe 'ros2 topics' topics
}
compdef _rtopic rtopic
# compdef rtopic='ros2 topic echo'

rospy_pack() { ros2 pkg create --build-type ament_python "$@" --dependencies rclpy ;}
roscpp_pack() { ros2 pkg create --build-type ament_cmake "$@" --dependencies rclcpp ;}


# ALIAS
alias _source="source ~/.zshrc"
alias sysboost=" sudo apt update && sudo apt upgrade -y && sudo apt-get update && sudo apt-get upgrade -y && sudo aptitude safe-upgrade -y "
alias ip_="ifconfig | awk '/inet 192.168./ {print $2}'"

# LIST
alias lwifi="sudo grep psk= /etc/NetworkManager/system-connections/*"
alias lsof="sudo lsof -i -P -n | grep LISTEN"
alias lsystemctl="sudo systemctl list-unit-files --type=service"
alias ls_blk="sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL|grep -v loop"
alias ls_par="sudo parted -l" # Cannot run if Gparted is running
alias la='ls /dev |grep ttyACM'
alias lu='ls /dev |grep ttyUSB'
# alias lbroker="mosquitto_sub -v -t '#' -h 192.168.1.237 -p 1883"
alias lps="cd ~/Documents && gedit pass.txt"
alias english="cd ~/Documents && gedit vocabulary.txt"


alias python=/usr/bin/python3
alias vpl='pip freeze --local'
alias ntl="nautilus ."
alias off="sudo shutdown -h now"
alias logout="gnome-session-quit --no-prompt"
alias share='export ROS_MASTER_URI=http://192.168.20.254:11311'
alias size='du -sh'
alias sort_by_size='du -hsc * | sort -h'

# GIT
alias giturl='echo "git@gitlab.com:mkac-agv/"'
alias gitagvdev='echo "git@gitlab.com:mkac-agv/"'
alias gba='git branch -a'
alias gs='git status'
alias gl='git log --oneline'
alias gr='git remote show origin'
alias gitignore_refresh='git rm -rf --cached . && git add .'
alias gsma='git submodule add'
alias gsls='git ls-files --stage | grep ^160000'
alias gsst='git submodule status'
alias gsupdate_remote='git submodule update --init --recursive --remote'
alias gsreset_hard_all='git submodule foreach git reset --hard'
alias rviz='ros2 run rviz2 rviz2'

# ROS
alias ros="ros2"
alias cm='cd $ROS_WS && colcon build --symlink-install'
alias cmi='cd $ROS_WS && ./ignore_build.sh'
alias cw='cd $ROS_WS'
alias cs='cd $ROS_WS/src'
alias rdi='rosdep install --from-paths src --ignore-src -r -i -y --rosdistro ${ROS_DISTRO}'
alias tree_tf='ros2 run rqt_tf_tree rqt_tf_tree --force-discover'
alias killros="cd ~/Documents && ./kill_ros_nodes.sh "
alias tf='ros2 run tf2_tools view_frames && evince frames.pdf &'
alias clrpath="export AMENT_PREFIX_PATH='' && export CMAKE_PREFIX_PATH='' && export COLCON_PREFIX_PATH=''"

# eval "pip completion --zsh"
xset r on
