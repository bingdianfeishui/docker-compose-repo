FROM openjdk:8-jre-alpine
MAINTAINER Bubble Shrimp <bingdianfeishui@gmail.com>


ADD ./apache-activemq-5.14.5-bin.tar.gz /
ADD ./start.sh /apache-activemq-5.14.5/
RUN rm -rf /apache-activemq-5.14.5-bin.tar.gz

EXPOSE 8161 61616

ENTRYPOINT ["bin/sh", "/apache-activemq-5.14.5/start.sh"]
