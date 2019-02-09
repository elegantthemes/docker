ARG PHP_VERSION=7.3.0

FROM elegantthemes/php:${PHP_VERSION}

# Version of WordPress to be used by this image
ARG WP_VERSION=5.0.3
# This image's version
ARG IMAGE_VERSION=5.0.3
# Absolute path to WordPress files inside the container
ARG VIRTUAL_ROOT=/workspace/wordpress
# Site URL
ARG VIRTUAL_HOST=local.divi-dev.site

ENV \
	IMAGE_VERSION=${IMAGE_VERSION} \
	WP_VERSION=${WP_VERSION} \
	VIRTUAL_ROOT=${VIRTUAL_ROOT} \
	VIRTUAL_HOST=${VIRTUAL_HOST}

RUN set -e \
	&& export DEBIAN_FRONTEND=non-interactive \
	&& echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections \
	&& apt-upgrade \
	&& apt-install \
		apt-transport-https \
		git \
		less \
		openssh-client \
		sudo \
		unzip \
		zip \
		nginx \
		gettext \
	# Nginx
	&& mkdir -p /var/log/nginx \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	# Yarn Repo
	&& curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
	&& echo 'deb https://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list \
	# NodeJS
	&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
	&& apt-install nodejs yarn \
	# WP-CLI
	&& curl -L https://cdn.rawgit.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/bin/wp \
	&& chmod +x /usr/bin/wp \
	# Cleanup
	&& rm -rf /home/*/.wp-cli \
	&& apt-get -y purge python3 \
	&& docker-clean

WORKDIR /workspace

ADD _rootfs /

ARG REV=''
# Version label variable expansion examples ($PHP_VERSION == '5.6.31'):
#   - If $REV == '', version label will be 5.6.31
#   - If $REV == '2', version label will be 5.6.31_2
LABEL \
	org.label-schema.name='Divi Development Environment' \
	org.label-schema.version=${IMAGE_VERSION}${REV:+_${REV}}
