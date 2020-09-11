FROM			ubuntu:18.04
MAINTAINER  ammar257ammar@gmail.com

USER root

RUN      mkdir /var/run/mysqld && \
		apt-get update && apt-get install -yq \
                wget \
		ant=1.10.5-3~18.04 \
		git \
		software-properties-common \
		mysql-server=5.7.31-0ubuntu0.18.04.1

WORKDIR	/mysql
 
COPY	entrypoint.sh ./

RUN 	chmod 755 entrypoint.sh

RUN	git clone https://github.com/wikipathways/reactome2gpml-converter.git && \
		cd reactome2gpml-converter && \
		ant -d clean jar && \
		cd dist && \
		for f in *.jar; do mv -- "$f" "reactome2gpml.jar"; done

ENTRYPOINT ["/mysql/entrypoint.sh"]
