# Cluster VirtualBox Centos 7 fixed IP

The purpose of this document is to show how to create virtual machines in VirtualBox with fixed IP, that is, without dynamic IP allocation every time the VM is started or restarted.
I usually create multiple VMs to test Hadoop clusters, swarm docker, kubernetes, mesos, kafka, Apache Nifi, Apache spark, etc. An important requirement is that machines in this cluster have fixed IP. To illustrate how to do this, I will create a cluster for Hadoop with two machines for the namenode (HA cluster) and three machines for the datanodes.
In this case, I'll do this case study using Linux Centos 7. 


