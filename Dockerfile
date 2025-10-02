# Use a Rocky Linux base image
FROM rockylinux:9

RUN useradd -r -m -d /opt/redmine redmine

RUN dnf -y install httpd ;\
	systemctl enable httpd --now; \
	usermod -aG redmine apache; \
	dnf -y install epel-release; 
	#dnf config-manager --set-enabled powertools; 

RUN dnf -y install epel-release

RUN dnf -y install ruby-devel \
	rpm-build \
	#curl \
	wget \
	libxml2-devel \
	vim \
	make \
	openssl-devel \
	automake \
	libtool \
	ImageMagick \
	ImageMagick-devel \
	gcc \
	httpd-devel \
	libcurl-devel \
	gcc-c++

# RUN dnf module reset ruby -y; \
# 	dnf module enable ruby:3.1 -y; \
# 	dnf -y install ruby ; \
# 	ruby -v

ENV RBENV_ROOT="/root/.rbenv"
ENV PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:$PATH"

# Cài gói hệ thống cần thiết để build Ruby
RUN dnf -y update && \
    dnf -y install git gcc gcc-c++ make patch \
    libffi-devel zlib-devel readline-devel \
    openssl-devel bzip2 autoconf automake \
    #libyaml-devel ncurses-devel gdbm-devel \
    libuuid-devel && \
    dnf clean all

# Kích hoạt CRB repository
RUN dnf install -y dnf-plugins-core && \
    dnf config-manager --set-enabled crb && \
    dnf groupinstall -y "Development Tools" && \
    dnf install -y \
        gcc make \
        openssl-devel readline-devel zlib-devel libffi-devel \
        libyaml-devel gdbm-devel




# Cài rbenv và ruby-build
RUN git clone https://github.com/rbenv/rbenv.git $RBENV_ROOT && \
    git clone https://github.com/rbenv/ruby-build.git $RBENV_ROOT/plugins/ruby-build

# Cài Ruby 3.2.2
RUN $RBENV_ROOT/bin/rbenv install 3.2.2 && \
    $RBENV_ROOT/bin/rbenv global 3.2.2

# Kiểm tra Ruby
RUN ruby -v


ENV VER=5.1.0 
COPY . /usr/src/redmine/
WORKDIR /usr/src/redmine
RUN chown -R redmine:redmine /usr/src/redmine
#RUN cp config/database.yml /opt/redmine/config/database.yml

RUN dnf groupinstall -y "Development Tools" && \
    dnf install -y mariadb-connector-c mariadb-connector-c-devel gcc make


RUN gem install bundler
RUN	bundle config set --local path 'vendor/bundle'
RUN	bundle config set --local without 'development test'
RUN bundle add webrick
RUN	bundle install
#RUN bundle exec rake generate_secret_token

RUN for i in tmp tmp/pdf public/plugin_assets; do \
      [ -d "$i" ] || mkdir -p "$i"; \
    done

RUN chown -R redmine:redmine files log tmp public/plugin_assets
RUN chmod -R 755 /usr/src/redmine
#RUN bundle exec rails server -u webrick -e production
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-e", "production"]



	
