FROM ubuntu
MAINTAINER jose nazario <jose@monkey.org>
LABEL version="1.0" description="lfi-labs Docker image"

# set up packages
RUN apt-get -y update  
RUN apt-get -y install apache2
RUN apt-get -y install php7.0 libapache2-mod-php7.0
RUN apt-get -y install git

# install lfi-labs from git
ENV LFIDIR=/usr/local/lfi-labs
RUN mkdir $LFIDIR
WORKDIR $LFIDIR
RUN git clone https://github.com/paralax/lfi-labs.git
WORKDIR lfi-labs
RUN cp -r * /var/www/html
WORKDIR /var/www/html
RUN rm -f /var/www/html/Dockerfile /var/www/html/index.html

# configure apache
RUN a2enmod php7.0
RUN a2enmod rewrite
RUN echo "ServerRoot /var/www/html" >> /etc/apache2/apache2.conf

EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND
# CMD /bin/bash

# docker build -t lfi-labs .
# docker run -p 8080:80 lfi-labs
# this doesn't work yet? e.g. i can't daemonize it ... why not?
# docker exec -it $hash /bin/bash