FROM debian
MAINTAINER Franklyn Tackitt <frank@comanage.com>


RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
# Development files
      apt-utils build-essential git software-properties-common \
# Python libraries
      python python-dev python-setuptools \
# uWSGI for hosting applications
      uwsgi uwsgi-plugin-python \
# Supervisor to manage the uwsgi instance
      supervisor \
# Nginx for wsgi socket handling
      nginx \
# Libraries
      libpq-dev fontconfig libfontconfig1 libfreetype6 libjpeg62-turbo libxrender1 libffi-dev postgresql-server-dev-9.4 \
# Fonts
      xfonts-base xfonts-75dpi \
# Useful tools
      postgresql-client-9.4 gnupg curl && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN easy_install -U pip

# wkhtmltopdf-static, since we need the static version
COPY ./wkhtmltox-0.12.2.4_linux-jessie-amd64.deb /tmp/wkhtmltox.deb
RUN dpkg -i /tmp/wkhtmltox.deb

# Just install this now, since its a big build
RUN pip install \
      cryptography \
      newrelic \
      urllib3 \
      pyopenssl \
      ndg-httpsclient \
      pyasn1 \
      six
