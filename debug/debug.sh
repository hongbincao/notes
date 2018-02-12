LOCALUSER="azureuser"

GIT_REMOTE=https://github.com/radhikagupta5/kubernetes
GIT_BRANCH=kubernetes-mas
export GOPATH=/k8s1.7.7
export GOROOT=/usr/local/go 
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH
apt-get update
apt install -y git-core
apt-get update
apt install -y wget
wget https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz
tar -xvf go1.8.3.linux-amd64.tar.gz
mv go /usr/local
apt-get install -y build-essential
git clone $GIT_REMOTE $GOPATH
cd $GOPATH
git checkout $GIT_BRANCH
cd $GOPATH
ln -sf  staging/src src
cd $GOPATH/staging/src/k8s.io
ln -sf $GOPATH kubernetes
go get -u -v github.com/derekparker/delve/cmd/dlv
go get -u -v github.com/ramya-rao-a/go-outline  
go get -u -v github.com/acroca/go-symbols   
go get -u -v github.com/nsf/gocode  
go get -u -v github.com/rogpeppe/godef  
go get -u -v golang.org/x/tools/cmd/godoc   
go get -u -v github.com/zmb3/gogetdoc   
go get -u -v github.com/golang/lint/golint
go get -u -v github.com/fatih/gomodifytags
go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs
go get -u -v golang.org/x/tools/cmd/gorename
go get -u -v sourcegraph.com/sqs/goreturns
go get -u -v github.com/cweill/gotests/...
go get -u -v golang.org/x/tools/cmd/guru
go get -u -v github.com/josharian/impl
go get -u -v github.com/haya14busa/goplay/cmd/goplay

cd /
GIT_REMOTE=https://github.com/radhikagupta5/kubernetes
GIT_BRANCH=kubernetes-mas
cd $GOPATH
make all WHAT=cmd/hyperkube GOGCFLAGS="-N -l"
cd $GOPATH/src/k8s.io/kubernetes/cmd/hyperkube/
go build -gcflags="-N -l"

# install UI and xrdp
sudo apt-get install -y xrdp
sudo apt-get install -y mate-core mate-desktop-environment mate-notification-daemon
sudo sed -i.bak '/fi/a #xrdp multiple users configurationn mate-sessionn' /etc/xrdp/startwm.sh

# change the ownership of code.
sudo chown -R $LOCALUSER $GOPATH

# install VS code and go extension
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code
sudo -H -u $LOCALUSER bash -c "code --install-extension lukehoban.Go"

# fix isseu: vs code can not start in xrdp session.
sudo sed -i 's/BIG-REQUESTS/_IG-REQUESTS/' /usr/lib/x86_64-linux-gnu/libxcb.so.1
