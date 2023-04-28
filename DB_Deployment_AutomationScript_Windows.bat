@echo off
REM This script automates the following commands:
REM - Start a minikube node using Docker driver
REM - Check the minikube status
REM - Connect minikube and docker
REM - Create a deployment using a YAML file
REM - Get all the deployments
REM - Get all the pods and store the name of one pod
REM - Wait for 1 minute
REM - Get the logs of the stored pod
REM - Get the description of the stored pod

REM Start a minikube node using Docker driver
minikube start --driver=docker

REM Check the minikube status
minikube status

REM Connect minikube and docker
minikube docker-env | Invoke-Expression

REM Create a deployment using a YAML file
kubectl apply -f db-deployment.yml

REM Get all the deployments
kubectl get deployments

REM Get all the pods and store the name of one pod
kubectl get pods
set /p pod_name="Enter the name of the pod to get logs: "

REM Wait for 1 minute
timeout /t 60

REM Get the logs of the stored pod
kubectl logs %pod_name%

REM Get the description of the stored pod
kubectl describe pod %pod_name%
