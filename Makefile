DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t kevinity310/hadoop-base:$(current_branch) ./base
	docker build -t kevinity310/hadoop-namenode:$(current_branch) ./namenode
	docker build -t kevinity310/hadoop-datanode:$(current_branch) ./datanode
	docker build -t kevinity310/hadoop-resourcemanager:$(current_branch) ./resourcemanager
	docker build -t kevinity310/hadoop-nodemanager:$(current_branch) ./nodemanager
	docker build -t kevinity310/hadoop-historyserver:$(current_branch) ./historyserver
	# docker build -t kevinity310/hadoop-submit:$(current_branch) ./submit
	docker build -t kevinity310/jupyter-notebook:$(current_branch) ./jupyter-notebook
	docker build -t kevinity310/hive:$(current_branch) ./hive

push: 
	docker push kevinity310/hadoop-base:$(current_branch)
	docker push kevinity310/hadoop-namenode:$(current_branch)
	docker push kevinity310/hadoop-datanode:$(current_branch)
	docker push kevinity310/hadoop-resourcemanager:$(current_branch)
	docker push kevinity310/hadoop-nodemanager:$(current_branch)
	docker push kevinity310/hadoop-historyserver:$(current_branch)
	#docker push kevinity310/hadoop-submit:$(current_branch)
	docker push kevinity310/hive:$(current_branch)

wordcount:
	docker build -t hadoop-wordcount ./submit
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -mkdir -p /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -copyFromLocal -f /opt/hadoop-3.2.1/README.txt /input/
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} hadoop-wordcount
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -cat /output/*
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -rm -r /output
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} kevinity310/hadoop-base:$(current_branch) hdfs dfs -rm -r /input

