export GOPATH=/k8s1.7.7 && export GOROOT=/usr/local/go && export PATH=$GOROOT/bin:$GOPATH/bin:$PATH 
pushd $GOPATH

build/run.sh make all WHAT=cmd/hyperkube GOGCFLAGS="-N -l"
cd cluster/images/hyperkube
make VERSION=0.91999 ARCH=amd64

popd
