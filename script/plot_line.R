# install.packages("dplyr",repos = "https://mirrors.ustc.edu.cn/CRAN/")
# install.packages("data.table",repos = "https://mirrors.ustc.edu.cn/CRAN/")
# install.packages("ggplot2",repos = "https://mirrors.ustc.edu.cn/CRAN/")

# load packages
library(dplyr)
library(data.table)
library(ggplot2)

# set path
path="E:/8sem/"
setwd(path)
file<-list.files()
# set file index
# check the files in the workspace and set index
fileIndex=2

# load data
time.record.orb<-as.data.frame(fread(file[fileIndex],header=F))
time.record.orb<-select(time.record.orb,-V1)
names(time.record.orb)<-"result"
time.record.orb$result<-gsub("s","",time.record.orb$result)
time.record.orb$result<-as.numeric(time.record.orb$result)
time.record.orb$index<-1:dim(time.record.orb)[1]
summary(time.record.orb)

# plot
if(dir.exists("result")){
  dir.create("result")
}
setwd("result")
# tutorial:http://docs.ggplot2.org/current/
# set start and end point and title
p.start=1
p.end=2000
title=paste("ORB-Record",p.start,p.end,sep="-")

########################################################
ggplot(data=time.record.orb[p.start:p.end,],aes(index,result))+
  geom_line(size=1,color="navy")+
  geom_point(color="red")+
  labs(title=title)+
  theme_light()+
  coord_cartesian(xlim=c(p.start,p.end))+
  theme(legend.position="bottom",
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        panel.background = element_rect(fill = "seashell"),
        panel.border = element_rect(size=5))
#########################################################
ggsave(paste(title,".png",sep=""),width=16,height=9,units = "in",limitsize = F)
setwd(path)