# Track 4 - Kubernetes Deployment

This exercise explains the main parts of a Kubernetes `Deployment`.
It uses a small Nginx container on a local kind cluster.

## What is a Deployment?

A Deployment declares how an application should run in Kubernetes.

It does not create and manage Pods directly. Kubernetes uses this structure:

```text
Deployment
└── ReplicaSet
    └── Pod
        └── Container
```

- The Deployment manages application updates and the desired configuration.
- The ReplicaSet maintains the desired number of Pods.
- The Pod runs the application container.

Kubernetes continuously compares the desired state with the real state. If a
managed Pod is deleted, the ReplicaSet creates a replacement.

## Nginx Deployment manifest

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:alpine
```

## Top-level fields

Every Kubernetes manifest normally contains these main fields:

```yaml
apiVersion:
kind:
metadata:
spec:
```

### `apiVersion`

```yaml
apiVersion: apps/v1
```

This selects the Kubernetes API group and version used to understand the
resource. Deployments are part of the `apps/v1` API.

### `kind`

```yaml
kind: Deployment
```

This defines the type of Kubernetes object that we want to create.

### `metadata`

```yaml
metadata:
  name: nginx-deployment
  labels:
    app: nginx
```

Metadata identifies the Deployment:

- `name` is the resource name inside its namespace.
- `labels` are key-value pairs used to organize and find resources.

These labels belong to the Deployment itself. They are different from the
labels assigned to the Pods in the template.

### `spec`

The `spec` field describes the desired state of the Deployment.

## Number of replicas

```yaml
spec:
  replicas: 1
```

`replicas` is the desired number of running Pods.

If the value is `1`, Kubernetes tries to keep one Pod running. If that Pod is
deleted, Kubernetes creates another one. Changing the value to `3` makes
Kubernetes create and maintain three Pods.

Changing only `replicas` scales the existing ReplicaSet. It does not create a
new Deployment revision.

## Pod selector

```yaml
selector:
  matchLabels:
    app: nginx
```

The selector tells the Deployment which Pods it manages. Here it selects Pods
with the label `app: nginx`.

## Pod template

```yaml
template:
  metadata:
    labels:
      app: nginx
```

The template is the model used to create new Pods.

The template labels must match the Deployment selector:

```text
selector: app=nginx  →  Pod template label: app=nginx
```

If these values do not match, Kubernetes rejects the Deployment.

## Container definition

```yaml
template:
  spec:
    containers:
      - name: nginx
        image: nginx:alpine
```

- `containers` is a list because a Pod can contain more than one container.
- `name` identifies the container inside the Pod.
- `image` defines the container image to run.

In this exercise, each Pod contains one container created from the
`nginx:alpine` image.

## Validate the manifest

Client-side validation:

```bash
kubectl apply --dry-run=client -f nginx-deployment.yaml
```

Server-side validation:

```bash
kubectl apply --dry-run=server -f nginx-deployment.yaml
```

A dry run validates the manifest without saving the resource in the cluster.

## Create the Deployment

```bash
kubectl apply -f nginx-deployment.yaml
```

The file name is used with `-f`. To work with the resource after creation, use
the value from `metadata.name`:

```bash
kubectl get deployment nginx-deployment
kubectl describe deployment nginx-deployment
```

## Inspect the created resources

```bash
kubectl get deployments
kubectl get replicasets
kubectl get pods -l app=nginx
```

Wait until the Deployment is available:

```bash
kubectl rollout status deployment/nginx-deployment
```

## What we observed

- The Deployment created a ReplicaSet.
- The ReplicaSet created the Nginx Pod.
- Deleting the Pod caused the ReplicaSet to create a replacement.
- Scaling from one to three replicas did not create a new ReplicaSet.
- Returning to one replica reduced the application footprint.

The final desired state is one Nginx Pod managed by the Deployment.
