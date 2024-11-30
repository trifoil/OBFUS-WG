# OBFUS-WG
 Wireguard obfuscation


## Server

```
sudo dnf install iptables iptables-legacy -y
sudo alternatives --set iptables /usr/sbin/iptables-legacy
sudo rm -rf OBFUS-WG/
sudo dnf install git -y
git clone https://github.com/trifoil/OBFUS-WG
cd OBFUS-WG/
sudo sh server.sh
cd ..
```

## Client


```
sudo rm -rf OBFUS-WG/
sudo dnf install git -y
git clone https://github.com/trifoil/OBFUS-WG
cd OBFUS-WG/
sudo sh client.sh
cd ..
```