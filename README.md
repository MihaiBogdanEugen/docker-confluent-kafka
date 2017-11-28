## Docker [Kafka] image for the [Confluent Open Source Platform] using [Oracle JDK] ##

### Supported tags and respective Dockerfile links: ###

* ```3.2.2``` _\([3.2.2/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-kafka:3.2.2.svg)](https://microbadger.com/images/mbe1224/confluent-kafka:3.2.2 "")
* ```3.3.0``` _\([3.3.0/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-kafka:3.3.0.svg)](https://microbadger.com/images/mbe1224/confluent-kafka:3.3.0 "")
* ```3.3.1```, ```latest``` _\([3.3.1/Dockerfile]\)_
[![](https://images.microbadger.com/badges/image/mbe1224/confluent-kafka:3.3.1.svg)](https://microbadger.com/images/mbe1224/confluent-kafka:3.3.1 "")

*All tag names follow the naming convention of the [Confluent Open Source Platform]*

### Summary: ###

- Debian "slim" image variant
- Oracle JDK 8u152 addded, without MissionControl, VisualVM, JavaFX, ReadMe files, source archives, etc.
- Oracle Java Cryptography Extension added
- Python 2.7.9-1 & pip 9.0.1 added
- SHA 256 sum checks for all downloads
- JAVA\_HOME environment variable set up
- Utility scripts added:
    - [Confluent utility belt script ('cub')] - a Python CLI for a Confluent tool called [docker-utils]
    - [Docker utility belt script ('dub')]
- [Apache Kafka] added:
    - version 0.10.2.1 in ```3.2.2```
    - version 0.11.0.0 in ```3.3.0```
    - version 0.11.0.1 in ```3.3.1``` and ```latest```

### Details: ### 

This image was created with the sole purpose of offering the [Confluent Open Source Platform] running on top of [Oracle JDK].
Therefore, it follows the same structure as the one from the original [repository]. More precisely:
- tag ```3.2.2``` follows branch [3.2.x], and 
- tags ```3.3.0```, ```3.3.1``` and```latest``` follow branch [3.3.x]


Apart of the base image ([mbe1224/confluent-base]), it has [Apache Kafka] added on top of it, installed using the following Confluent Debian package:
- ```confluent-kafka-2.11```

### Usage: ###

Build the image
```shell
docker build -t mbe1224/confluent-kafka ./3.3.1/
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
    mbe1224/confluent-kafka
```

### Configuration: ###

One can configure a Kafka instance using environment variables. All [Configuration Options] \([Broker Configs] and [Topic-level Configs]\) from the official documentation can be used as long as the following naming rules are followed:
- upper caps
- "." replaced with "\_"
- snake case instead of pascal case
- "KAFKA\_" prefix

For example, in order to set the replication factor for the offsets topic, one has to modifiy the "offsets.topic.replication.factor" property, which is translated in the "KAFKA\_OFFSETS\_TOPIC\_REPLICATION\_FACTOR" environment variable.

#### Kubernetes: ####

For Kubernetes deployments using StatefulSets (or other replication objects), KAFKA\_BROKER\_ID can't be set up in advance. Therefore, one needs to set the IS\_KUBERNETES environemnt variable to a non-null value. In this scenario, KAfka's Broker ID will be generated using the value of the HOSTNAME environment variable. Even more, the KAFKA\_ADVERTISED\_LISTENERS must not be used. Instead, one must set-up only the KAFKA\_LISTENERS. 

Nevertheless, if one uses Pods, than the usual setup can be used and the IS\_KUBERNETES environemnt variable must be ignored.

### Dual licensed under: ###

* [MIT License]
* [Oracle Binary Code License Agreement]

   [docker-utils]: <https://github.com/confluentinc/cp-docker-images/tree/master/java>
   [Confluent Open Source Platform]: <https://www.confluent.io/product/confluent-open-source/>
   [Oracle JDK]: <http://www.oracle.com/technetwork/java/javase/downloads/index.html>
   [Kafka]: <https://kafka.apache.org/> 
   [Apache Kafka]: <https://kafka.apache.org/>      
   [Configuration Options]: <https://kafka.apache.org/documentation/#configuration>
   [Broker Configs]: <https://kafka.apache.org/documentation/#brokerconfigs>
   [Topic-level Configs]: <https://kafka.apache.org/documentation/#topic-config>
   [3.2.2/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-kafka/blob/master/3.2.2/Dockerfile>
   [3.3.0/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-kafka/blob/master/3.3.0/Dockerfile>
   [3.3.1/Dockerfile]: <https://github.com/MihaiBogdanEugen/docker-confluent-kafka/blob/master/3.3.1/Dockerfile>
   [Confluent utility belt script ('cub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/cub>
   [Docker utility belt script ('dub')]: <https://raw.githubusercontent.com/confluentinc/cp-docker-images/df0091f5437113d2764cabb7433eee25fba6a4b6/debian/base/include/dub>  
   [repository]: <https://github.com/confluentinc/cp-docker-images>
   [3.2.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.2.x>
   [3.3.x]: <https://github.com/confluentinc/cp-docker-images/tree/3.3.x>   
   [mbe1224/confluent-base]: <https://hub.docker.com/r/mbe1224/confluent-base/>
   [MIT License]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-confluent-kafka/master/LICENSE>
   [Oracle Binary Code License Agreement]: <https://raw.githubusercontent.com/MihaiBogdanEugen/docker-confluent-kafka/master/Oracle_Binary_Code_License_Agreement%20for%20the%20Java%20SE%20Platform_Products_and_JavaFX>