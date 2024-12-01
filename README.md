# OBFUS-WG
 Wireguard obfuscation


## Server

```
sudo dnf install iptables iptables-legacy
sudo alternatives --set iptables /usr/sbin/iptables-legacy
sudo alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo reboot
```

```
sudo rm -rf OBFUS-WG/
sudo dnf install git -y
git clone https://github.com/trifoil/OBFUS-WG
cd OBFUS-WG/
sudo sh server.sh
cd ..
```

## Client


First, install docker !


```
sudo rm -rf OBFUS-WG/
sudo dnf install git -y
git clone https://github.com/trifoil/OBFUS-WG
cd OBFUS-WG/
sudo sh client.sh
cd ..
```


## High-Level Plan:

* **Shadowsocks Setup**: Shadowsocks will be used to obfuscate traffic, making it harder for people to detect the WireGuard service.
* **WireGuard Setup**: The WireGuard service (wg-easy) will run as usual, but the traffic will be proxied through Shadowsocks.
* **Nginx Proxy Manager (NPM)**: Nginx Proxy Manager will handle incoming requests and forward them to the Shadowsocks server, which in turn forwards the traffic to the WireGuard service.