# 安装包，第一次运行时跑这里。
# install.packages("data.table",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")
# install.packages("dplyr",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")
# install.packages("ggplot2",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")
# install.packages("extrafont",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")
# install.packages("extrafontdb",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")
# install.packages("showtext",repos = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/")

library(data.table)
library(dplyr)
# library(extrafont)
# library(extrafontdb)
# font_import()
# y
# loadfonts(device="pdf")     
# loadfonts("win")
library(ggplot2)
library(showtext)
showtext.auto()
showtext.opts(dpi = 120)
font.add("Times New Roman", "times.ttf") 
#showtext.begin()

# 设置路径
path="E:/git/plot-SLAMORB/"
path.data="orangepi_data_20170412"
path.data<-paste("src/",path.data,sep="")
setwd(path)
# "times.ttf"     "timesbd.ttf"   "timesbi.ttf"   "timesi.ttf"
###########################################################
setwd(path.data)
file.list<-list.files()
file.list
# 看看它读入的文件顺序，填入record.index，比如我这边是10,11,7,8,9，另外注意一下pose和time哪个先，我怕不同系统上会不一样
# [1] "pose_record_10.txt"        "pose_record_11.txt"        "pose_record_7.txt"         "pose_record_8.txt"         "pose_record_9.txt"        
# [6] "time_record_client_10.txt" "time_record_client_11.txt" "time_record_client_7.txt"  "time_record_client_8.txt"  "time_record_client_9.txt" 
record.index<-c(10,11,7,8,9)
####################################################################
# 数据预处理
# 这里注意，输完file.list查看需要的文件排序，检查需要文件index，设置setting中的file.index.pose和file.index.time（处理文件）
# file.list
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
  names(time.record[[record.ith]])<-c("frame.number","time")
  time.record[[record.ith]]$frame.number<-1:length(time.record[[record.ith]]$frame.number)
  
}

#################################################################
# Settings

# 设置Pose和Time输出图片的存储路径
result.pose<-"pose4-23"
result.time<-"time4-23"

# 设置输出文件名字
Outputname.pose="Estimated Trajectory"
Outputname.time="Computational Time"# of Each Dataset"


# 输出pose文件索引
file.index.pose=c(1,2)
file.index.time=c(1)

# 输出图长宽
plot.width=16
plot.height=10

# 文字大小，注意ggplot2里，图表的大小是相对的，但字体的大小是绝对的，需要结合输出长宽一起改
size.title=30
size.labs=25  #坐标轴标题
size.axis=15  #坐标轴刻度
# size.legend=12  #图例大小
# size.legend.title=17  #图例标签

# 文字标题
pose.title=Outputname.pose
pose.xlab="x(m)"
pose.ylab="y(m)"

time.title="Computational Time in Sequence: MH_5_difficult"
time.xlab="Frame Number"
time.ylab="Time(ms)"

# 边框粗细
size.border=1

# 图上粗细大小
size.line.pose=.75
size.marker.pose=2.5
size.line.time=1
size.marker.time=2

# font
font.famly="Times New Roman"

# 绘制pose图，在result中找建立的文件夹（如本例中pose4-22）
setwd(path);source('script/plot_trajectory.R', encoding = 'UTF-8')
#检查图怎么样：
g.pose.together

# 绘制pose图，在result中找建立的文件夹（如本例中time4-22）
# 
setwd(path);source('script/plot_time.R', encoding = 'UTF-8')
#检查图怎么样：
g.time


# showtext.end()                  ## turn off showtext
# dev.off()
