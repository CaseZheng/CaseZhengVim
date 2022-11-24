#!/bin/sh

cat << _TMUX_



##########################################tmux操作##########################################
常用会话操作
  $ 重命名当前会话
  s 选择会话列表
  d detach当前会话，运行后将会退出tmux进程，返回至shell主进程

常用窗格操作
  x 关闭当前窗格
  o 选择下一个窗格，也可以使用上下左右方向键来选择
  z 最大化当前窗格，再次执行可恢复原来大小
  q 显示所有窗格的序号，在序号出现期间按下对应的数字，即可跳转至对应的窗格

常用窗口操作
  c 新建窗口，此时当前窗口会切换至新窗口，不影响原有窗口的状态
  p 切换至上一窗口
  n 切换至下一窗口
  w 窗口列表选择
  & 关闭当前窗口
  , 重命名窗口，可以使用中文，重命名后能在tmux状态栏更快速的识别窗口id
  0 切换至0号窗口，使用其他数字id切换至对应窗口

常用命令
  tmux new -s foo # 新建名称为foo的会话
  tmux ls # 列出所有tmux会话
  tmux a # 恢复至上一次的会话
  tmux a -t foo # 恢复名称为foo的会话，会话默认名称为数字
  tmux kill-session -t foo # 删除名称为foo的会话
  tmux kill-server # 删除所有的会话
##########################################tmux操作##########################################
_TMUX_


cat << _MERMAID_
##########################################mermaid语法##########################################
时序图sequenceDiagram
  打开序列编号 autonumber 
  元素 participant 或 actor
  别名 as  例如：actor A as AliasA
                 participant B as AliasB
  激活 activate deactivate 
  批注 note left of 例如: note left of A: 批注信息
       note right of
       note over
  循环 loop
  并行 par
  选择 alt
  单选 opt
  注释 %%
##########################################mermaid语法##########################################
_MERMAID_


cat << _DOCKER_
##########################################docker命令##########################################
查看所有容器：docker pa -a
启动容器：docker start <容器ID>
停止容器：docker stop <容器ID>
删除容器：docker rm -f <容器ID>
后台运行: docker run -itd --name <容器名称> <镜像名称> /bin/bash
进入容器：docker attach <容器ID>
          docker exec <容器ID>         推荐，退出容器终端，不终止容器执行
导出容器到本地: docker export -o <备份名称>.tar <容器ID>
正常退出不关闭容器：Ctrl+P+Q

##########################################docker命令##########################################
_DOCKER_
