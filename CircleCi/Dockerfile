FROM error23/fedora:1.2

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.2"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

# Environement variables
ENV PATH=/root/bin:$PATH

# Install system dependencies
RUN dnf install -y git
RUN dnf install -y git-lfs
RUN dnf install -y maven
RUN dnf install -y gettext
RUN dnf install -y docker-ce docker-ce-cli containerd.io

# Hack maven
COPY CircleCi/mvn /usr/bin/mvn
RUN chmod +x /usr/bin/mvn

# Configure git
RUN git config --global user.email "error23.d@gmail.com"
RUN git config --global user.name "error23"

# Add usefull scipts
RUN mkdir /root/bin
COPY CircleCi/setMavenVersion.sh /root/bin
COPY CircleCi/buildAndDeployDockerImage.sh /root/bin
RUN chmod +x /root/bin/*

# Start commands
CMD systemctl start docker
ENTRYPOINT bin/bash
