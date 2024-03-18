# Observability Stack -  Logs

## Logs Tools: Fluentd
The Observability Stack uses Fluentd for log shipping for both `observee` and `observer` clusters to the centralized Opensearch cluster. It relies on the [rancher-logging-operator](https://github.com/rancher/charts/tree/dev-v2.9/charts/rancher-logging/103.0.0%2Bup3.17.10) Helm Chart, which is derived from the [kube-logging/logging-operator](https://github.com/kube-logging/logging-operator) helm chart, for deployment.


### Logging Pipelines (Flows and Outputs)
To be completed.

## Logs Tools: Opensearch
To be completed.