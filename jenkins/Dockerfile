FROM openjdk:8u121-jdk-alpine

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG JENKINS_VERSION=2.96
ARG DOWNLOAD_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war

# VOLUME /var/jenkins_home - bind this in via -v if you want to make this persistent.
ENV JENKINS_HOME /var/jenkins_home

ADD entrypoint.sh /entrypoint.sh
	
RUN mkdir -p $JENKINS_HOME /opt/jenkins && \
	chmod +x /entrypoint.sh && \
    chown ${uid}:${gid} $JENKINS_HOME && \
    addgroup -g ${gid} ${group} && \
    adduser -h "$JENKINS_HOME" -u ${uid} -G ${group} -s /bin/bash -D ${user}

RUN apk update && \
	apk add --no-cache git curl bash ttf-dejavu && \
	curl -SL "$DOWNLOAD_URL" -o /opt/jenkins/jenkins.war

# setting starter
USER ${user}

# for main web interface:
EXPOSE ${http_port}

# will be used by attached slave agents:
EXPOSE ${agent_port} 

VOLUME ["/var/jenkins_home"]

CMD ["/entrypoint.sh"]