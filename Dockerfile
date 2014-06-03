FROM walm/node:0.1.1
MAINTAINER Andreas Wålm "andreas@walm.net"

RUN bash -c '\
  apt-get update -qq ;\
  \
  echo "# Installing Redis" ;\
  apt-get -q -y install redis-server ;\
  \
  echo "# Installing Hubot" ;\
  npm install -g hubot coffee-script ;\
  mkdir /hubot && cd /hubot ;\
  hubot --create . ;\
  chmod 755 bin/hubot ;\
  chown -R app:app /hubot ;\
  bin/hubot -h ;\
  \
  echo "# Cleaning up" ;\
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /setup /build ;\
'
# END RUN

ADD redis.sh /etc/service/redis/run
ADD hubot.sh /etc/service/hubot/run

VOLUME ["/hubot"]

EXPOSE 8080
