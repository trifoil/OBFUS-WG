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


shadowsocks first.

```
docker run -d \
  --name shadowsocks-client \
  --restart unless-stopped \
  -e SERVER=vpn.example.com \
  -e SERVER_PORT=1080 \  # Replace with the Shadowsocks server port
  -e PASSWORD=your_secure_password \  # Use the same password as configured on the server
  -e METHOD=aes-256-gcm \  # Use the same encryption method
  -p 1080:1080 \
  shadowsocks/shadowsocks-libev ss-local -s vpn.example.com -p 1080 -k your_secure_password -m aes-256-gcm -b 0.0.0.0 -l 1080

```

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