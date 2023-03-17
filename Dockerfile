FROM composer:2.5.4 AS composer

COPY composer.* /composer/

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/composer

RUN composer global install \
  --ignore-platform-reqs \
  --no-dev \
  --no-interaction \
  --no-progress \
  --no-scripts \
  --optimize-autoloader \
  --prefer-dist

FROM php:8.2.4-cli-alpine

COPY --from=composer /composer/ /composer/

ENV PATH=/composer/vendor/bin:${PATH}

WORKDIR /app/

VOLUME ["/app"]
ENTRYPOINT ["phpcs"]
