FROM nginx:latest

RUN apt-get update \
  && apt-get install -y unzip \
  && apt-get install -y git \
  && apt-get install -y dnsutils

ADD files/start.sh /bin/start.sh
ADD files/generate-ssl-certs.sh /bin/generate-ssl-certs.sh

RUN chmod +x /bin/start.sh
RUN chmod +x /bin/generate-ssl-certs.sh

RUN cd /opt \
  && git clone https://github.com/certbot/certbot

ADD https://releases.hashicorp.com/consul-template/0.12.2/consul-template_0.12.2_linux_amd64.zip /usr/bin/
RUN unzip /usr/bin/consul-template_0.12.2_linux_amd64.zip -d /usr/local/bin

RUN mkdir /app
RUN mkdir /api

ADD files/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443
ENTRYPOINT ["/bin/start.sh"]
