FROM --platform=linux/amd64 kevinity310/hadoop-nodemanager:dev
LABEL maintainer="kevinity310"

WORKDIR /

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 9083
EXPOSE 10000
EXPOSE 10002

CMD ["/run.sh"]

# docker build -t kevinity310/hive:dev .
# docker run -it --rm --name test-hive-server --env-file hadoop-port-dev.env kevinity310/hive:dev /bin/bash 