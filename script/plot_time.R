setwd(path)
setwd("result")
if(!dir.exists(result.time)){
  dir.create(result.time)
}
setwd(result.time)


time.temp=time.record[[file.index.time]]
g.time<-ggplot(data=time.temp,aes(frame.number,time*1000))+
  geom_line(size=size.line.time,color="navy")+
  geom_point(color="red",shape=19,size=size.marker.time)+
  theme_light()+
  labs(x=time.xlab,y=time.ylab,title=time.title)+
  theme(
    text=element_text(family = font.famly),
    strip.background = element_blank(),
    plot.title = element_text(size=size.title,hjust = 0.5),
    axis.text.x = element_text(size = size.axis),
    axis.text.y = element_text(size = size.axis),
    axis.title.x = element_text(size = size.labs),
    axis.title.y = element_text(size = size.labs),
    panel.background = element_rect(fill = "white"),
    panel.border = element_rect(size=size.border)
  )

ggsave(filename=paste(paste(Outputname.time,record.index[record.ith],Sys.Date(),sep="-"),".png",sep=""),
       g.time,device="png",
       width = plot.width,height = plot.height,units = "in")
ggsave(filename=paste(paste(Outputname.time,record.index[record.ith],Sys.Date(),sep="-"),".pdf",sep=""),
       g.time,device="pdf",
       width = plot.width,height = plot.height,units = "in")
  

setwd(path)