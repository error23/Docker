FROM error23/fedora:1.2

# Metadata
LABEL author     = "error23"
LABEL email      = "error23.d@gmail.com"
LABEL version    = "1.2"
LABEL created    = "19/06/2021"
LABEL maintainer = "error32 <error23.d@gmail.com>"

# Environement variables
ENV PATH=$PATH:/srv/bin

# Install system dependencies
RUN dnf install -y postgresql
RUN dnf install -y postgresql-server
RUN dnf install -y postgresql-contrib

# General configuration
COPY config/ /var/lib/pgsql
RUN ln -s /var/lib/pgsql /srv/
RUN ln -s /var/log/ /srv/
RUN mkdir /srv/bin
RUN mkdir /srv/sql && chown root:postgres /srv/sql && chmod 774 /srv/sql
WORKDIR /srv

# Configure postgresql
RUN touch log/postgresql.log && chown postgres:postgres log/postgresql.log
COPY SpringBoot/postgres-start.sh bin
RUN chmod +x bin/postgres-start.sh

# Configure spring boot
COPY SpringBoot/spring-boot-start.sh bin
RUN chmod +x bin/spring-boot-start.sh

ENTRYPOINT su postgres -c postgres-start.sh && spring-boot-start.sh && /bin/bash
