#!/bin/bash
# -*- coding:utf-8 -*-
# Created by:yanghua
# Date      :2013-10-13
# 
# Usage     : sh nba_schedule_formatter.sh
# generated from :
# http://www.cbssports.com/nba/eye-on-basketball/23041832/nba-releases-20132014-nba-schedule
# 
# just one statement！
 
while read line
do
    echo $line | awk '{
                        #field num enum (the name of some area has two words )
                        # e.g.
                        #Orlando vs Indiana (field num : 10)
                        #Indiana vs New Orleans (field num : 11)
                        #L.A. Clippers vs L.A. Lakers (field num : 12)
                        if(NF==10 || NF==11 || NF==12){

                            _suffix=""
                            prefix=""

                            if(NF==10){                                     #10
                                tab_5=""
                                if(length($5)<=7){
                                    tab_5="\t""\t""\t""\t"
                                }else if(length($5)<=11){
                                    tab_5="\t""\t""\t"
                                }else if(length($5)<=15){
                                    tab_5="\t""\t"
                                }

                                tab_6=""
                                if(length($6)<=7){
                                    tab_6="\t""\t""\t""\t"
                                }else if(length($6)<=11){
                                    tab_6="\t""\t""\t"
                                }else if(length($6)<=15){
                                    tab_6="\t""\t"
                                }

                                tab_8=""
                                total_len=length($7) + length($8) + 1
                                if(total_len <=7 ){
                                    tab_8="\t""\t""\t"
                                }else{
                                    tab_8="\t""\t"
                                }

                                _suffix=$5tab_5$6tab_6$7" "$8tab_8$9" "$10;

                            }else if(NF==12){                               #12

                                tab_6=""
                                total_len=length($5) + length($6) + 1
                                if(total_len <= 7){
                                    tab_6="\t""\t""\t""\t"
                                }else if(total_len <= 11){
                                    tab_6="\t""\t""\t"
                                }else if(total_len <= 15){
                                    tab_6="\t""\t"
                                }

                                tab_8=""
                                total_len=length($7) + length($8) + 1
                                if(total_len <= 7){
                                    tab_8="\t""\t""\t""\t"
                                }else if(total_len <= 11){
                                    tab_8="\t""\t""\t"
                                }else if(total_len <= 15){
                                    tab_8="\t""\t"
                                }

                                tab_10=""
                                total_len=length($9) + length($10) + 1
                                if(total_len <=7 ){
                                    tab_10="\t""\t""\t"
                                }else{
                                    tab_10="\t""\t"
                                }

                                _suffix=$5" "$6tab_6$7" "$8tab_8$9" "$10tab_10$11" "$12;

                            }else if(NF==11){                               #11

                                #there are two possible:
                                #possible 1:like this - New Orleans VS Orlando [XXX XXX VS XXX]
                                #possible 2:like this - Orlando VS New Orleans [XXX VS XXX XXX]

                                tmp_team_1=$5" "$6
                                if(tmp_team_1=="L.A. Clippers"  || tmp_team_1=="L.A. Lakers"    ||
                                    tmp_team_1=="New Orleans"   || tmp_team_1=="Oklahoma City"  ||
                                    tmp_team_1=="Golden State"  || tmp_team_1=="New York"       ||
                                    tmp_team_1=="San Antonio"    ){
                                    tab_6=""
                                    total_len=length($5) + length($6) + 1
                                    if(total_len <= 7){
                                        tab_6="\t""\t""\t""\t"
                                    }else if(total_len <= 11){
                                        tab_6="\t""\t""\t"
                                    }else if(total_len <= 15){
                                        tab_6="\t""\t"
                                    }

                                    tab_7=""
                                    if(length($7) <= 7){
                                        tab_7="\t""\t""\t""\t"
                                    }else if(length($7)<=11){
                                        tab_7="\t""\t""\t"
                                    }else if(length($7)<=15){
                                        tab_7="\t""\t"
                                    }

                                    tab_9=""
                                    total_len=length($8) + length($9) + 1
                                    if(total_len <= 7 ){
                                        tab_9="\t""\t""\t"
                                    }else{
                                        tab_9="\t""\t"
                                    }

                                    _suffix=$5" "$6tab_6$7tab_7$8" "$9tab_9$10" "$11;

                                }else{
                                    tab_5=""
                                    if(length($5) <= 7){
                                        tab_5="\t""\t""\t""\t"
                                    }else if(length($5) <= 11){
                                        tab_5="\t""\t""\t"
                                    }else if(length($5) <= 15){
                                        tab_5="\t""\t"
                                    }

                                    tab_7=""
                                    total_len=length($6) + length($7) + 1
                                    if(total_len <= 7){
                                        tab_7="\t""\t""\t""\t"
                                    }else if(total_len <= 11){
                                        tab_7="\t""\t""\t"
                                    }else if(total_len <= 15){
                                        tab_7="\t""\t"
                                    }

                                    tab_9=""
                                    total_len=length($8) + length($9) + 1
                                    if(total_len <=7 ){
                                        tab_9="\t""\t""\t"
                                    }else{
                                        tab_9="\t""\t"
                                    }

                                    _suffix=$5tab_5$6" "$7tab_7$8" "$9tab_9$10" "$11;

                                }
                            }

                            #handle prefix when the month is [march] or [april] should add a tab key
                            if($2=="March" || $2=="April"){
                                prefix=$1" "$2" "$3" ""\t"$4"\t"
                            }else{
                                prefix=$1" "$2" "$3" "$4"\t"
                            }

                            #join
                            print prefix""_suffix

                        }else if(NF==6){                #the header
                            print $1"\t""\t""\t""\t""\t"$2"\t""\t""\t""\t"$3"\t""\t""\t""\t"$4" "$5"\t""\t"$6
                        }else{
                            print $0
                        }
                      }'  >> nba_2013_to_2014_schedule.md
done < /Users/yanghua/Desktop/nba_schedule_source.txt

