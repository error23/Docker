FROM error23/fedora

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.0"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

# Install system dependencies
RUN dnf install -y git
RUN dnf install -y git-lfs
RUN dnf install -y maven
RUN dnf install -y gettext
RUN dnf install -y docker-ce docker-ce-cli containerd.io

#configure git
RUN git config --global user.email "error23.d@gmail.com"
RUN git config --global user.name "error23"

# start commands
CMD systemctl start docker
ENTRYPOINT bash
