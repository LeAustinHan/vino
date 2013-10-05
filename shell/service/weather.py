#! /usr/local/bin/python
# -*- coding:utf-8 -*-

# Created by:yanghua
# Date      :2013-02-13

import feedparser                           #the library for rss
import time, sys, subprocess, os, re

#handle the chinese encoding between ascii and utf-8 in python 2.X#
###################################################################
reload(sys)                                                       #
sys.setdefaultencoding('utf8')                                    #
###################################################################

WEATHER_SERVICE_URL ='http://xml.weather.yahoo.com/forecastrss?w={0}&u={1}'

#the city's woeid
#find it at: http://sigizmund.info/woeidinfo/
WOEID               ="2137081"              #nan jing

#the temperature's case sensitive
UNITS_FOR_TEMPERATURE ="c"                  #it means 摄氏度

LOC_DIC=\
{
    "Nanjing"       :   "南京"
}

#the code of weather list below
#more detail :http://developer.yahoo.com/weather/
WEATHER_CODE_to_DESC=\
{
    "26"            :   "多云",
    "20"            :   "有雾",
    "0"             :   "龙卷风",
    "1"             :   "热带风暴",
    "2"             :   "飓风",
    "3"             :   "强雷暴",
    "4"             :   "雷暴",
    "5"             :   "混合雨雪天气",
    "6"             :   "混合雨和雨夹雪",
    "7"             :   "混合雪和雨夹雪",
    "8"             :   "冷冻小雨",
    "9"             :   "细雨",
    "10"            :   "冻雨",
    "11"            :   "中小雨",
    "12"            :   "淋雨",
    "13"            :   "飘雪",
    "14"            :   "阵雪",
    "15"            :   "中小雪",
    "16"            :   "雪",
    "17"            :   "冰雹",
    "18"            :   "雨雪",
    "19"            :   "粉尘",
    "21"            :   "阴霾",
    "22"            :   "烟雾",
    "23"            :   "恶劣天气",
    "24"            :   "有风",
    "25"            :   "寒冷",
    "27"            :   "晴转多云",
    "28"            :   "晴转多云",
    "29"            :   "局部多云",
    "30"            :   "局部多云",
    "31"            :   "明朗",
    "32"            :   "晴朗",
    "33"            :   "良好",
    "34"            :   "良好",
    "35"            :   "混合雨和冰雹",
    "36"            :   "炎热",
    "37"            :   "局部地区有雷阵雨",
    "38"            :   "分散性的雷阵雨",
    "39"            :   "分散性的雷阵雨",
    "40"            :   "零星阵雨",
    "41"            :   "大雪",
    "42"            :   "零星小雪",
    "43"            :   "大雪",
    "44"            :   "局部地区多云",
    "45"            :   "雷阵雨",
    "46"            :   "阵雪",
    "47"            :   "间隔性雷阵雨",
    "3200"          :   "无服务"
}

STATE_OF_PRESSURE=\
{
    "0"             :   "稳定",
    "1"             :   "上升",
    "2"             :   "回落"
}

#handle some "special char" which will stop the "speak order"
#such as -、（、）.....
PRE_PROCESSING_EXPRESSION=\
(
    ('[-]'          ,   '负'),
    ('[\(]'         ,   '左括号'),
    ('[\)]'         ,   '右括号')
    #......
    #TODO:append more
)

#network is unnormal's regex pattern
PING_UNPONG_REGEX_EXPRESSION = '0 packets received'


