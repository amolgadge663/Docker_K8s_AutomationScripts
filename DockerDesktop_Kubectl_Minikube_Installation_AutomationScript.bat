@echo off
setlocal enabledelayedexpansion

set DOCKER_URL=https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
set KUBECTL_URL=https://dl.k8s.io/release/v1.27.0/bin/windows/amd64/kubectl.exe
set MINIKUBE_URL=https://storage.googleapis.com/minikube/releases/latest/minikube-installer.exe

echo Downloading Docker Desktop...
powershell -Command "& {Invoke-WebRequest '%DOCKER_URL%' -OutFile 'DockerDesktopInstaller.exe'}"

echo Installing Docker Desktop...
start /wait DockerDesktopInstaller.exe

echo Downloading Kubectl...
powershell -Command "& {Invoke-WebRequest '%KUBECTL_URL%' -OutFile 'kubectl.exe'}"

echo Setting Kubectl in PATH...
set PATH=%CD%;%PATH%
set KUBECONFIG=%CD%\config
setx /M PATH "%PATH%"
setx /M KUBECONFIG "%KUBECONFIG%"

echo Downloading Minikube...
powershell -Command "& {Invoke-WebRequest '%MINIKUBE_URL%' -OutFile 'minikube-installer.exe'}"

echo Installing Minikube...
start /wait minikube-installer.exe

echo Checking versions...
docker --version
minikube version
kubectl version --client

echo Done.
pause
