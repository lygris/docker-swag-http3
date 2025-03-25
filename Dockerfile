FROM ghcr.io/linuxserver/swag:latest

RUN apk add --no-cache gcc make build-base linux-headers nginx-mod-http-dav-ext nginx-mod-http-echo nginx-mod-http-fancyindex nginx-mod-http-geoip2 nginx-mod-http-headers-more nginx-mod-http-lua nginx-mod-http-image-filter nginx-mod-http-perl nginx-mod-http-redis2 nginx-mod-http-set-misc nginx-mod-http-upload-progress nginx-mod-http-xslt-filter nginx-mod-mail nginx-mod-rtmp nginx-mod-stream nginx-mod-stream-geoip2 nginx-vim libmaxminddb-dev zeromq-dev pcre-dev zlib-dev openssl-dev git luajit luajit-dev zstd-dev libxml2-dev libxslt-dev libgd gd-dev geoip-dev perl-dev perl-ipc-run perl-io-socket-ssl perl-net-ssleay perl-test-tcp perl-test-warn perl-test-warnings perl-test-warn jansson jansson-dev nginx-mod-http-naxsi


RUN git clone https://github.com/quictls/quictls.git 
RUN cd quictls && ./Configure && make install
RUN cd .. 
RUN export LUAJIT_INC=/usr/include/luajit-2.1 && \
    export LUAJIT_LIB=/usr/lib && \
    export LUAJIT_BIN=/usr/bin && \
    export LUAJIT_VERSION=2.1

RUN mkdir -p /home/buildozer/aports/main/nginx/src && \
    wget -O njs.tar.gz https://github.com/nginx/njs/archive/refs/tags/0.8.9.tar.gz && \
    tar -xvzf njs.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_devel_kit.tar.gz https://github.com/simpl/ngx_devel_kit/archive/refs/tags/v0.3.4.tar.gz && \
    tar -xvzf ngx_devel_kit.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_dynamic_healthcheck.tar.gz https://github.com/ZigzagAK/ngx_dynamic_healthcheck/archive/refs/tags/1.3.8.tar.gz && \
    tar -xvzf ngx_dynamic_healthcheck.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_dynamic_upstream.tar.gz https://github.com/ZigzagAK/ngx_dynamic_upstream/archive/refs/tags/2.3.4.tar.gz && \
    tar -xvzf ngx_dynamic_upstream.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O traffic-accounting-nginx-module.tar.gz https://github.com/Lax/traffic-accounting-nginx-module/archive/refs/tags/v2.0.tar.gz && \
    tar -xvzf traffic-accounting-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O array-var-nginx-module.tar.gz https://github.com/openresty/array-var-nginx-module/archive/refs/tags/v0.06.tar.gz && \
    tar -xvzf array-var-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-auth-jwt.tar.gz https://github.com/kjdev/nginx-auth-jwt/archive/refs/tags/0.9.0.tar.gz && \
    tar -xvzf nginx-auth-jwt.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_cache_purge.tar.gz https://github.com/nginx-modules/ngx_cache_purge/archive/refs/tags/2.5.3.tar.gz && \
    tar -xvzf ngx_cache_purge.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx_cookie_flag_module.tar.gz https://github.com/AirisX/nginx_cookie_flag_module/archive/refs/tags/v1.1.0.tar.gz && \
    tar -xvzf nginx_cookie_flag_module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-dav-ext-module.tar.gz https://github.com/arut/nginx-dav-ext-module/archive/refs/tags/v3.0.0.tar.gz && \
    tar -xvzf nginx-dav-ext-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O echo-nginx-module.tar.gz https://github.com/openresty/echo-nginx-module/archive/refs/tags/v0.63.tar.gz && \
    tar -xvzf echo-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O encrypted-session-nginx-module.tar.gz https://github.com/openresty/encrypted-session-nginx-module/archive/refs/tags/v0.09.tar.gz && \
    tar -xvzf encrypted-session-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx-fancyindex.tar.gz https://github.com/aperezdc/ngx-fancyindex/archive/refs/tags/v0.5.2.tar.gz && \
    tar -xvzf ngx-fancyindex.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_http_geoip2_module.tar.gz https://github.com/leev/ngx_http_geoip2_module/archive/refs/tags/3.4.tar.gz && \
    tar -xvzf ngx_http_geoip2_module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O headers-more-nginx-module.tar.gz https://github.com/openresty/headers-more-nginx-module/archive/refs/tags/v0.38.tar.gz && \
    tar -xvzf headers-more-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-keyval.tar.gz https://github.com/kjdev/nginx-keyval/archive/refs/tags/0.3.0.tar.gz && \
    tar -xvzf nginx-keyval.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-log-zmq.tar.gz https://github.com/danifbento/nginx-log-zmq/archive/refs/tags/v1.0.0.tar.gz && \
    tar -xvzf nginx-log-zmq.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O lua-nginx-module.tar.gz https://github.com/openresty/lua-nginx-module/archive/refs/tags/v0.10.28.tar.gz && \
    tar -xvzf lua-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O lua-upstream-nginx-module.tar.gz https://github.com/openresty/lua-upstream-nginx-module/archive/refs/tags/v0.07.tar.gz && \
    tar -xvzf lua-upstream-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nchan.tar.gz https://github.com/slact/nchan/archive/refs/tags/v1.3.7.tar.gz && \
    tar -xvzf nchan.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O redis2-nginx-module.tar.gz https://github.com/openresty/redis2-nginx-module/archive/refs/tags/v0.15.tar.gz && \
    tar -xvzf redis2-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O set-misc-nginx-module.tar.gz https://github.com/openresty/set-misc-nginx-module/archive/refs/tags/v0.33.tar.gz && \
    tar -xvzf set-misc-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-http-shibboleth.tar.gz https://github.com/nginx-shib/nginx-http-shibboleth/archive/refs/tags/v2.0.2.tar.gz && \
    tar -xvzf nginx-http-shibboleth.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_slowfs_cache.tar.gz https://github.com/dvershinin/ngx_slowfs_cache/archive/refs/tags/1.11.tar.gz && \
    tar -xvzf ngx_slowfs_cache.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_http_untar_module.tar.gz https://github.com/ajax16384/ngx_http_untar_module/archive/refs/tags/v1.1.tar.gz && \
    tar -xvzf ngx_http_untar_module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-upload-module.tar.gz https://github.com/vkholodkov/nginx-upload-module/archive/refs/tags/2.3.0.tar.gz && \
    tar -xvzf nginx-upload-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-upload-progress-module.tar.gz https://github.com/masterzen/nginx-upload-progress-module/archive/refs/tags/v0.9.3.tar.gz && \
    tar -xvzf nginx-upload-progress-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-upstream-fair.tar.gz https://github.com/itoffshore/nginx-upstream-fair/archive/refs/tags/0.1.3.tar.gz && \
    tar -xvzf nginx-upstream-fair.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O ngx_upstream_jdomain.tar.gz https://github.com/nicholaschiasson/ngx_upstream_jdomain/archive/refs/tags/1.5.2.tar.gz && \
    tar -xvzf ngx_upstream_jdomain.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-vod-module.tar.gz https://github.com/kaltura/nginx-vod-module/archive/refs/tags/1.33.tar.gz && \
    tar -xvzf nginx-vod-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-module-vts.tar.gz https://github.com/vozlt/nginx-module-vts/archive/refs/tags/v0.2.3.tar.gz && \
    tar -xvzf nginx-module-vts.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O mod_zip.tar.gz https://github.com/evanmiller/mod_zip/archive/refs/tags/1.3.0.tar.gz && \
    tar -xvzf mod_zip.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O zstd-nginx-module.tar.gz https://github.com/tokers/zstd-nginx-module/archive/refs/tags/0.1.1.tar.gz && \
    tar -xvzf zstd-nginx-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    wget -O nginx-rtmp-module.tar.gz https://github.com/arut/nginx-rtmp-module/archive/refs/tags/v1.2.2.tar.gz && \
    tar -xvzf nginx-rtmp-module.tar.gz -C /home/buildozer/aports/main/nginx/src && \
    git clone https://github.com/google/ngx_brotli.git --recursive /home/buildozer/aports/main/nginx/src/ngx_brotli && \
    git clone https://github.com/wargio/naxsi.git --recursive /home/buildozer/aports/main/nginx/src/naxsi-1.7

