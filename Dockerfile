FROM error23/fedora:1.2

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.3"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

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
COPY CircleCi/setMavenVersion.sh $SCRIPTE_BIN
COPY CircleCi/buildAndDeployDockerImage.sh $SCRIPTE_BIN
RUN chmod +x $SCRIPTE_BIN/*.sh

# Start commands
CMD systemctl start docker
ENTRYPOINT bin/bash
