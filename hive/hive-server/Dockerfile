FROM --platform=linux/amd64 kevinity310/hadoop-nodemanager:dev
LABEL maintainer="kevinity310"

# Install Hive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
RUN curl -O https://dist.apache.org/repos/dist/release/hive/KEYS

RUN gpg --import KEYS

ENV HIVE_VERSION 3.1.3
ENV HIVE_URL https://downloads.apache.org/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz
ENV HIVE_HOME /opt/hive-$HIVE_VERSION

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/hive.tar.gz \
    && curl -fSL "$HIVE_URL.asc" -o /tmp/hive.tar.gz.asc \
    && gpg --verify /tmp/hive.tar.gz.asc \
    && tar -xvf /tmp/hive.tar.gz -C /opt/ \
    && rm /tmp/hive.tar.gz*

RUN mv /opt/apache-hive-$HIVE_VERSION-bin ${HIVE_HOME}

RUN ln -s ${HIVE_HOME}/conf /etc/hive

RUN mkdir ${HIVE_HOME}/logs

# Set environment variables
ENV PATH $HIVE_HOME/bin:$PATH

RUN apt install nano

# Adding config for Hive
RUN touch "$HIVE_HOME/conf/hive-site.xml" && \
    echo '<?xml version="1.0" encoding="UTF-8"?>' > "$HIVE_HOME/conf/hive-site.xml" && \
    echo '<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>' >> "$HIVE_HOME/conf/hive-site.xml" && \
    echo '<configuration>' >> "$HIVE_HOME/conf/hive-site.xml" && \
    echo '</configuration>' >> "$HIVE_HOME/conf/hive-site.xml" 

WORKDIR /

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 10000

# CMD ["/run.sh"]

# docker build -t kevinity310/hive-server:dev .
# docker run -it --rm --name test-hive-server kevinity310/hive-server:dev /bin/bash