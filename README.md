# GO-JEK Helm Charts

This is a GO-JEK helm charts repository. This has helms that we are using at GO-JEK. The charts will be in incubator until deemed stable.

## How do I enable the GO-JEK Incubator repository?

To add the GO-JEK Incubator charts for your local client, run `helm repo add`:

```
$ helm repo add gojektech-incubator https://gojek.github.io/charts/incubator/
"gojektech-incubator" has been added to your repositories
```

You can then run `helm search gojektech-incubator` to see the charts.

## How do I install these charts?

Just `helm install gojektech-incubator/<chart>`. 

For more information on using Helm, refer to the [Helm's documentation](https://github.com/kubernetes/helm#docs).

gojek-tech
## Chart Format

Take a look at the [alpine example chart](https://github.com/kubernetes/helm/tree/master/docs/examples/alpine) and the [nginx example chart](https://github.com/kubernetes/helm/tree/master/docs/examples/nginx) for reference when you're writing your first few charts.

Before contributing a Chart, become familiar with the format. Note that the project is still under active development and the format may still evolve a bit.


## Contributing a Chart

We'd love for you to contribute a Chart that provides a useful application or service for Kubernetes. Please read our [Contribution Guide](CONTRIBUTING.md) for more information on how you can contribute Charts.
