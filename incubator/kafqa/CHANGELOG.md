# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2022-11-25

This chart version focuses on adding support for prometheus metrics to be scraped by telegraf.

### Added

- Support for adding labels to metrics instead of default `cluster_name` using `telegraf.globalTags`.
- Now we can disable prometheus default scraping which used to be permanent annotations. This can be controlled setting `prometheus.addAnnotations` to true or false.
- Prometheus and Statsd input to telegraf will be controllable by setting `telegraf.prometheusEnabled` and `telegraf.statsdEnabled` to true and false.
- Helm docs README for better understanding of chart.

### Fixes

- `opentracing.jaegerDisabled` now actually prevents jaegar container to be created.
- Correction in default `values.yml`.
