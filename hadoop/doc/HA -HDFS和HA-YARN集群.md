# HA-HDFS HA-YARN集群

标签（空格分隔）： hadoop 大数据

---

## 规划
|IP             |主机名         | 角色          |  
| ------------- |:-------------:| -------------:|
|192.168.0.120  |name           |名称节点       |    
|192.168.0.121  |name1          |名称节点(备)   |
|192.168.0.126  |data1          |数据节点1      | 
|192.168.0.127  |data2          |数据节点2      |
|192.168.0.128  |data3          |数据节点3      |

## 配置
### slaves文件
```
dn01
dn02
dn03
```
### core-site.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://cluster1</value>
    </property>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/opt/data/hadoop/tmp</value>
    </property>
    <property>
        <name>ha.zookeeper.quorum</name>
        <value>zk01:2181,zk02:2181,zk03:2181</value>
    </property>
    <property>
        <name>fs.trash.interval</name>
        <value>1440</value>
        <!-- 清掉垃圾筒的时间,1440分钟 -->
    </property>
    <property>
        <name>hadoop.proxyuser.hduser.hosts</name>
        <value>*</value>
        <!--指定可以在任何IP访问-->
    </property>
    <property>
        <name>hadoop.proxyuser.hduser.groups</name>
        <value>*</value>
        <!--指定所有用户可以访问-->
    </property>
</configuration>
```
### hdfs-site.xml
```
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>3</value>
        <!--指定DataNode存储block的副本数量。默认值是3个，我们现在有4个DataNode，该值不大于4即可。-->
    </property>
    <property>
        <name>dfs.nameservices</name>
        <value>cluster1</value>
        <!--使用federation时，使用了2个HDFS集群。这里抽象出两个NameService实际上就是给这2个HDFS集群起了个别名。名字可以随便起，相互不重复即可-->
    </property>
    <property>
        <name>dfs.ha.namenodes.cluster1</name>
        <value>nn01,nn02</value>
        <!--指定NameService是cluster1时的namenode有哪些，这里的值也是逻辑名称，名字随便起，相互不重复即可-->
    </property>
    <property>
        <name>dfs.namenode.rpc-address.cluster1.nn01</name>
        <value>nn01:9000</value>
        <!--指定nn01的RPC地址-->
    </property>
    <property>
        <name>dfs.namenode.http-address.cluster1.nn01</name>
        <value>nn01:50070</value>
        <!--指定nn01的http地址-->
    </property>
    <property>
        <name>dfs.namenode.rpc-address.cluster1.nn02</name>
        <value>nn02:9000</value>
        <!--指定nn02的RPC地址-->
    </property>
    <property>
        <name>dfs.namenode.http-address.cluster1.nn02</name>
        <value>nn02:50070</value>
        <!--指定nn02的http地址-->
    </property>
    <property>
        <name>dfs.namenode.shared.edits.dir</name>
        <value>qjournal://dn01:8485;dn02:8485;dn03:8485/cluster1</value>
        <!--指定cluster1的两个NameNode共享edits文件目录时，使用的JournalNode集群信息-->
    </property>
    <property>
        <name>dfs.ha.automatic-failover.enabled.cluster1</name>
        <value>true</value>
        <!--指定cluster1是否启动自动故障恢复，即当NameNode出故障时，是否自动切换到另一台NameNode-->
    </property>
    <property>
        <name>dfs.client.failover.proxy.provider.cluster1</name>
        <value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
         <!--指定cluster1出故障时，哪个实现类负责执行故障切换-->
    </property>
    <property>
        <name>dfs.journalnode.edits.dir</name>
        <value>/opt/data/hadoop/journal</value>
        <!--指定JournalNode集群在对NameNode的目录进行共享时，自己存储数据的磁盘路径-->
    </property>
    <property>
        <name>dfs.ha.fencing.methods</name>
        <value>sshfence</value>
        <!--一旦需要NameNode切换，使用ssh方式进行操作-->
    </property>
    <property>
        <name>dfs.ha.fencing.ssh.private-key-files</name>
        <value>/home/zhaosg/.ssh/id_rsa</value>
        <!--如果使用ssh进行故障切换，使用ssh通信时用的密钥存储的位置-->
    </property>
</configuration>
```



