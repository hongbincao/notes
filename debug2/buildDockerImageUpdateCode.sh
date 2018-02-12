sudo rm /k8s1.7.7/DockerfileUpdateCode
sudo cp ./docker/DockerfileUpdateCode /k8s1.7.7
sudo docker build -t k8sd:0.1 -f /k8s1.7.7/DockerfileUpdateCode  /k8s1.7.7
