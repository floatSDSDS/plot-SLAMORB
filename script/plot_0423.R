setwd(path)
setwd("src")
keyframe<-as.data.frame(fread(list.files()[2],header=F))
names(keyframe)<-c("frame number","x","y","z")

setwd(path)
setwd("result")
if(!dir.exists(result.pose)){
  dir.create(result.pose)
}
setwd(result.pose)
keyframe$linetype="Trajectory"
keyframe$shape="Key Frame"

len<-dim(keyframe)[1]
g.keyframe<-ggplot(data=keyframe,aes(x,y))+
  geom_path(aes(linetype=linetype),colour="navy",size=size.line.pose)+
  geom_point(aes(x,y,shape=shape),colour="orange",size=size.marker.pose)+
  labs(title=pose.title,x=pose.xlab,y=pose.ylab)+
  theme_light()+
  scale_y_reverse()+
  scale_x_reverse()+
  theme(
    legend.background = element_rect(fill=alpha("white",.5)),
    legend.box.background = element_rect(),
    legend.box.margin = margin(2,2,2,2),
    legend.position = c(.9,.05),
    legend.box="horizontal",
    text=element_text(family = font.famly),#family="Times New Roman"),
    plot.title = element_text(size=size.title,hjust = 0.5),
    axis.text.x = element_text(size = size.axis),
    axis.text.y = element_text(size = size.axis),
    axis.title.x = element_text(size = size.labs),
    axis.title.y = element_text(size = size.labs),
    legend.text = element_text(size=size.axis),
    strip.text.x = element_blank(),
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(size=size.border,color="black")
  )+
  scale_shape_manual(values=7,guide=guide_legend(title = NULL))+
  scale_linetype_manual(values="solid",guide=guide_legend(title = NULL))

g.keyframe


ggsave(filename=paste(paste(Outputname.pose,"new",Sys.Date(),sep="-"),".png",sep=""),
       g.keyframe,device="png",
       width = plot.width,height = plot.height,units = "in")
ggsave(filename=paste(paste(Outputname.pose,"new",Sys.Date(),sep="-"),".pdf",sep=""),
       g.keyframe,device="pdf",
       width = plot.width,height = plot.height,units = "in")


setwd(path)
