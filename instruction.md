# Introduction  

*Apache Kafka* service is installed inside the *docker* container, using the version *oracle java 8*  

## Installation paths  

`/opt/kafka` - the installation path *kafka*  
`/etc/opt/kafka` - the path of the configuration files *kafka* and *zookeeper*  
`/etc/init.d/kafka` - the control script *kafka*  
`/etc/init.d/zookeeper` - the control script *zookeeper*  
`/var/log/kafka` - the path of the logs *kafka*  

# Update  

What to update *kafka* or *java*, you need to make changes in *Dockerfile* and the relevant variables, make changes to the configuration files.  

`KAFKA_VER` = 0.10.2.0  
`SCALA_VER` = 2.12  

`JAVA_VER` = 1.8.0_121  
`JAVA_DWL_VER` = 8u121  
`JAVA_DWL_BVER` = b13  

# Use  

## Launching the container  

`docker run -p 2181:2181 -p 9092:9092 -v /tmp/kafka:/var/log/kafka -d -t test/kafka`  

On the host machine, you must specify where the *kafka* logs will be stored. And also the ports for *kafka* (9092) and *zookeeper* (2181). All necessary services start automatically after the container is started.  

## Managing the zookeeper inside the container  
`/etc/init.d/zookeeper { start | stop | restart }`  

## Managing the kafka inside the container  
`/etc/init.d/kafka { start | stop | restart }`  
