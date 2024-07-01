## This script takes in consideration that you already have an existing gcp project

# Step 1 - Creating Subnet

## Enable the necessary APIs
gcloud services enable container.googleapis.com

## Create a VPC network
gcloud compute networks subnets create mongo-subnet \
    --network default \
    --region us-central1 \
    --range 10.0.0.0/20

# Step 2 - Creating a GKE Cluster with the subnet

## Create a GKE cluster
gcloud container clusters create mongo-cluster \
    --num-nodes=3 \
    --zone us-central1-a \
    --subnetwork mongo-subnet

## Get the credentials for the cluster
gcloud container clusters get-credentials mongo-cluster --zone us-central1-a

## Apply the MongoDB StatefulSet configuration
kubectl apply -f mongodb-deployment.yaml

## Apply the MongoDB Service configuration
kubectl apply -f mongodb-service.yaml

# Step 3 - Creating and Applying Secrets

echo -n 'admin' | base64
echo -n 'yourpassword' | base64

# Step 4 - Verifying the Deployment

## Check the status of the pods and services
kubectl get pods

## Check the status of the services
kubectl get svc

# Step 7 - Access MongoDB
kubectl port-forward svc/mongo 27017:27017

