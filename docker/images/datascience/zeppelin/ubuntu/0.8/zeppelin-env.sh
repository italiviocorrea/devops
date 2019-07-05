#export MASTER=spark://master:7077

export SPARK_HOME=/usr/spark-2.4.3

# set hadoop conf dir
#export HADOOP_CONF_DIR=/usr/hadoop-2.8.3

# set options to pass spark-submit command
#export SPARK_SUBMIT_OPTIONS="--packages com.databricks:spark-csv_2.10:1.2.0"

# extra classpath. e.g. set classpath for hive-site.xml
export ZEPPELIN_INTP_CLASSPATH_OVERRIDES=/etc/hive/conf
