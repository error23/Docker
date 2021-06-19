FROM fedora:34

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.0"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

# Initialise global values
ENV     TERM=xterm
WORKDIR /root/

# Install system dependencies
RUN dnf -y install dnf-plugins-core
RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf update -y
RUN dnf upgrade -y

RUN dnf install -y tree
RUN dnf install -y fortune-mod
RUN dnf install -y cowsay
RUN dnf install -y vim-ansible vim-command-t vim-devicons vim-enhanced vim-gitgutter vim-javabrowser vim-nerdtree vim-nerdtree-git-plugin vim-omnicppcomplete vim-powerline vim-syntastic-c vim-syntastic-cpp vim-syntastic-css vim-syntastic-html vim-syntastic-java vim-syntastic-json vim-syntastic-lua vim-syntastic-sh vim-syntastic-text vim-syntastic-vim vim-syntastic-xml vim-syntastic-yaml vim-taglist vim-toml vim-trailing-whitespace
RUN dnf install -y git
RUN dnf install -y git-lfs
RUN dnf install -y maven
RUN dnf install -y gettext
RUN dnf install -y docker-ce docker-ce-cli containerd.io

# Copy resources
COPY "config/" "/root/"

# Install Oracle jdk 11
COPY CircleCi/jdk-11.0.11_linux-x64_bin.rpm /root/jdk.rpm
RUN rpm --force --nosignature -ivh jdk.rpm
RUN rm *

RUN git config --global user.email "error23.d@gmail.com"
RUN git config --global user.name "error23"

CMD systemctl start docker
CMD bash
