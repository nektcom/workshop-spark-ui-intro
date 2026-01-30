#!/bin/bash
# Start Spark Standalone cluster (master + worker)

# Bind to all interfaces so services are accessible from outside container
export SPARK_MASTER_HOST=0.0.0.0
export SPARK_LOCAL_IP=127.0.0.1

echo "Starting Spark Master..."
$SPARK_HOME/sbin/start-master.sh -h 0.0.0.0

# Wait for master to start
sleep 5

echo "Starting Spark Worker..."
$SPARK_HOME/sbin/start-worker.sh spark://127.0.0.1:7077 \
    --host 0.0.0.0 \
    --cores 32 \
    --memory 4g

echo ""
echo "=========================================="
echo "Spark Standalone Cluster is running!"
echo "=========================================="
echo ""
echo "Master UI:  http://localhost:8080"
echo "Worker UI:  http://localhost:8081"
echo "App UI:     http://localhost:4040 (after running a Spark app)"
echo ""
echo "Connect with:"
echo '  spark = SparkSession.builder \\'
echo '      .appName("MyApp") \\'
echo '      .master("spark://localhost:7077") \\'
echo '      .getOrCreate()'
echo ""
