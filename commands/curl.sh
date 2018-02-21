
# Download remote file
curl -O REMOTE_URL

# skip certificate validation
curl -k REMOTE_URL



journalctl -xeu kubelet
systemctl status kubelet