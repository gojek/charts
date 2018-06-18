# PostgreSQL Cluster

[PostgreSQL](https://www.postgresql.org/) is an advanced object-relational database management system
that supports an extended subset of the SQL standard, including
transactions, foreign keys, subqueries, triggers, user-defined types
and functions.  This distribution also contains C language bindings.

## Introduction

This chart bootstraps a highly available PostgreSQL cluster using [Stolon](https://github.com/sorintlab/stolon/) on [Kubernetes](https://github.com/kubernetes/kubernetes) using [Helm](https://github.com/kubernetes/helm).


## Prerequisites

- Kubernetes 1.8+
- helm
- [etcd-operator](https://github.com/coreos/etcd-operator) v0.6.1+


## Installation

```sh
$ helm repo add gojek http://leap.pages.golabs.io/helm-charts/
$ helm install stable/etcd-operator --set image.tag=v0.6.1 ## If already not running
$ helm install gojek/postgres-cluster --name my-release
```

## Uninstallation

```sh
$ helm delete my-release --purge
```

## Configuration

|Parameter        | Description | Default|
|-----------|----------|---------|
|stolon.image.tag | Stolon image|master-pg9.4|
|stolon.proxy.replicas|Stolon Proxy Replica count|3|
|stolon.proxy.expose|Expose the proxy using a internal load balancer|false|
|stolon.proxy.debug|Run Stolon Proxy in Debug mode|false|
|stolon.sentinel.replicas|Stolon Sentinel Replica count|3|
|stolon.sentinel.debug|Run Stolon Sentinel in Debug mode|false|
|stolon.keeper.replicas|Stolon Keeper Replica count|3|
|stolon.keeper.debug|Run Stolon Keeper in Debug mode|false|
|stolon.clusterSpecification|Refer [Cluster Specification](https://github.com/sorintlab/stolon/blob/master/doc/cluster_spec.md)|nil|
|stolon.keeper.pvcName|Required when stolon.clusterSpecification.initMode=existing|nil|
|store.name|etcd cluster name|config-store|
|store.size|etcd cluster size|3|
|store.version|etcd version|3.2.9|
|postgres.replication.username|Postgres user for replication|repluser|
|postgres.application.username|Postgres user for clients to connect|stolon|
|postgres.application.dbname|Database name to be created|stolon|

You can override the above values using two ways:

- Command line args

```sh
$ helm install . \
		--name my-release \
		--set postgres.application.username=myuser
```

- Configuration files

```sh
$ helm install . \
		--name my-release \
		-f override-values.yaml
		
$ cat override-values.yaml
postgres:
	application:
		username: myuser
```

## Initialize stolon with existing data

Create PV and PVC from Google Persistent Disk containing PG data.

Existing DB:

- username: test
- dbname: test
- password: test
- replication username: repluser
- replication password: repluser

```
helm install gojek/postgres-cluster --name my-release --set store.endpoint=store-endpoint,postgres.application.username=test,postgres.application.password=test,postgres.application.dbname=test,postgres.replication.username=repluser,postgres.replication.password=repluser,stolon.clusterSpecification.initMode=existing,stolon.keeper.pvcName=pvc-containing-data
```