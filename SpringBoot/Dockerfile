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

# configure postgresql
RUN touch /var/log/postgresql && chown postgres:postgres /var/log/postgresql
COPY SpringBoot/postgres-start.sh /bin
RUN chmod +x /bin/postgres-start.sh
WORKDIR /var/lib/pgsql

ENTRYPOINT su postgres -c /bin/postgres-start.sh && /bin/bash
