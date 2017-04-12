path.data=paste("src/",path.data,sep="")
setwd(path.data)
file.list<-list.files()
###########################################################
pose.record<-list()
time.record<-list()
###########################################################
# data preprocessing
for(record.ith in 1:5){
  # pose.record
  pose.record[[record.ith]]<-as.data.frame(fread(file.list[record.ith],header=F))
  names(pose.record[[record.ith]])<-c("x","y","z")
  temp<-t(as.data.frame(strsplit(pose.record[[record.ith]]$x,":")))
  pose.record[[record.ith]]$x<-as.numeric(temp[,2])
  pose.record[[record.ith]]$frame.number<-as.numeric(temp[,1])+1

  # time.record
  time.record[[record.ith]]<-as.data.frame(fread(file.list[record.ith+5],header=F))
  time.record[[record.ith]]<-t(as.data.frame(strsplit(time.record[[record.ith]]$V1,":")))
  rownames(time.record[[record.ith]])<-1:dim(time.record[[record.ith]])[1]
  colnames(time.record[[record.ith]])<-c("frame.number","time")
  time.record[[record.ith]]<-as.data.frame(time.record[[record.ith]])
  time.record[[record.ith]]$time<-as.numeric(time.record[[record.ith]]$time)
#  time.record[[record.ith]]$time<-as.numeric(gsub("s","",time.record[[record.ith]]$time))
  time.record[[record.ith]]$frame.number<-as.numeric(time.record[[record.ith]]$frame.number)
  if(Toggle.DelTime){
    time.record[[record.ith]]<-filter(time.record[[record.ith]],time<10)
  }
}

# summary(pose.record[[1]])
# summary(time.record[[1]])
# View(pose.record[[1]])
# View(time.record[[1]])


################################################################################
# seprate plot pose
if(Toggle.Seprate){
  setwd(path)
  setwd("result")
  if(!dir.exists(result.pose)){
    dir.create(result.pose)
  }
  setwd(result.pose)
  g.pose.seperate<-list()

  for(record.ith in 1:5){
    pose.temp=pose.record[[record.ith]]
    len<-dim(pose.temp)[1]
    g.pose.seperate[[record.ith]]<-ggplot(data=pose.temp,aes(x,y))+
      geom_path(size=1,color="navy")+
      geom_point(color="red",shape=19,size=3)+
      geom_point(color=heat.colors(len)[pose.temp$frame.number],shape=7,size=2)+
      theme_light()+
      scale_y_reverse()+
      scale_x_reverse()+
      labs(title=paste("Path",record.index[record.ith]))+
      theme(
        legend.position="bottom",
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        axis.title.y = element_text(size = 10),
        panel.background = element_rect(fill = "white"),
        panel.border = element_rect(size=3)
      )
    ggsave(filename=paste(paste(Outputname.pose,record.index[record.ith],Sys.Date(),sep="-"),".eps",sep=""),
           g.pose.seperate[[record.ith]],device="eps",
           width = 16,height = 9,units = "in")
    ggsave(filename=paste(paste(Outputname.pose,record.index[record.ith],Sys.Date(),sep="-"),".png",sep=""),
           g.pose.seperate[[record.ith]],device="png",
           width = 16,height = 9,units = "in")
  }
}

################################################################################
# plot pose one
if(!Toggle.Seprate){
  setwd(path)
  setwd("result")
  if(!dir.exists(result.pose)){
    dir.create(result.pose)
  }
  setwd(result.pose)
  pose.record.rbind<-pose.record[[1]]
  pose.record.rbind$index<-record.index[1]
  for(i in 2:5){
    pose.temp<-pose.record[[i]]
    pose.temp$index<-record.index[i]
    pose.record.rbind<-rbind(pose.record.rbind,pose.temp)
  }
  g.pose.one<-ggplot(data=pose.record.rbind,aes(x,y,group=index))+
    geom_path(size=1,color="navy")+
    geom_point(color="red",shape=19,size=3)+
    facet_wrap(~index,nrow=2,ncol=3,scales = "free")+
    theme_light()+
    scale_y_reverse()+
    scale_x_reverse()+
    theme(
      legend.position="bottom",
      plot.title = element_text(hjust = 0.5),
      axis.text.x = element_text(size = 10),
      axis.text.y = element_text(size = 10),
      panel.background = element_rect(fill = "white"),
      panel.border = element_rect(size=3)
    )

  ggsave(filename=paste(paste(Outputname.pose,Sys.Date(),sep="-"),".eps",sep=""),
         g.pose.one,device="eps",
         width = 16,height = 9,units = "in")
  ggsave(filename=paste(paste(Outputname.pose,Sys.Date(),sep="-"),".png",sep=""),
         g.pose.one,device="png",
         width = 16,height = 9,units = "in")
}

################################################################################
# seprate plot time
if(Toggle.Seprate){
  setwd(path)
  setwd("result")
  if(!dir.exists(result.time)){
    dir.create(result.time)
  }
  setwd(result.time)
  g.time.seperate<-list()
  for(record.ith in 1:5){
    time.temp=time.record[[record.ith]]
    g.time.seperate[[record.ith]]<-ggplot(data=time.temp,aes(frame.number,time))+
      geom_line(size=1,color="navy")+
      geom_point(color="red",shape=19,size=3)+
      theme_light()+
      labs(title=paste("Delay",record.index[record.ith]))+
      theme(
        legend.position="bottom",
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        axis.title.y = element_text(size = 10),
        panel.background = element_rect(fill = "white"),
        panel.border = element_rect(size=3)
      )
    ggsave(filename=paste(paste(Outputname.time,record.index[record.ith],Sys.Date(),sep="-"),".eps",sep=""),
           g.time.seperate[[record.ith]],device="eps",
           width = 16,height = 9,units = "in")
    ggsave(filename=paste(paste(Outputname.time,record.index[record.ith],Sys.Date(),sep="-"),".png",sep=""),
           g.time.seperate[[record.ith]],device="png",
           width = 16,height = 9,units = "in")
  }
}

################################################################################
# plot time one
if(!Toggle.Seprate){
  setwd(path)
  setwd("result")
  if(!dir.exists(result.time)){
    dir.create(result.time)
  }
  setwd(result.time)
  time.record.rbind<-time.record[[1]]
  time.record.rbind$index<-record.index[1]
  for(i in 2:5){
    time.temp<-time.record[[i]]
    time.temp$index<-record.index[i]
    time.record.rbind<-rbind(time.record.rbind,time.temp)
  }
  g.time.one<-ggplot(data=time.record.rbind,aes(frame.number,time,group=index))+
    geom_path(size=1,color="navy")+
    geom_point(color="red",shape=19,size=1)+
    facet_wrap(~index,nrow=2,ncol=3,scales = "free")+
    theme_light()+
    theme(
      legend.position="bottom",
      plot.title = element_text(hjust = 0.5),
      axis.text.x = element_text(size = 10),
      axis.text.y = element_text(size = 10),
      panel.background = element_rect(fill = "white"),
      panel.border = element_rect(size=3)
    )
  g.time.one
  ggsave(filename=paste(paste(Outputname.time,Sys.Date(),sep="-"),".eps",sep=""),
         g.time.one,device="eps",
         width = 16,height = 9,units = "in")
  ggsave(filename=paste(paste(Outputname.time,Sys.Date(),sep="-"),".png",sep=""),
         g.time.one,device="png",
         width = 16,height = 9,units = "in")
}

setwd(path)
