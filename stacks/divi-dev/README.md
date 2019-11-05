# Divi Development Environment

## Services
* [mariadb](https://hub.docker.com/_/mariadb)
* [wordpress (elegantthemes/divi-dev)](https://github.com/elegantthemes/docker/services/divi-dev)

## Use It
```
docker-compose up -d
docker-compose exec -u 1000 wordpress divi-dev setup
```
