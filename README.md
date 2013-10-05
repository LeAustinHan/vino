#overview
> **vino**: Kobe Bryant's nickname means the man who are no longer young but full of sweet-smelling like ripe wine.

It's a tool? A vioce reporter? A automatic robot?… Yeah, It is a set packaged them for your ***Mac OS X***. 

It reports with **voice**(chose any language you like).

##service


```
     en                                                        zh-cn
---------------------------------------------------------------------------------------
say hello                                                         开机问候
network checker                                                   网络连接检查 
go-agent launcher                                                 go-agent 代理启动
cloud-hosts automatic updater                                     云hosts文件自动更新
X package manager automatic updater(cocoapods , homebrew …)       包管理工具自更新        
memory warning monitor / clearer                                  内存警告/自动清理
cpu overhead monitor                                              cpu超负荷警告
battery below-normal monitor                                      电池电量过低警告
file-system monitor                                               文件系统监控
timing shutdown                                                   定时关机
weather forecast                                                  天气预报
stock monitor                                                     股票异常警告
timekeeping                                                       整点报时
trashClear                                                        垃圾箱过载自动清理
……… 【depends on your imagination】                               【…天空才是极限】
```

## how it works?

When os runs at startup, launch two LaunchAgent program through two plist files:

1. com.yanghua.vinoForAgent - vino deamon server
2. com.yanghua.launchVinoForAgent - startup automatic services launcher

what's more, ***vino deamon server*** is a http-server built with **node.js**. And ***startup automatic services launcher*** is a shell script sends some services' http-get request to vino for launching these services deamon. 

On the other hand, not all services are started as deamon when os run as startup, you also have a choice to start a service when os is running! The way of launching is very simple by opening your web broser then sending a service's url that you want to start.

## to do
* configurable speak words
* configurable some warning-benchmark
* finish install script

## contact & more details
desc:see [My Blog](#)

any problem, let me know:

1. [yanghua1127@gmail.com](mailto:yanghua1127@gmail.com)
2. [http://blog.csdn.net/yanghua_kobe](http://blog.csdn.net/yanghua_kobe)
enjoy and have fun!





