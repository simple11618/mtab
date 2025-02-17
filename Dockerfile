FROM alpine:3.13
LABEL describe="tushan-mtab"
LABEL author ="tushan<admin@mcecy.com>"

WORKDIR /



COPY ./docker/install.sh ./docker/start.sh /
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/default.conf /etc/nginx/http.d/default.conf
COPY ./docker/www.conf /etc/php7/php-fpm.d/www.conf
COPY ./docker/redis.conf /opt/redis.conf
COPY ./docker/php.ini /etc/php7/php.ini

COPY . /www


## change dir owner nginx, create images common path
RUN mkdir /app && mkdir -p /app/public/images && chmod -R 777 /app/public/images &&   chown -R 100.101 /app /www


#ENV SYSTEM_TYPE='Synology'

RUN chmod +x /install.sh && chmod +x /start.sh && /bin/sh /install.sh && rm /install.sh


EXPOSE 80

CMD ["/bin/bash","/start.sh"]


#构建全平台 docker buildx create --name mybuilder --driver docker-container --use
#构建全平台 docker buildx build --no-cache --platform linux/amd64,linux/arm64,linux/arm/v7,linux/arm/v6,linux/amd64/v3 -t itushan/mtab --push .
#构建本地镜像 docker build -t itushan/mtab .