def parserRSSFeed(feedUrl):
    
    parseredData =feedparser.parse(feedUrl)

    city="将为您播报: %s 的天气预报" % LOC_DIC[parseredData.channel.yweather_location['city']]
    print(city)
    speak(city)

    itemInfo=parseredData.entries[0]
    
    #----------------------------condition------------------------------------#
    condition_desc="今日天气情况： %s " % WEATHER_CODE_to_DESC[itemInfo.yweather_condition['code']]
    print(condition_desc)
    speak(condition_desc)

    condition_temp="当前温度： %s ℃" % itemInfo.yweather_condition['temp']
    print(condition_temp)
    speak(condition_temp)
    
    #----------------------------wind------------------------------------#
    wind_chill="风力: %s 级" % parseredData.channel.yweather_wind['chill']
    print(wind_chill)
    speak(wind_chill)

    # wind_direction="风向: %s °" % parseredData.channel.yweather_wind['direction']
    # print(wind_direction)
    # speak(wind_direction)

    wind_speed="风速: %s 米每秒" % parseredData.channel.yweather_wind['speed']
    print(wind_speed)
    speak(wind_speed)

    #----------------------------atmosphere-----------------------------#
    atmosphere_humidity="湿度: %s %%" % parseredData.channel.yweather_atmosphere['humidity']
    print(atmosphere_humidity)
    speak(atmosphere_humidity)

    atmosphere_visibility="可见度: %s %s" % (parseredData.channel.yweather_atmosphere['visibility'],parseredData.channel.yweather_units['distance'])
    print(atmosphere_visibility)
    speak(atmosphere_visibility)

    atmosphere_rising="气压变化趋势为: %s " % STATE_OF_PRESSURE[parseredData.channel.yweather_atmosphere['rising']]
    print(atmosphere_rising)
    speak(atmosphere_rising)

    #----------------------------astronomy-----------------------------#
    # astronomy_sunrise="今日日出时间为: %s " % parseredData.channel.yweather_astronomy['sunrise']
    # print(astronomy_sunrise)
    # speak(astronomy_sunrise)
    
    # astronomy_sunset="今日日落时间为: %s " % parseredData.channel.yweather_astronomy['sunset']
    # print(astronomy_sunset)
    # speak(astronomy_sunset)

    #----------------------------forecast------------------------------------#
    weather_desc_tomorrow="明日天气为: %s " % WEATHER_CODE_to_DESC[itemInfo.yweather_forecast['code']]
    print(weather_desc_tomorrow)
    speak(weather_desc_tomorrow)

    tempHighest_tomorrow="明日最高温度: %s ℃" % itemInfo.yweather_forecast['high']
    print(tempHighest_tomorrow)
    speak(tempHighest_tomorrow)

    tempLowest_tomorrow="明日最低温度: %s ℃" % itemInfo.yweather_forecast['low']
    print(tempLowest_tomorrow)
    speak(tempLowest_tomorrow)

    speak('天气预报播报完毕！')

def speak(txtStr):
    speak_cmd ="say -v Ting-Ting %s " % processSpeakingTxt(txtStr)
    process   =subprocess.Popen(speak_cmd, shell=True, universal_newlines=True, stdout=subprocess.PIPE)
    process.wait()

def processSpeakingTxt(txtStr):
    global PRE_PROCESSING_EXPRESSION
    for (reg_Expression, replaceingStr) in PRE_PROCESSING_EXPRESSION:
        if re.search(reg_Expression, txtStr) is not None:
            txtStr = re.sub(reg_Expression, replaceingStr, txtStr)
    return txtStr

#added at Mon Apr 22 2013 by:yanghua 
def isNetworkNormal():
    '''
        desc: check the network is normal or not(just test on mac os x)
    '''
    try:
        cmdStr = "ping -c1 8.8.8.8"
        process = subprocess.Popen(cmdStr, shell=True, universal_newlines=True, stdout=subprocess.PIPE)
        process.wait()
        for line in process.stdout.readlines():
            if line.find(PING_UNPONG_REGEX_EXPRESSION) != -1:
                return False

        return True

    except Exception,e:

        return False
    

if __name__ == '__main__':
    WEATHER_SERVICE_URL=WEATHER_SERVICE_URL.format(WOEID,UNITS_FOR_TEMPERATURE)

    while True:
        if isNetworkNormal():
            parserRSSFeed(WEATHER_SERVICE_URL)
            break
        else:
            time.sleep(60)      #sleep 60s    
