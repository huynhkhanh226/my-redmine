https://github.com/docker-library/redmine/blob/fbcfabeed6d6708bc2d07b7f3901dc950b1593e0/Dockerfile.template

# Build image từ Dockerfile
docker build -t my-redmine . --progress=plain

# Khởi chạy container
docker compose up -d
docker-compose up -d --build


# ssh
docker exec -it my-mysql bash

# backup out of container
docker exec my-mysql mysqldump -u root -p my_database > backup.sql

docker exec my-mysql mysqldump -u root -pMySecretPass my_database > backup.sql

# backup into container
mysqldump -u root -p my_database > /tmp/backup.sql

# copy out container
docker cp my-mysql:/tmp/backup.sql ./backup.sql

# shutdown khi treo, sau đó mở lại
 wsl --shutdown

# Informtion
Rocky Linux 9
ruby 3.3.8 (2025-04-09 revision b200bad6cd) [x86_64-linux]
gem 3.7.2
Bundler version 2.7.2
stringio change from 3.1.1 3.1.7 (gem 'stringio', '3.1.7')
Phusion Passenger(R) 6.1.0
Server version: Apache/2.4.62 (Rocky Linux), Server built:   Jul 15 2025 00:00:00




