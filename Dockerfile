FROM mbe1224/confluent-osp-base:jesse-slim-8u144-2.11.11-3.2.2

ENV COMPONENT=kafka

# primary
EXPOSE 9092

RUN echo "===> installing ${COMPONENT}..." \
    && apt-get update && apt-get install -y confluent-kafka-${SCALA_VERSION}=${KAFKA_VERSION}-${CONFLUENT_DEB_VERSION} \
    && echo "===> clean up ..."  \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* \  
    && echo "===> Setting up ${COMPONENT} dirs..." \
   	&& mkdir -p /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets /etc/confluent/docker \
   	&& chmod -R ag+w /etc/${COMPONENT} /var/lib/${COMPONENT}/data /etc/${COMPONENT}/secrets \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/configure" -O "/etc/confluent/docker/configure" \
    && echo "8613e0fdd9515676118eacd5fe94a2698684e8abff75251c287c06c0a9a4e8e7" "/etc/confluent/docker/configure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/ensure" -O "/etc/confluent/docker/ensure" \
    && echo "abec01e10f815f84b943f8026fac0e5f20bf855f92e3514ae1ef98497bf8045b" "/etc/confluent/docker/ensure" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/kafka.properties.template" -O "/etc/confluent/docker/kafka.properties.template" \
    && echo "caea8c8d588580e252c58a042bc5aa7e9307a2aa587f499ad36905c268daa1ff" "/etc/confluent/docker/kafka.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/launch" -O "/etc/confluent/docker/launch" \
    && echo "cd73a7ea26bc9b686fce03ad2d45e32683958fd84dd8595cb1a34639cac182d4" "/etc/confluent/docker/launch" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/log4j.properties.template" -O "/etc/confluent/docker/log4j.properties.template" \
    && echo "4d97210466fa3797187a0b0a762ab66d49cfba820fea4d8f77271ceb41dcfaa1" "/etc/confluent/docker/log4j.properties.template" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/run" -O "/etc/confluent/docker/run" \
    && echo "4a83d37b42ca102b8d27ff7bfca74f70499bf8db22991d5732bdaf137afcb5a5" "/etc/confluent/docker/run" | sha256sum -c - \
    && wget "https://raw.githubusercontent.com/confluentinc/cp-docker-images/3.2.x/debian/kafka/include/etc/confluent/docker/tools-log4j.properties.template" -O "/etc/confluent/docker/tools-log4j.properties.template" \
    && echo "56a90e03fa3cf9bb6b745e06c029dd7fe8af34df51d992deda13eaf2428fbca5" "/etc/confluent/docker/tools-log4j.properties.template" | sha256sum -c -

VOLUME ["/var/lib/${COMPONENT}/data", "/etc/${COMPONENT}/secrets"]

CMD ["/etc/confluent/docker/run"]


