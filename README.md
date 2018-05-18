# newsleak-docker

Docker configuration to run new/s/leak

## Installation

Install docker.

Checkout this repository.

```
git clone https://github.com/uhh-lt/newsleak-docker.git
cd newsleak-docker
``` 

Run docker-compose. You may want to edit the `postgres.env` file to setup your own db password.

```
docker-compose up -d
```

## Data import

Newsleak is closely integrated with [Hoover](https://hoover.github.io), a software suite to extract texts from large collections of documents. We assume that you already have an instance of Hoover running on your machine which has imported the collection `testcollection`. To setup Hoover and extract texts from your collection, please follow the instructions on this page: [Hoover Docker Setup](https://github.com/hoover/docker-setup).

1. Once Hoover is running, edit `volumes/ui/newsleak.properties` to configure newsleak. First, copy it to the volume location `./volumes/ui/conf` and set write permissions.

```
docker exec -it newsleak-docker_newsleak-ui_1 cp -r /opt/newsleak/preprocessing/conf /etc/settings
docker exec -it newsleak-docker_newsleak-ui_1 chmod -R 777 /etc/settings/conf
```

2. Then, open the file with your favorite text editor, e.g. nano.

```
nano volumes/ui/conf/newsleak.properties
```

You may use the example data or copy your own data files into the `volumes/ui` folder and point to them in the properties file. If you changed the db password in the previous step, change it in the properties file, too.

To select which languages newsleak should process, set `processlanguages` to a list of ISO 639-3 codes in the properties file.

For very long documents, newsleak can split texts into paragraphs of a certain minimum length. To enable splitting of document texts set `paragraphsasdocuments=true`

You also can use additional dictionaries to annotate your texts. Place dictionary text files (format: one term per line) into `volumes/ui/conf/dictionaries`. The dictionary category label will be inferred from the dictionary textfile name, e.g. `fck.eng` containing a list of English swear words, one per line, can be used to annotate occurrence of those swear words with the label FCK.

3. Run preprocessing for information extraction.

```
docker exec -it newsleak-docker_newsleak-ui_1 sh -c "cd /opt/newsleak/preprocessing && java -Xmx10g -jar target/preprocessing-0.9-jar-with-dependencies.jar -c /etc/settings/conf/newsleak.properties"
```

Open the UI application in your browser

```
http://localhost:9000
```


## Troubleshooting

1. Not enough RAM: Preprocessing will be slow or even abort, if your Docker setup has not enough memory. Allow to use at least 8 GB.
2. Different docker naming: docker-compose will use the directory name containing `docker-compose.yml` as a prefix for orchestrated containers. If you have placed it in a directory other than `newsleak-docker` you need to change the commands above accordingly.
  
