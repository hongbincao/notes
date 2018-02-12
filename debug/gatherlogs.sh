docker rm -f $(docker ps -a -q)

sleep 240

logdirdate=`date '+%Y-%m-%d-%H-%M-%S'`
logdir=~/$logdirdate
mkdir ~/$logdirdate

docker logs $(docker ps | grep "hyperkube apiserver" | cut -d' ' -f1) &> ~/$logdirdate/apiserver.log
docker logs $(docker ps | grep "hyperkube proxy" | cut -d' ' -f1) &> ~/$logdirdate/proxy.log
docker logs $(docker ps | grep "hyperkube kubelet" | cut -d' ' -f1) &> ~/$logdirdate/kubelet.log
docker logs $(docker ps | grep "hyperkube controller-manager" | cut -d' ' -f1) &> ~/$logdirdate/controller-manager.log
docker logs $(docker ps | grep "hyperkube scheduler" | cut -d' ' -f1) &> ~/$logdirdate/scheduler.log
kubectl cluster-info dump &> ~/$logdirdate/cluster-info.log


