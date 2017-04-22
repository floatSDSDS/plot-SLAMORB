setwd(path)
setwd("result")
if(!dir.exists(result.pose)){
  dir.create(result.pose)
}
setwd(result.pose)


pose.temp=rbind(mutate(pose.record[[1]],index=10),mutate(pose.record[[2]],index=11))
len<-dim(pose.temp)[1]
g.pose.together<-ggplot(data=pose.temp,aes(x,y))+
  geom_path(size=size.line.pose,color="navy")+
  geom_point(color="orange",shape=7,size=size.marker.pose)+
  labs(title=pose.title,x=pose.xlab,y=pose.ylab)+
  facet_wrap(~index,ncol=2,scales = "free")+
  theme_light()+
  scale_y_reverse()+
  scale_x_reverse()+
  theme(
#    legend.background = element_rect(size=0.5, linetype="solid", colour ="darkblue"),
#    legend.position="bottom",
    text=element_text(family="Times New Roman"),
    plot.title = element_text(size=size.title,hjust = 0.5),
    axis.text.x = element_text(size = size.axis),
    axis.text.y = element_text(size = size.axis),
    axis.title.x = element_text(size = size.labs),
    axis.title.y = element_text(size = size.labs),
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(size=size.border)
  )

g.pose.together
ggsave(filename=paste(paste(Outputname.pose,10,11,Sys.Date(),sep="-"),".png",sep=""),
       g.pose.together,device="png",
       width = plot.width,height = plot.height,units = "in")
ggsave(filename=paste(paste(Outputname.pose,10,11,Sys.Date(),sep="-"),".eps",sep=""),
       g.pose.together,device="eps",
       width = plot.width,height = plot.height,units = "in")


setwd(path)
