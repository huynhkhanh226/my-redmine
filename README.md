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
rails (7.2.2.2)



Name         : ImageMagick
Version      : 6.9.13.25
Release      : 1.el9
Architecture : x86_64
Size         : 238 k
Source       : ImageMagick-6.9.13.25-1.el9.src.rpm
Repository   : @System
From repo    : epel
Summary      : An X application for displaying and manipulating images
URL          : https://legacy.imagemagick.org/
License      : ImageMagick
Description  : ImageMagick is an image display and manipulation tool for the X
             : Window System. ImageMagick can read and write JPEG, TIFF, PNM, GIF,
             : and Photo CD image formats. It can resize, rotate, sharpen, color
             : reduce, or add special effects to an image, and when finished you can
             : either save the completed work in the original format or a different
             : one. ImageMagick also includes command line programs for creating
             : animated or transparent .gifs, creating composite images, creating
             : thumbnail images, and more.
             :
             : ImageMagick is one of your choices if you need a program to manipulate
             : and display images. If you want to develop your own applications
             : which use ImageMagick code or APIs, you need to install
             : ImageMagick-devel as well.


Name         : ImageMagick-devel
Version      : 6.9.13.25
Release      : 1.el9
Architecture : x86_64
Size         : 511 k
Source       : ImageMagick-6.9.13.25-1.el9.src.rpm
Repository   : @System
From repo    : epel
Summary      : Library links and header files for ImageMagick app development
URL          : https://legacy.imagemagick.org/
License      : ImageMagick
Description  : ImageMagick-devel contains the library links and header files you'll
             : need to develop ImageMagick applications. ImageMagick is an image
             : manipulation program.
             :
             : If you want to create applications that will use ImageMagick code or
             : APIs, you need to install ImageMagick-devel as well as ImageMagick.
             : You do not need to install it if you just want to use ImageMagick,
             : however.



