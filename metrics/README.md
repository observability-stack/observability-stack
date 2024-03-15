# Observability Stack -  Metrics 

## Metrics Tools: Thanos
Thanos is used within the Observability Stack for the long-term storage and centralization of Prometheus metrics data. It relies on the [Thanos Bitnami Helm Chart](https://github.com/bitnami/charts/tree/main/bitnami/thanos/).

### Quickstart
The Observability Stack recommends creating a Kubernetes secret named "thanos-objectstorage" for Thanos S3 connection details. This secret should then be mounted using the `existingObjstoreSecret` field in the Helm chart values, rather than passing the values directly to the Helm chart or as an argument.

The S3 connection YAML manifest should follow this format:

```yaml
type: S3
config:
  bucket: <thanos-object-storage-bucket-name>
  endpoint: <s3-endpoint>
  region: <region>
  aws_sdk_auth: false
  access_key: <access_key>
  insecure: false
  signature_version2: false  # Equivalent to v4auth: true
  secret_key: <secret_key>
  bucket_lookup_type: path  # Equivalent to pathstyle: true
```

More details can be found in the [Thanos documentation](https://thanos.io/tip/thanos/storage.md/#s3).

To create this secret via kubectl, use the following command, ensuring your YAML manifest is saved to a file (e.g., thanos-s3-creds.yaml):

```bash
kubectl create secret generic thanos-objectstorage --from-file=thanos-s3-creds.yaml
```

### Advanced Configuration

For an automated setup, the secret should be integrated into the `base` directory alongside the Thanos and Prometheus metrics components. A corresponding `kustomization.yaml` file ensures automatic creation of the secret. This setup supports both regular Kubernetes secrets (without encryption) and more secure approaches like integrating with [HashiCorp Vault](https://www.vaultproject.io/), utilizing the [external-secrets-operator](https://external-secrets.io/latest/) to import the secret as an ExternalSecret object.

## Metrics Tools: Prometheus Operator
To be complated

## Metrics Tools: Grafana
To be complated

