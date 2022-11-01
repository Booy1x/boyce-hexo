### 安装MySQL
##### 1. 官方下载zip包：
```
--MySQL官方下载地址(zip方式):
https://dev.mysql.com/downloads/mysql/
--(installer方式)
https://dev.mysql.com/downloads/installer/
```
##### 2. 解压并设置环境变量
将下载的安装包(示例:`mysql-8.0.29-winx64`)解压到C盘根目录下。
添加环境变量：`电脑->右键 属性->高级系统设置->环境变量->系统变量->PATH`，在PATH里添加入mysql安装路径下的bin的路径—例如我的是： 
```
C:\Program Files (x86)\mysql-8.0.29-winx64
```
##### 3. 创建my.ini配置文件
``` bash
--在C:\Program Files (x86)\mysql-8.0.29-winx64创建my.cnf文件,内容如下：
[mysql]
default-character-set=utf8mb4
[mysqld]
--设置服务端口为3306
port=3306
--设置mysql的安装目录，注意目录需要使用\\连接
basedir=C:\\mysql-8.0.29-winx64
--设置mysql数据库的数据的存放目录，注意目录需要使用\\连接
datadir=C:\\mysql-8.0.29-winx64\\data
--允许最大连接数
max_connections=200
--允许连接失败的次数。这是为了防止有人从该主机试图攻击数据库系统
max_connect_errors=100     
character-set-server=utf8mb4
--创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
--默认使用“mysql_native_password”插件认证
default_authentication_plugin=mysql_native_password
log-bin = C:\\mysql-8.0.29-winx64\\binlog\\binlog
sync_binlog = 1
binlog_cache_size = 4M
max_binlog_cache_size = 2G
max_binlog_size = 1G
slow_query_log_file = C:\\mysql-8.0.29-winx64\\slow.log
log-error = C:\\mysql-8.0.29-winx64\\error.log

[client]
--设置mysql客户端连接服务端时默认使用的端口
port=3306
default-character-set=utf8mb4
```
##### 4. 创建data目录、安装服务及初始化
``` shell
-- 以管理员账号运行CMD，执行初始化引导：
PS C:\Users\lby> mysqld --initialize --console
...
2022-10-12T04:26:17.411693Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: ,KOtD%adf2zD

--此处会显示mysql的初始密码如上所示。
C:\Windows\System32> mysqld --install mysqld
Service successfully installed.

--启动服务：
C:\Windows\System32>net start mysqld
mysqld 服务正在启动 .
mysqld 服务已经启动成功。
```
##### 5. 修改默认密码：
```
mysql -uroot -p
--输入密码即可登录
--修改密码：
ALTER USER root@'localhost' IDENTIFIED WITH mysql_native_password BY 'YOUPASSWORD';
flush privileges;
```
##### 6. 注册多个MySQL服务
```
mysqld install mysql6 --defaults-file="mysql.ini"
```