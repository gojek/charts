# kafqa

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

A quality analyser, measuring data loss, ops, latency

**Homepage:** <https://github.com/gojek/kafqa/>

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install gojektech-incubator/kafqa --name my-release --values=values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| acks | string | `"1"` | Specifies ack needed for producer |
| affinity | object | `{}` |  |
| appDurationMs | string | `"5000000000"` | Specifies how long producer should produce message for if producer.totalMessages is not -1 |
| appPort | int | `8081` | Port on which application will run |
| configmap | string | `"kafqa-proto"` | Which configmap to use for proto |
| consumer.concurrency | int | `1` | Simultaneous consumers to run |
| consumer.enableAutoCommit | bool | `true` | Enable or disable auto commit |
| consumer.enabled | bool | `true` | Boolean value to enable or disable consumer |
| consumer.groupId | string | `"consumer-test-001"` | Consumer group id to use |
| consumer.kafkaBrokers | string | `"localhost:9092"` | Kafka host for consumer. Format host:port,host2:port |
| consumer.pollTimeoutMs | int | `300` | Timeout for polling in consumer |
| environment | string | `"production"` | Use "development" to get debug logs. This sets the env in Kafqa container |
| fullnameOverride | string | `""` |  |
| image | object | `{"command":"[\"kafqa\"]","pullPolicy":"IfNotPresent","repository":"gojektech/kafqa","tag":"latest"}` | Kafqa docker image details |
| kafka | object | `{"cluster":"test","topic":"kafqa-test-topic"}` | Details of Kafka broker and topic to use |
| kafka.cluster | string | `"test"` | Cluster name for Kafka broker |
| kafka.topic | string | `"kafqa-test-topic"` | Topic in Kafka to use |
| librd | object | `{"batchSize":10000,"enabled":false,"queueMaxSize":10000,"queuedMinMessages":30000,"statsIntervalMs":500}` | Configuration for Librd |
| nameOverride | string | `""` |  |
| namespace | string | `"hermes"` |  |
| nodeSelector | object | `{}` |  |
| opentracing | object | `{"collectorHost":"localhost","collectorPort":80,"jaegerDisabled":false,"jaegerReportLogSpans":true}` | Agent is sidecar, and it pushes data collector which could be remote |
| producer.concurrency | int | `1` | Number of producers to run simultaneously |
| producer.enabled | bool | `true` | Boolean value to enable or disable producer |
| producer.kafkaBrokers | string | `"localhost:9092"` | Kafka host for producer. Format host:port,host2:port |
| producer.totalMessages | int | `-1` | Number of messages to produce |
| producer.workerDelayMs | int | `50` | Delay between messages produced in milliseconds |
| prometheus | object | `{"addAnnotations":true,"enabled":true,"port":9090,"token":"test","url":"https://localhost:8080/v1/prom/metrics"}` | Prometheus configurations |
| prometheus.addAnnotations | bool | `true` | Flag for adding annotations to be scraped by prometheus operator |
| prometheus.enabled | bool | `true` | Enable or disable generation of prometheus specific metrics |
| prometheus.port | int | `9090` | URL port on which prometheus metrics are available |
| prometheus.token | string | `"test"` | Remote write token for prometheus for telegraf  |
| prometheus.url | string | `"https://localhost:8080/v1/prom/metrics"` | Remote write url for prometheus for telegraf  |
| replicaCount | int | `1` |  |
| resources | object | `{"kafqa":{"limits":{"cpu":"512m","memory":"512Mi"},"requests":{"cpu":"100m","memory":"128Mi"}},"telegraf":{"limits":{"cpu":"100m","memory":"128Mi"},"requests":{"cpu":"50m","memory":"50Mi"}}}` | Resources to specify for Kafqa or telegraf |
| stats | object | `{"enabled":true,"host":"localhost","port":8125}` | Statsd configurations |
| telegraf | object | `{"image":{"repository":"telegraf","tag":"latest"},"labels":{"cluster_name":"production"},"prometheusEnabled":true,"statsdEnabled":true}` | Telegraf configuration |
| telegraf.image | object | `{"repository":"telegraf","tag":"latest"}` | Specify which telegraf image to use |
| telegraf.labels | object | `{"cluster_name":"production"}` | Specify which labels to add to metrics |
| telegraf.prometheusEnabled | bool | `true` | Specify if input for prometheus should be added or not |
| telegraf.statsdEnabled | bool | `true` | Specify if input for statsd should be added or not |
| tolerations | list | `[]` |  |
