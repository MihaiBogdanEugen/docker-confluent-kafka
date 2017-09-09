# [Confluent Open Source Platform](https://www.confluent.io/product/confluent-open-source/) [Apache Kafka] Docker image using [Oracle JDK] #

### Supported tags and respective Dockerfile links: ###

* ```jesse-slim-8u144-2.11.11-3.2.2``` _\([jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-kafka:jesse-slim-8u144-2.11.11-3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-osp-kafka:jesse-slim-8u144-2.11.11-3.2.2)
* ```jesse-slim-8u144-2.11.11-3.3.0```, ```latest``` _\([jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-osp-kafka:jesse-slim-8u144-2.11.11-3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-osp-kafka:jesse-slim-8u144-2.11.11-3.3.0)

#### All tag names follow the naming convention: ####

```debian_image_tag``` + '-' + ```java_version``` + '-' + ```scala_version``` + '-' + ```confluent_platform_version```

### About: ### 

#### Summary: ####

- Debian "slim" image variant
- Oracle Java SE Development Kit (JDK) 8u144 addded, without MissionControl, VisualVM, JavaFX and JRE
- Oracle Java Cryptography Extension added
- Scala 2.11.11 added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME and SCALA\_HOME environment variables set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')] - a Python CLI for a Confluent tool called [docker-utils]
    - [Docker utility belt script ('dub')]
- [Apache Kafka] added:
    - version 0.10.2.1 in ```jesse-slim-8u144-2.11.11-3.2.2```
    - version 0.11.0.0 in ```jesse-slim-8u144-2.11.11-3.3.0``` and ```latest```

#### More details: ####

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```jesse-slim-8u144-2.11.11-3.2.2``` follows branch [3.2.x], and 
- tags ```jesse-slim-8u144-2.11.11-3.3.0``` and```latest``` follow branch [3.3.x]


Apart of the base image ([confluent-osp-base]), it has [Apache Kafka] added on top of it, installed using the following Confluent Debian package:
- ```confluent-kafka-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-osp-kafka .
```

Run the container
```shell
docker run -d \
    --net=host \
    --name=kafka \
    -e KAFKA_ZOOKEEPER_CONNECT=localhost:12181 \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:19092 \
    -e KAFKA_BROKER_ID=1 \
    -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
    mbe1224/confluent-osp-kafka
```

### Environment variables: ###

One can use the following environment variables for configuring the ZooKeeper node:

| # | Name | Default value | Meaning | Comments |
|---|---|---|---|---|
| 1 | KAFKA\_ADVERTISED\_LISTENERS | - | Advertised listeners is how it gives out a host name that can be reached by the client | - |
| 2 | KAFKA\_BROKER\_ID | - | Node identifier | Required in Kafka replicated scenarios |
| 3 | KAFKA\_CUB\_ZK\_TIMEOUT | 40 | Time in secondss to wait for the Zookeeper to be available | Check the [Confluent utility belt script ('cub')] - ```check_zookeeper_ready``` for more details |
| 4 | KAFKA\_JMX\_OPTS | - | JMX options used for monitoring | KAFKA\_OPTS should contain 'com.sun.management.jmxremote.rmi.port' property |
| 5 | KAFKA\_LOG4J\_LOGGERS | {'kafka': 'INFO','kafka.network.RequestChannel$': 'WARN','kafka.producer.async.DefaultEventHandler': 'DEBUG','kafka.request.logger': 'WARN','kafka.controller': 'TRACE','kafka.log.LogCleaner': 'INFO','state.change.logger': 'TRACE','kafka.authorizer.logger': 'WARN'} | - | - |
| 6 | KAFKA\_LOG4J\_ROOT\_LOGLEVEL | INFO | - | - |
| 7 | KAFKA\_OFFSETS\_TOPIC\_REPLICATION\_FACTOR | 3 | The replication factor for the offsets topic - set higher to ensure availability | Internal topic creation will fail until the cluster size meets this replication factor requirement |
| 8 | KAFKA\_SSL\_KEY\_CREDENTIALS | - | SSL key credentials | Required if SSL is enabled |
| 9 | KAFKA\_SSL\_KEYSTORE\_CREDENTIALS | - | SSL keystore credentials | Required if SSL is enabled |
| 10 | KAFKA\_SSL\_KEYSTORE\_FILENAME | - | SSL keystore filename | Required if SSL is enabled |
| 11 | KAFKA\_SSL\_TRUSTSTORE\_CREDENTIALS | - | SSL trustore credentials | Required if SSL is enabled |
| 12 | KAFKA\_SSL\_TRUSTSTORE\_FILENAME | - | SSL trustore filename | Required if SSL is enabled |
| 13 | KAFKA\_TOOLS\_LOG4J\_LOGLEVEL | WARN | - | - |
| 14 | KAFKA\_ZOOKEEPER\_CONNECT | - | Tells Kafka how to get in touch with ZooKeeper | - |

Moreover, one can use any of the properties specified in the [Configuration Options] \([Broker Configs] and [Topic-level Configs]\) by replacing "." with "\_" and appending "KAFKA\_" before the property name. For example, instead of ```offsets.topic.replication.factor``` use ```KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR```.

### Dual licensed under: ###

* [Apache License]
* [Oracle Binary Code License Agreement]

   [docker-utils]: <https://github.com/confluentinc/cp-docker-images/tree/master/java>
   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Apache Kafka]: <https://kafka.apache.org/>   
   [Configuration Options]: <https://kafka.apache.org/documentation/#configuration>
   [Broker Configs]: <https://kafka.apache.org/documentation/#brokerconfigs>
   [Topic-level Configs]: <https://kafka.apache.org/documentation/#topic-config>
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [jesse-slim-8u144-2.11.11-3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-kafka/blob/jesse-slim-8u144-2.11.11-3.2.2/Dockerfile>
   [jesse-slim-8u144-2.11.11-3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/confluent-osp-kafka/blob/jesse-slim-8u144-2.11.11-3.3.0/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [confluent-osp-base]: <https://hub.docker.com/r/mbe1224/confluent-osp-base/>
   [Apache License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-kafka/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/confluent-osp-kafka/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>