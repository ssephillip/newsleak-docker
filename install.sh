#Prerequisites:
#1. git
#2. docker
#3. docker-compose
git clone https://github.com/ssephillip/newsleak-docker.git
cd newsleak-docker
docker-compose up -d
docker exec -it -u root newsleak ./newsleak-start.sh
docker-compose -f docker-compose.front-end.yml up -d
echo "Setup finished. Application started."
