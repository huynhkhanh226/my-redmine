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

RUN dnf install ImageMagick \
	ImageMagick-devel -y


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



✅ Bạn được phép:

Tải về và sử dụng miễn phí ImageMagick cho cá nhân, nội bộ công ty hoặc mục đích thương mại.

Đưa ImageMagick vào sản phẩm hoặc gói phần mềm mà bạn tạo ra.

Kết nối (link) hoặc trộn mã nguồn của ImageMagick với phần mềm có license khác.

Mở rộng quyền sáng chế (patent) cho phần mềm sử dụng mã của ImageMagick.

❌ Bạn không được phép:

Phân phối lại phần mềm có nguồn gốc từ ImageMagick mà không ghi công (attribution) đúng cách.

Sử dụng thương hiệu, logo, tên “ImageMagick” để ngụ ý rằng họ ủng hộ hoặc hợp tác với bạn, trừ khi có phép.

Ngụ ý rằng bạn là người tạo ra phần mềm ImageMagick.

⚖️ Bạn bắt buộc phải:

Đính kèm bản sao license này khi phân phối phần mềm có chứa ImageMagick.

Ghi rõ công lao cho ImageMagick Studio LLC trong tài liệu hoặc phần “About” của sản phẩm.

💡 Bạn không bắt buộc phải:

Cung cấp mã nguồn gốc hoặc mã đã chỉnh sửa khi phân phối phần mềm chứa ImageMagick.

Gửi lại các thay đổi của bạn cho ImageMagick Studio LLC (nhưng được khuyến khích).

ℹ️ Một số điểm bổ sung:

ImageMagick hoàn toàn miễn phí.

Bạn có thể phân phối hoặc bán phần mềm chứa ImageMagick nếu tuân thủ license.

License tương thích với GPLv3 (có thể dùng chung).

Khi xuất khẩu phần mềm có ImageMagick, cần kiểm tra quy định xuất khẩu (export classification).

👉 Tóm tắt ngắn nhất:

Bạn được phép dùng, sửa, và bán phần mềm có chứa ImageMagick, miễn là bạn ghi công cho ImageMagick Studio LLC và không dùng thương hiệu của họ sai mục đích. Không cần công khai mã nguồn hoặc gửi lại thay đổi.



Khi license nói “tuân thủ license” nghĩa là:
✅ Kèm file license của ImageMagick trong gói phân phối.
✅ Ghi công cho ImageMagick Studio LLC ở tài liệu hoặc giao diện phù hợp.

→ Làm đủ hai điều này thì bạn có thể bán, đóng gói, hoặc phân phối sản phẩm chứa ImageMagick hợp pháp và đầy đủ.
