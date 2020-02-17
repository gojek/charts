# Beast Helm

### Prerequisites

The following items need to be present in the k8s cluster's namespace in which you are creating beast deployment:
* Secret named `beast` with GCP BQ key
* ConfigMap for telegraf

A sample helm chart with all beast configuration parameters has been created in `values/values.example.yaml`

### Creating telegraf configmap

- Before creating the config map, you may choose to set appropriate values for the beast configuration. Create a file `values.yaml` in this directory and set the values for respective configuration (see `values/values.example.yaml`).
- `tag: <beast-docker-image-tag>` contains the docker image tag of beast. You may choose to update this tag to get the latest beast software tag. 

Telegraf config map needs to be created. The command below generates the config map in the k8s namespace.

`sh telegraf-cm.sh <kube-namespace> <your-influxdb-url-without-quotes>`

The script above updates the `telegraf.configmap.yaml` with the influxURL supplied above and generates the configmap.

### Creating secret

Create the secret in the namespace, using the following command:

`kubectl create secret generic beast --from-file=service-account.json`

NOTE:

The service account filename (here we used service-account.json), should be same as the one configured for `GOOGLE_CREDENTIALS` property in `values.yaml` in the helm chart. k8s will mount this file under `/root/`. The property `googleCredentials: "/root/service-account.json"` can be set in the `values.yaml`

The secret will be mounted to root directory inside the pod.

### Deploy Beast

Beast can be deployed on k8s using helm. The command below is a *reference* to deploy beast.

`helm install <beast-deployment-name> .`
