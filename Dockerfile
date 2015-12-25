FROM nginx:latest
RUN apt-get update && \
    apt-get install -y pandoc make && \
    rm -rf /var/lib/apt/lists/*
ADD ./nginx.conf /etc/nginx/conf.d/default.conf
ADD . /srv/src
RUN cd /srv/src && make && ln -s `pwd`/public /srv/www
