$KAFKA_HOME/bin/zookeeper-server-start.sh -daemon /etc/opt/kafka/zookeeper.properties
exec $KAFKA_HOME/bin/kafka-server-start.sh /etc/opt/kafka/server.properties 
