FROM error23/fedora

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.0"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

# Install system dependencies
RUN dnf install -y postgresql
RUN dnf install -y postgresql-server
RUN dnf install -y postgresql-contrib

# General configuration
RUN ln -s /var/lib/pgsql /srv/
RUN ln -s /var/log/ /srv/
RUN mkdir /srv/bin
WORKDIR /srv

# configure postgresql
RUN touch log/postgresql && chown postgres:postgres log/postgresql
COPY SpringBoot/postgres-start.sh bin
RUN chmod +x bin/postgres-start.sh

ENTRYPOINT su postgres -c bin/postgres-start.sh && /bin/bash
