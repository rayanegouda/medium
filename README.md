# MEDIUM <br />
* STEP 1 : [Making Debezium/Connect Support Confluent SchemaRegistry]()
* Poussons le connecteur jdbc source
```
docker exec -it kconnect curl -s -XPOST -H "Content-Type: application/json; charset=UTF-8" http://localhost:8083/connectors/ -d '
{
    "name": "debezium-connecteur-postgres",
    "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "database.hostname": "db",
        "database.port": "5432",
        "database.user": "postgres",
        "database.password": "postgres",
        "database.dbname" : "postgres",
        "database.whitelist": "jdbc_connect",
        "table.include.list": "jdbc_connect.clients",
        "topic.prefix": "my_connect_debezium",
        "plugin.name": "pgoutput",
        "key.converter.schema.registry.url": "http://schema-registry:8081",
        "value.converter.schema.registry.url": "http://schema-registry:8081",
        "key.converter": "io.confluent.connect.avro.AvroConverter",
        "value.converter": "io.confluent.connect.avro.AvroConverter",
        "schema.history.internal.kafka.bootstrap.servers": "kafka-1:29092,kafka-2:29093,kafka-3:29094",
        "schema.history.internal.kafka.topic": "schema-changes.inventory"
    }
}' | jq .
```

