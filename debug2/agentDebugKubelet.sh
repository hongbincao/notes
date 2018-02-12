

KUBELET_CLUSTER_DNS=10.0.0.10 && KUBELET_API_SERVERS=https://10.240.255.5:443 && KUBELET_IMAGE=k8sd:0.1 && KUBELET_NETWORK_PLUGIN=kubenet && KUBELET_MAX_PODS=110 && DOCKER_OPTS= && CUSTOM_CMD=/bin/true && KUBELET_REGISTER_SCHEDULABLE=true && KUBELET_NODE_LABELS=kubernetes.io/role=agent,agentpool=agentpool1 && KUBELET_POD_INFRA_CONTAINER_IMAGE=gcrio.azureedge.net/google_containers/pause-amd64:3.0 && KUBELET_NODE_STATUS_UPDATE_FREQUENCY=10s && KUBE_CTRL_MGR_NODE_MONITOR_GRACE_PERIOD=40s && KUBE_CTRL_MGR_POD_EVICTION_TIMEOUT=5m0s && KUBE_CTRL_MGR_ROUTE_RECONCILIATION_PERIOD=10s && KUBELET_IMAGE_GC_HIGH_THRESHOLD=85 && KUBELET_IMAGE_GC_LOW_THRESHOLD=80 && KUBELET_NON_MASQUERADE_CIDR=--non-masquerade-cidr=10.0.0.0/8 && KUBELET_FEATURE_GATES=--feature-gates=Accelerators=true

dlv exec --headless -l 172.17.0.1:40001 /hyperkube kubelet \
        --kubeconfig=/var/lib/kubelet/kubeconfig \
        --require-kubeconfig \
        --pod-infra-container-image="${KUBELET_POD_INFRA_CONTAINER_IMAGE}" \
        --address=0.0.0.0 \
        --allow-privileged=true \
        ${KUBELET_FIX_43704_1} \
        ${KUBELET_FIX_43704_2}${KUBELET_FIX_43704_3} \
        --enable-server \
        --pod-manifest-path=/etc/kubernetes/manifests \
        --cluster-dns=${KUBELET_CLUSTER_DNS} \
        --cluster-domain=cluster.local \
        --node-labels="${KUBELET_NODE_LABELS}" \
        --cloud-provider=azure \
        --cloud-config=/etc/kubernetes/azure.json \
        --azure-container-registry-config=/etc/kubernetes/azure.json \
        --network-plugin=${KUBELET_NETWORK_PLUGIN} \
        --max-pods=${KUBELET_MAX_PODS} \
        --node-status-update-frequency=${KUBELET_NODE_STATUS_UPDATE_FREQUENCY} \
        --image-gc-high-threshold=${KUBELET_IMAGE_GC_HIGH_THRESHOLD} \
        --image-gc-low-threshold=${KUBELET_IMAGE_GC_LOW_THRESHOLD} \
        --v=6 ${KUBELET_FEATURE_GATES} \
        ${KUBELET_NON_MASQUERADE_CIDR} \
        ${KUBELET_REGISTER_NODE} ${KUBELET_REGISTER_WITH_TAINTS}  > /root/log.txt

