# Use a Rocky Linux base image
FROM rockylinux:9

# Tạo user hệ thống có ID < 1000 để chay daemon
RUN useradd -r -m -d /opt/redmine redmine

# Cài repos list
RUN dnf install epel-release -y

RUN dnf install httpd -y

RUN usermod -aG redmine apache

RUN dnf config-manager --set-enabled crb

RUN dnf install ruby-devel \
	rpm-build \
	wget \
	git \
	tini \
	libxml2-devel \
	vim \
	make \
	openssl-devel \
	automake \
	libtool \
	mariadb-devel \
	gcc \
	httpd-devel \
	libcurl-devel \
	gcc-c++ \
	libyaml-devel \
	procps-ng -y

# RUN dnf install ImageMagick \
# 	ImageMagick-devel -y


RUN dnf module list ruby

RUN dnf module install ruby:3.3 -y

# ENV VER=5.1.0

# RUN curl -s https://www.redmine.org/releases/redmine-$VER.tar.gz

# COPY redmine-$VER.tar.gz /tmp/

# RUN tar xz -f /tmp/redmine.tar.gz -C /opt/redmine/ --strip-components=1 \
#     && chown -R redmine:redmine /opt/redmine

WORKDIR /opt/redmine

COPY . ./

RUN chown -R redmine:redmine /opt/redmine

RUN ls -alh /opt/redmine

RUN su - redmine

WORKDIR /opt/redmine

# RUN cp config/configuration.yml.example config/configuration.yml

# RUN cp config/database.yml.example config/database.yml

RUN gem install bundler

RUN bundle config set --local path 'vendor/bundle'

RUN bundle config set --local without 'development test'

RUN set -eux; \
    echo "=== Ruby version ==="; \
    ruby -v; \
    echo "=== RubyGems version ==="; \
    gem -v; \
    echo "=== Bundler version ==="; \
    bundle -v || echo "Bundler chưa cài"; \
    echo "======================="

# Cập nhật RubyGems và Bundler
RUN gem install rubygems-update --no-document \
 && update_rubygems \
 && gem install bundler

RUN gem install stringio -v 3.1.7

RUN bundle install

RUN bundle exec rake generate_secret_token

RUN mkdir -p tmp log tmp/pdf public/plugin_assets

RUN chown -R redmine:redmine files log tmp public/plugin_assets

RUN chmod -R 755 /opt/redmine/

RUN su - redmine

# RUN echo 'gem "webrick"' >> Gemfile

# RUN bundle install

# RUN firewall-cmd --add-port=3000/tcp --permanent; \
#	firewall-cmd --reload

# RUN curl --fail -sSLo \
# /etc/yum.repos.d/passenger.repo \
# https://oss-binaries.phusionpassenger.com/yum/definitions/el-passenger.repo


# RUN dnf install -y mod_passenger

# RUN httpd -M | grep passenger

# COPY config/redmine.conf /etc/httpd/conf.d/redmine.conf

RUN gem install passenger --no-document

RUN passenger-install-apache2-module

COPY ./config/00-passenger.conf /etc/httpd/conf.modules.d/00-passenger.conf

COPY ./config/redmine.conf /etc/httpd/conf.d/redmine.conf

CMD ["httpd", "-D", "FOREGROUND"]

# RUN bundle exec rails runner "puts 'Redmine loaded OK'"

