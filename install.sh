git clone https://github.com/ssephillip/newsleak-docker.git
cd newsleak-docker
docker-compose up -d
docker exec -it -u root newsleak ./newsleak-start.sh
echo "Setup finished. Application started."
