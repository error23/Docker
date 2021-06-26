FROM fedora:34

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.2"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

# Setup locale to french
RUN dnf install -y glibc-langpack-fr*
ENV LANG="fr_FR.UTF-8"
ENV LC_CTYPE="fr_FR.UTF-8"
ENV LC_NUMERIC="fr_FR.UTF-8"
ENV LC_TIME="fr_FR.UTF-8"
ENV LC_COLLATE="fr_FR.UTF-8"
ENV LC_MONETARY="fr_FR.UTF-8"
ENV LC_MESSAGES="fr_FR.UTF-8"
ENV LC_PAPER="fr_FR.UTF-8"
ENV LC_NAME="fr_FR.UTF-8"
ENV LC_ADDRESS="fr_FR.UTF-8"
ENV LC_TELEPHONE="fr_FR.UTF-8"
ENV LC_MEASUREMENT="fr_FR.UTF-8"
ENV LC_IDENTIFICATION="fr_FR.UTF-8"

# Set timezone to Paris
RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Initialise global values
ENV TERM=xterm-256color
ENV JAVA_HOME=/usr/java/jdk-11.0.11
ENV JDK_HOME=/usr/java/jdk-11.0.11
ENV JAVAC=$JDK_HOME/bin/javac
ENV SCRIPTE_BIN=/root/bin
ENV PATH=$JAVA_HOME:$JAVA_HOME/bin:$SCRIPTE_BIN:$PATH

RUN chmod +x /root/
WORKDIR /root/

# Install system dependencies
RUN dnf -y install dnf-plugins-core
RUN dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
RUN dnf update -y
RUN dnf upgrade -y

RUN dnf install -y tree
RUN dnf install -y fortune-mod
RUN dnf install -y cowsay
RUN dnf install -y figlet
RUN dnf install -y vim-ansible vim-command-t vim-devicons vim-enhanced vim-gitgutter vim-javabrowser vim-nerdtree vim-nerdtree-git-plugin vim-omnicppcomplete vim-powerline vim-syntastic-c vim-syntastic-cpp vim-syntastic-css vim-syntastic-html vim-syntastic-java vim-syntastic-json vim-syntastic-lua vim-syntastic-sh vim-syntastic-text vim-syntastic-vim vim-syntastic-xml vim-syntastic-yaml vim-taglist vim-toml vim-trailing-whitespace

# Copy global configurations
COPY "config/" "/root/"

# Set scriptes permissions
RUN rm *
RUN mkdir $SCRIPTE_BIN
COPY Fedora/init.conf $SCRIPTE_BIN

# Install Oracle jdk 11
COPY Fedora/jdk-11.0.11_linux-x64_bin.rpm /root/jdk.rpm
RUN rpm --force --nosignature -ivh jdk.rpm
RUN rm jdk.rpm

ENTRYPOINT /bin/bash
