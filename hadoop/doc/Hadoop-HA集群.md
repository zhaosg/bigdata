# HA-HDFS HA-YARN集群

标签（空格分隔）： hadoop 大数据

---
## 目标

 1. 实现高可用的HDFS集群，无单点故障
 2. 实现高可用的YARN，无单点故障
 3. namenode可横向扩展

## 架构

 1. 背景
 ![描述][2]
 2. federation结构图
 ![描述][1]

## 硬件规划
|IP             |主机名         | 角色          |
| ------------- |:-------------:| -------------:|
|192.168.0.120  |nn01           |名称节点       |
|192.168.0.121  |nn02           |名称节点       |
|192.168.0.126  |dn01           |数据节点1      |
|192.168.0.127  |dn02           |数据节点2      |
|192.168.0.128  |dn03           |数据节点3      |

## 配置
配置文件在github上
https://github.com/zhaosg/bigdata/tree/master/hadoop/etc/hadoop

## 脚本
略

## 验证
略

## 参考
http://hadoop.apache.org/docs/r2.6.4/hadoop-project-dist/hadoop-hdfs/HDFSHighAvailabilityWithQJM.html
http://hadoop.apache.org/docs/r2.6.4/hadoop-project-dist/hadoop-hdfs/Federation.html

  [1]: http://hadoop.apache.org/docs/r2.6.4/hadoop-project-dist/hadoop-hdfs/images/federation.gif
  [2]: http://hadoop.apache.org/docs/r2.6.4/hadoop-project-dist/hadoop-hdfs/images/federation-background.gif