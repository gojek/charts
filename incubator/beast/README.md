# Beast Helm

### Prerequisites

The following items need to be present in the k8s cluster's namespace in which you are creating beast workers:
* Secret named `beast` with GCP BQ key
* ConfigMap for telegraf

A sample helm chart has been created in `values/values.example.yaml`

### Creating telegraf configmap

We have created a script to create the telegraf configmap.

In order to create the configmap, run the following command:

`sh telegraf-cm.sh `<kube-namespace>` `<your-influxdb-url-without-quotes>`

### Creating secret

In order to create the secret in the namespace, use the following command:

`kubectl create secret generic beast --from-file=service-account.json`

The secret will be mounted to root directory inside the pod.

NOTE:

The service account filename(here we used service-account.json), should be same as the one passed as `/root/service-account.json`  `GOOGLE_CREDENTIALS` property in the helm chart.

