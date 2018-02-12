FROM gcr.io/google_containers/hyperkube-amd64:0.91999
RUN cd / \
&& GIT_REMOTE=https://github.com/radhikagupta5/kubernetes \
&& GIT_BRANCH=kubernetes-mas \
&& export GOPATH=/k8s1.7.7 && export GOROOT=/usr/local/go && export PATH=$GOROOT/bin:$GOPATH/bin:$PATH \
&& apt-get -y update \
&& apt-get install -y git-core \
&& apt-get update &&  apt install -y wget && wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz && tar -xvf go1.8.3.linux-amd64.tar.gz && mv go /usr/local \
&& apt-get install -y build-essential \
&& git clone $GIT_REMOTE $GOPATH \
&& cd $GOPATH \
&& git checkout $GIT_BRANCH \
&& cd $GOPATH \
&& ln -sf  staging/src src \
&& cd $GOPATH/staging/src/k8s.io \
&& ln -sf $GOPATH kubernetes \
&& go get -u -v github.com/derekparker/delve/cmd/dlv \
&& go get -u -v github.com/ramya-rao-a/go-outline   \
&& go get -u -v github.com/acroca/go-symbols    \
&& go get -u -v github.com/nsf/gocode   \
&& go get -u -v github.com/rogpeppe/godef   \
&& go get -u -v golang.org/x/tools/cmd/godoc    \
&& go get -u -v github.com/zmb3/gogetdoc    \
&& go get -u -v github.com/golang/lint/golint \
&&  go get -u -v github.com/fatih/gomodifytags \
&& go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs \
&&  go get -u -v golang.org/x/tools/cmd/gorename \
&&  go get -u -v sourcegraph.com/sqs/goreturns \
&& go get -u -v github.com/cweill/gotests/... \
&&  go get -u -v golang.org/x/tools/cmd/guru \
&& go get -u -v github.com/josharian/impl \
&& go get -u -v github.com/haya14busa/goplay/cmd/goplay \
&& cd / \


COPY $GOPATH $GOPATH

RUN export GOPATH=/k8s1.7.7 && export GOROOT=/usr/local/go && export PATH=$GOROOT/bin:$GOPATH/bin:$PATH \
&& cd $GOPATH \
&& make all WHAT=cmd/hyperkube GOGCFLAGS="-N -l" \
&& cd $GOPATH/src/k8s.io/kubernetes/cmd/hyperkube/ \
&& go build -gcflags="-N -l" \
&& rm /hyperkube \
&& cp $GOPATH/src/k8s.io/kubernetes/cmd/hyperkube/hyperkube /


ENV GOPATH=/k8s1.7.7 GOROOT=/usr/local/go 
ENV PATH=$GOROOT/bin:$GOPATH/bin:$PATH

#ENV KUBELET_CLUSTER_DNS=10.0.0.10 KUBELET_API_SERVERS=https://10.240.255.5:443 KUBELET_IMAGE=honcao:0.3 KUBELET_NETWORK_PLUGIN=kubenet KUBELET_MAX_PODS=110 DOCKER_OPTS= KUBELET_NODE_LABELS=kubernetes.io/role=master KUBELET_POD_INFRA_CONTAINER_IMAGE=gcrio.azureedge.net/google_containers/pause-amd64:3.0  KUBELET_NODE_STATUS_UPDATE_FREQUENCY=10s KUBE_CTRL_MGR_NODE_MONITOR_GRACE_PERIOD=40s  KUBE_CTRL_MGR_POD_EVICTION_TIMEOUT=5m0s KUBE_CTRL_MGR_ROUTE_RECONCILIATION_PERIOD=10s KUBELET_IMAGE_GC_HIGH_THRESHOLD=85 KUBELET_IMAGE_GC_LOW_THRESHOLD=80 KUBELET_NON_MASQUERADE_CIDR=--non-masquerade-cidr=10.0.0.0/8 KUBELET_REGISTER_NODE=--register-node=true KUBELET_REGISTER_WITH_TAINTS=--register-with-taints=node-role.kubernetes.io/master=true:NoSchedule 
