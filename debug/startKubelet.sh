sudo systemctl stop kubelet
docker stop $(docker ps -q)
docker rm -f $(docker ps -a -q)
/usr/bin/docker run --name k1 --net=host --pid=host --privileged -p 127.0.0.1:40001:40001 -itd --volume=/dev:/dev --volume=/sys:/sys:ro --volume=/var/run:/var/run:rw --volume=/var/lib/docker/:/var/lib/docker:rw --volume=/var/lib/kubelet/:/var/lib/kubelet:shared --volume=/var/log:/var/log:rw --volume=/etc/kubernetes/:/etc/kubernetes:ro --volume=/srv/kubernetes/:/srv/kubernetes:ro $DOCKER_OPTS --volume=/etc/ssl/certs:/etc/ssl/certs --volume=/var/lib/waagent/ManagedIdentity-Settings:/var/lib/waagent/ManagedIdentity-Settings:ro k8sd:0.1 /bin/sh
docker cp debugKubelet.sh k1:/root
docker exec -itd k1 /bin/sh -c "chmod 755 /root/debugKubelet.sh && /root/debugKubelet.sh"
