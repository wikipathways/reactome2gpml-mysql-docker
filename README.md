# reactome2gpml-mysql-docker



This repository is for a Docker image that converts Reactome database to GPML files. 

When running the docker command, the presence of downloaded Reactome MySQL DB dump will be checked in the location "/reactome/gk_current.sql.gz". If the dump does not exist, it will be downloaded automatically from Reactome website "latest release" using the following URL:

https://reactome.org/download/current/databases/gk_current.sql.gz

Next, MySQL instance will startup, the dump's gz file will be unzipped and imported into MySQL. Next, The Java JAR tool "reactome2gpml-converter" - which is cloned from Github and built (using Ant) during the Docker image build process - will be used to convert Reactome pathways from the MySQL DB into GPML files.

The output files will be located in the path "/reactome/pathways".

You need to map the folder inside the docker container "/reactome" into a folder on you host system using the volume mapping argument "-v" in the docker command.

The Docker run command takes one argument which is the Reactome DB version which will appear in the converted GPML files.

There is no need to clone this repository and build the docker image locally since it is hosted on DockerHub. You can just run the following Docker command the get the job done:

```bash
docker run -d --rm --name reactome2gpml -v HOST_OS_PATH:/reactome bigcatum/reactome2gpml-mysql-docker REACTOME_VERSION
```



