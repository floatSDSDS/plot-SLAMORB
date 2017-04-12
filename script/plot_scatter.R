# install.packages("plotly",repos = "https://mirrors.ustc.edu.cn/CRAN/")


library(plotly)
library(data.table)

#######################################set path
setwd("E:/8sem/健浩")
list.files()
data.line<-as.data.frame(fread("data.csv",header=T))
#######################################

names(data.line)<-c("timestamp",paste("m",c("x","y","z"),sep=""),paste("b",c("w","x","y","z"),sep=""))
len<-dim(data.line)[1]
data.marker<-data.line[seq(1,len,100),]

if(!dir.exists("result")){
  dir.create("result")
}

# plot 3d
p.3d<- plot_ly(data.line, x = ~mx, y = ~my, z = ~mz, 
               type = 'scatter3d', mode = 'lines',
               opacity = 1, color =  I("orange"),
               text="path",name="")%>%
  add_markers(data=data.marker,x=~mx,y=~my,z=~mz,
              color= I("navy"),size=I(3),
              text="key frame",name="")%>%
  add_markers(data=data.line[dim(data.line)[1],],x=~mx,y=~my,z=~mz,
              color= I("coral"),size=I(10),
              text="Current frame",name="")%>%
  hide_legend()
p.3d
# use Export in the Viewer to output(in order to take a nice shot)

# plot 2d
p.2d<- plot_ly(data.line, x = ~mx, y = ~my, 
               type = 'scatter', mode = 'lines', 
               color = I("orange"),
               text="path",name="")%>%
  add_markers(data=data.marker,x=~mx,y=~my,
              symbol=I(7),color=I("navy"),size=I(6),
              text="key frame",name="")%>%
  add_markers(data=data.line[dim(data.line)[1],],x=~mx,y=~my,
              symbol=I(7),color=I("coral"),size=I(25),
              text="Current frame",name="")%>%
  hide_legend()
p.2d
plotly_IMAGE(p.2d, format = "png", out_file = "result/output2d.png")