RUN wget https://github.com/nginx/nginx/releases/download/release-1.27.4/nginx-1.27.4.tar.gz -O nginx.tar.gz && \
    tar -xvzf nginx.tar.gz && \
    cd nginx-* && \
    ./configure --prefix=/var/lib/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --pid-path=/run/nginx/nginx.pid --lock-path=/run/nginx/nginx.lock --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --with-perl_modules_path=/usr/lib/perl5/vendor_perl --user=nginx --group=nginx --with-threads --with-file-aio --without-pcre2 --with-http_ssl_module --with-http_v2_module --with-http_v3_module --with-cc-opt="-I../quictls/build/include" --with-ld-opt="-L../quictls/build/lib" --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-stream=dynamic --with-stream_ssl_module --with-stream_realip_module --with-stream_geoip_module=dynamic --with-stream_ssl_preread_module  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/njs-0.8.9/nginx  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_devel_kit-0.3.4 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_dynamic_healthcheck-1.3.8 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_dynamic_upstream-2.3.4  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/traffic-accounting-nginx-module-2.0 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/array-var-nginx-module-0.06 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-auth-jwt-0.9.0 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_brotli  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_cache_purge-2.5.3  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx_cookie_flag_module-1.1.0  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-dav-ext-module-3.0.0  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/echo-nginx-module-0.63 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/encrypted-session-nginx-module-0.09 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx-fancyindex-0.5.2 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_http_geoip2_module-3.4 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/headers-more-nginx-module-0.38 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-keyval-0.3.0 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-log-zmq-1.0.0 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/naxsi-1.7/naxsi_src  --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nchan-1.3.7 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/redis2-nginx-module-0.15 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/set-misc-nginx-module-0.33 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-http-shibboleth-2.0.2 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_slowfs_cache-1.11 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_http_untar_module-1.1 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-upload-module-2.3.0 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-upload-progress-module-0.9.3 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-upstream-fair-0.1.3 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/ngx_upstream_jdomain-1.5.2 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-vod-module-1.33 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-module-vts-0.2.3 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/mod_zip-1.3.0 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/zstd-nginx-module-0.1.1 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/nginx-rtmp-module-1.2.2 && make install
    #--add-dynamic-module=/home/buildozer/aports/main/nginx/src/lua-nginx-module-0.10.28 --add-dynamic-module=/home/buildozer/aports/main/nginx/src/lua-upstream-nginx-module-0.07 
