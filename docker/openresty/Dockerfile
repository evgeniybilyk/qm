FROM openresty/openresty:xenial

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    luarocks \
    libssl-dev \
    dnsmasq \
    git \
    systemtap

RUN /usr/local/openresty/bin/opm install openresty/lua-resty-redis
RUN /usr/local/openresty/bin/opm install agentzh/lua-resty-http

RUN /usr/local/openresty/luajit/bin/luarocks install luautf8
#RUN /usr/local/openresty/luajit/bin/luarocks install lua-cjson
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-mysql
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-string
RUN /usr/local/openresty/luajit/bin/luarocks install luasocket
RUN /usr/local/openresty/luajit/bin/luarocks install luacrypto
RUN /usr/local/openresty/luajit/bin/luarocks install luasec
RUN luarocks install luasocket
RUN /usr/local/openresty/luajit/bin/luarocks install net-url
RUN cd && git clone https://github.com/openresty/openresty-systemtap-toolkit.git
RUN cd && git clone https://github.com/openresty/stapxx.git

RUN apt-get install -y cmake libbson-dev
RUN cd && \
    git clone https://github.com/isage/lua-cbson.git && \
    cd lua-cbson && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

RUN cd /tmp && \
    git clone https://github.com/wingify/lua-resty-rabbitmqstomp.git && \
    cd lua-resty-rabbitmqstomp && \
    make install

RUN sed -i '/http {/ a\ include conf.d/*;' /usr/local/openresty/nginx/conf/nginx.conf && \
    mkdir -p /usr/local/openresty/nginx/conf/conf.d && \
    echo '#!/bin/bash' >> /opt/entry-point.sh && \
    echo 'service dnsmasq start' >> /opt/entry-point.sh && \
    echo '/usr/local/openresty/bin/openresty -g "daemon off;"' >> /opt/entry-point.sh

ENTRYPOINT ["/bin/bash", "/opt/entry-point.sh"]