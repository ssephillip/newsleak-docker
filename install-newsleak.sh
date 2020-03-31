#Sets up the folders needed to run the docker-compose setup.

#Prerequisites:
#1. docker
#2. docker-compose
#-----------------------------------------------------------

mkdir -p volumes/ui/conf/dictionaries
mkdir -p volumes/ui/data
mkdir -p volumes/ui/doc2vec-training/result
chmod 777 -R volumes/ui
docker network create hoover_default
docker-compose up -d
docker exec -it -u root newsleak ./newsleak-start.sh
docker-compose stop

echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "Setup finished."
echo "You can now start the application."
echo "To start the application please execute:"
echo "docker-compose up -d"
echo "--------------------------------------------------"
echo "--------------------------------------------------"
echo "--------------------------------------------------"
