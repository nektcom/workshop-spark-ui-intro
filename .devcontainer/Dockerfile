# Use slim Python image based on Debian Bookworm (stable)
FROM python:3.9-slim-bookworm

# Install Java and utilities
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openjdk-17-jdk-headless \
        procps \
        curl \
        wget \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Java
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Download and install Spark (full distribution for standalone cluster)
ENV SPARK_VERSION=3.5.0
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark

RUN wget -q https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Add Spark to PATH
ENV PATH=$SPARK_HOME/bin:$SPARK_HOME/sbin:$PATH
ENV PYSPARK_PYTHON=python3

# Install Python packages
RUN pip install --no-cache-dir pyspark==${SPARK_VERSION} jupyter jupyterlab

# Create startup script for Spark cluster
COPY start-spark.sh /usr/local/bin/start-spark.sh
RUN chmod +x /usr/local/bin/start-spark.sh

# Expose ports:
# 4040 - Spark Application UI
# 7077 - Spark Master
# 8080 - Spark Master Web UI
# 8081 - Spark Worker Web UI
# 8888 - Jupyter
EXPOSE 4040 7077 8080 8081 8888

# Set the working directory
WORKDIR /workspace
