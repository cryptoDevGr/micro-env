#!/bin/sh
# This is a comment!

read -p "Enter registry dns: "  registry_ip

echo $registry_ip

echo -------------------Pulling base images---------------------------

read -p "Pull externall images & push them to the private repository ? (y/n) " RESP
if [ "$RESP" = "y" ]; then

    docker image pull wurstmeister/zookeeper:latest
    docker image tag wurstmeister/zookeeper:latest $registry_ip/zookeeper:latest
    docker image push $registry_ip/zookeeper:latest

    docker image pull dockersamples/visualizer
    docker image tag dockersamples/visualizer $registry_ip/visualizer:latest
    docker image push $registry_ip/visualizer:latest


    docker image pull wurstmeister/kafka:latest
    docker image tag wurstmeister/kafka:latest $registry_ip/kafka:latest
    docker image push $registry_ip/kafka:latest

    docker image pull mongo:latest
    docker image tag mongo:latest $registry_ip/mongo:latest
    docker image push $registry_ip/mongo:latest

    docker image pull mariadb:latest
    docker image tag mariadb:latest $registry_ip/mariadb:latest
    docker image push $registry_ip/mariadb:latest

    docker image pull rabbitmq:3-management
    docker image tag rabbitmq:3-management $registry_ip/rabbitmq:3-management
    docker image push $registry_ip/rabbitmq:3-management

    docker image pull docker.elastic.co/elasticsearch/elasticsearch:7.2.0
    docker image tag docker.elastic.co/elasticsearch/elasticsearch:7.2.0 $registry_ip/elasticsearch:latest
    docker image push $registry_ip/elasticsearch:latest



    docker image pull docker.elastic.co/logstash/logstash:7.2.0
    docker image tag docker.elastic.co/logstash/logstash:7.2.0 $registry_ip/logstash:latest
    docker image push $registry_ip/logstash:latest

    docker image pull docker.elastic.co/kibana/kibana:7.2.0
    docker image tag docker.elastic.co/kibana/kibana:7.2.0 $registry_ip/kibana:latest
    docker image push $registry_ip/kibana:latest

    docker image pull docker.elastic.co/beats/filebeat:7.2.0
    docker image tag docker.elastic.co/beats/filebeat:7.2.0 $registry_ip/beats:latest
    docker image push $registry_ip/beats:latest
else
    echo "Ok then proceeding with the initialization..."
fi
    
# Cloud config build
read -p "Build & Push  CLOUD-CONFIG ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    
    echo Cloud config build
    cd cloud-config-server && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/config-server:latest $registry_ip/config-server:production
    # docker push $registry_ip/config-server:production
    docker push $registry_ip/config-server:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi



read -p "Build & Push DISCOVERY-SERVICE ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    
    # Eurika Server Build
    echo Eurika Server build
    cd eureka-server && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/discovery-service:latest $registry_ip/discovery-service:production
    # docker push $registry_ip/discovery-service:production
    docker push $registry_ip/discovery-service:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi


read -p "Build & Push GRAPH-SERVICE ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    
    # Graph API Build
    echo Graph API Build
    cd graph-api && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/graph-api:latest $registry_ip/graph-api:production
    # docker push $registry_ip/graph-api:production
    docker push $registry_ip/graph-api:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi


read -p "Build & Push Hello-client ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    
    # Hello-Client API Build
    echo hello-client Build
    cd hello-client && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/graph-api:latest $registry_ip/graph-api:production
    # docker push $registry_ip/graph-api:production
    docker push $registry_ip/hello-client:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi

read -p "Build & Push Hello-service ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    
    # Hello-service API Build
    echo hello-service Build
    cd hello-service && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/graph-api:latest $registry_ip/graph-api:production
    # docker push $registry_ip/graph-api:production
    docker push $registry_ip/hello-service:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi

read -p "Build & Push session-service ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    
    # session-service API Build
    echo session-service Build
    cd session-service && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/graph-api:latest $registry_ip/graph-api:production
    # docker push $registry_ip/graph-api:production
    docker push $registry_ip/session-service:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi


read -p "Build & Push ZUUL-GATEWAY ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    # zuul-gateway 
    echo -------------------------zuul-gateway Build--------------------------
    cd zuul-gateway && mvn clean install -DskipTests
    # push the image to a local repo
    # docker tag $registry_ip/zuul-proxy:latest $registry_ip/zuul-proxy:production
    # docker push $registry_ip/zuul-proxy:production
    docker push $registry_ip/zuul-proxy:latest
    cd ..
else
    echo "Ok then proceeding with the initialization..."
fi



read -p "Build & Push Kafka-Producer ? (y/n) " RESP
if [ "$RESP" = "y" ]; then
    # kafka/producer-service
    echo -------------------------zuul-gateway Build--------------------------
    cd kafka/producer-service && mvn clean install -DskipTests
    docker push $registry_ip/producer-service:latest
    cd ../..
else
    echo "Ok then proceeding with the initialization..."
fi
