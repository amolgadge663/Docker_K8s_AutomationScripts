@echo off
echo Starting Minikube...
minikube start --driver=docker
echo.
echo Checking Minikube status...
minikube status
echo.
echo Connecting to Minikube's Docker daemon...
@FOR /f "tokens=*" %%i IN ('minikube docker-env') DO @%%i
echo.
echo Running the deployment...
kubectl apply -f db_deployment.yml
echo.
echo Checking the deployment...
kubectl get deployment
echo.
echo Checking the pods...
setlocal EnableDelayedExpansion
set pod_name=
for /f "skip=1 delims=" %%i in ('kubectl get pods') do (
    if not defined pod_name (
        set "pod_name=%%i"
        set "pod_name=!pod_name:~0,12!"
    )
)
echo The pod name is %pod_name%
echo.
echo Checking the logs...
kubectl logs %pod_name%
echo.
echo Script completed successfully.
pause
