FROM openjdk:8-jre-alpine

MAINTAINER Bubble Shrimp <bingdianfeishui@gmail.com>

ADD ./solr_with_IK.tar.gz /
ADD ./start.sh /opt/solr
RUN chmod u+x /opt/solr/start.sh

ENTRYPOINT ["/bin/sh", "/opt/solr/start.sh"]
