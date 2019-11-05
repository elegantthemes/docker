# Divi Development Environment

## What's Included

**Base:** [Ubuntu 18.04.1](https://hub.docker.com/_/ubuntu/)

* [NGINX](https://www.nginx.com)
* [PHP](https://php.net)
* [Xdebug](https://xdebug.org)
* [WordPress](https://wordpress.org)
* [Node.js](https://nodejs.org)
* [Yarn](https://yarnpkg.com)
* [gettext](https://www.gnu.org/software/gettext/)

## Get It
```
docker pull elegantthemes/divi-dev:5.2.4
```

## Use It
* [`docker-compose.yml`](https://github.com/elegantthemes/docker/stacks/divi-dev)
```
docker-compose up -d
docker-compose exec -u 1000 wordpress divi-dev setup
```
