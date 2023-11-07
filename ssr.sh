#! /bin/bash
# set up SSR on centos 8 
# goodyoutubers.com

dnf install git python3 nano wget firewalld nginx -y
cd /usr/local
git clone -b manyuser https://github.com/shadowsocksrr/shadowsocksr.git
cd /usr/local/shadowsocksr
bash initcfg.sh
> /usr/local/shadowsocksr/user-config.json
cat <<EOT >> /usr/local/shadowsocksr/user-config.json
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": 6538,
    "local_address": "127.0.0.1",
    "local_port": 1080,

    "password": "Zo1dyck\$\$\$",
    "method": "none",
    "protocol": "auth_chain_a",
    "protocol_param": "",
    "obfs": "plain",
    "obfs_param": "",
    "speed_limit_per_con": 0,
    "speed_limit_per_user": 0,

    "additional_ports" : {}, // only works under multi-user mode
    "additional_ports_only" : false, // only works under multi-user mode
    "timeout": 120,
    "udp_timeout": 60,
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": false
}
EOT
cat <<EOT >> /etc/systemd/system/shadowsocksr.service
[Unit]
Description=ShadowsocksR server
After=network.target
Wants=network.target

[Service]
Type=forking
PIDFile=/var/run/shadowsocksr.pid
ExecStart=/usr/bin/python3 /usr/local/shadowsocksr/shadowsocks/server.py --pid-file /var/run/shadowsocksr.pid -c /usr/local/shadowsocksr/user-config.json -d start
ExecStop=/usr/bin/python3 /usr/local/shadowsocksr/shadowsocks/server.py --pid-file /var/run/shadowsocksr.pid -c /usr/local/shadowsocksr/user-config.json -d stop
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=always

[Install]
WantedBy=multi-user.target
EOT
systemctl enable shadowsocksr
systemctl start shadowsocksr
systemctl enable nginx
systemctl start nginx
systemctl enable firewalld.service
systemctl start firewalld.service
firewall-cmd --permanent --add-port=6538/tcp
firewall-cmd --permanent --add-port=6538/udp
firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --reload
wget https://github.com/shadowsocksrr/shadowsocksr-csharp/releases/download/4.9.2/ShadowsocksR-win-4.9.2.zip
wget https://github.com/xcxnig/ssr-download/raw/master/ssrr-android.apk
wget https://raw.githubusercontent.com/xcxnig/ssr-download/master/ssr-mac.dmg
cp ShadowsocksR-win-4.9.2.zip /usr/share/nginx/html/1.zip
cp ssrr-android.apk /usr/share/nginx/html/2.apk
cp ssr-mac.dmg /usr/share/nginx/html/3.dmg
echo '安装完毕'