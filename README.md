https://github.com/docker-library/redmine/blob/fbcfabeed6d6708bc2d07b7f3901dc950b1593e0/Dockerfile.template

# Build image từ Dockerfile
docker build -t my-redmine:1.0 .

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

