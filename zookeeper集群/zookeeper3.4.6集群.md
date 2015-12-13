ZooKeeper安装配置
下载：

wget http://archive.apache.org/dist/zookeeper/stable/zookeeper-3.4.6.tar.gz
解压与软链接：

tar -zxvf zookeeper-3.4.6.tar.gz -C /opt
ln -s /opt/zookeeper-3.4.6 /opt/zookeeper
chown -R zookeeper:hadoop /opt/zookeeper*
复制配置文件

cp /opt/zookeeper/zoo_sample.cfg /opt/zookeeper/zoo.cfg
修改配置

vi /opt/zookeeper/zoo.cfg

dataDir=/opt/zookeeper/data
dataLogDir=/opt/zookeeper/logs
clientPort=2181
tickTime=2000
initLimit=5
syncLimit=2
server.1=HDP245:2888:3888
server.2=HDP246:2888:3888
server.3=HDP247:2888:3888
在dataDir目录下创建myid文件，HDP245机器的内容为1，HDP246机器的内容为2，HDP247机器的内容为3，若有更多依此类推。

在HDP245的修改为： mkdir -p /opt/zookeeper/data/ echo 1 > /opt/zookeeper/data/myid

在HDP246、HDP247上把“echo 1”的“1”改成对应的值。

注：

　　dataDir：数据目录

　　dataLogDir：日志目录

　　clientPort：客户端连接端口

　　tickTime：Zookeeper 服务器之间或客户端与服务器之间维持心跳的时间间隔，也就是每个 tickTime 时间就会发送一个心跳。

　　initLimit：Zookeeper的Leader 接受客户端（Follower）初始化连接时最长能忍受多少个心跳时间间隔数。当已经超过 5个心跳的时间（也就是tickTime）长度后 Zookeeper 服务器还没有收到客户端的返回信息，那么表明这个客户端连接失败。总的时间长度就是 5*2000=10 秒

　　syncLimit：表示 Leader 与 Follower 之间发送消息时请求和应答时间长度，最长不能超过多少个tickTime 的时间长度，总的时间长度就是 2*2000=4 秒。

　　server.A=B：C：D：其中A 是一个数字，表示这个是第几号服务器；B 是这个服务器的 ip 地址；C 表示的是这个服务器与集群中的 Leader 服务器交换信息的端口；D 表示的是万一集群中的 Leader 服务器挂了，需要一个端口来重新进行选举，选出一个新的 Leader，而这个端口就是用来执行选举时服务器相互通信的端口。如果是伪集群的配置方式，由于 B 都是一样，所以不同的 Zookeeper 实例通信端口号不能一样，所以要给它们分配不同的端口号。

启动与停止

启动：

/opt/zookeeper/bin/zkServer.sh start
停止：

/opt/zookeeper/bin/zkServer.sh stop
查看ZooKeeper树