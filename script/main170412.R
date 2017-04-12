
library(data.table)
library(dplyr)
library(ggplot2)

# 设置路径
path="E:/8sem/健浩"
setwd(path)

# Toggle.Seprate==T, seprate
# Toggle.Seprate==F, one
Toggle.Seprate=T
###########################################################
file.list<-list.files()
file.list

# 看看它读入的文件顺序，填入record.index，比如我这边是10,11,7,8,9，另外注意一下pose和time哪个先，我怕不同系统上会不一样
# [1] "pose_record_10.txt"        "pose_record_11.txt"        "pose_record_7.txt"         "pose_record_8.txt"         "pose_record_9.txt"        
# [6] "time_record_client_10.txt" "time_record_client_11.txt" "time_record_client_7.txt"  "time_record_client_8.txt"  "time_record_client_9.txt" 
record.index<-c(10,11,7,8,9)

############################################################
# 设置Pose和Time输出图片的存储路径
result.pose<-"pose"
result.time<-"time"
# 设置输出文件名字
Outputname.pose="Path"
Outputname.time="Delay"

# 设置是否删除time跳变到128的点
Toggle.DelTime<-T


setwd(path)
source('script/plot_switch170412.R', encoding = 'UTF-8')

