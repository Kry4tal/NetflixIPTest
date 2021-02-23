#!/bin/bash
function test_ipv4() {
    result=`curl -4sSL "https://www.netflix.com/" | grep "Not Available"`;
    if [ "$result" != "" ];then
        echo -e "\033[34m很遗憾 Netflix不服务此地区\033[0m";
        return;
    fi
    
    result=`curl -4sSL "https://www.netflix.com/title/80018499" | grep "page-404"`;
    if [ "$result" != "" ];then
        echo -e "\033[34m很遗憾 这台机IP不能看Netflix\033[0m";
        return;
    fi
    
    result1=`curl -4sSL "https://www.netflix.com/title/70143836" | grep "page-404"`;
    result2=`curl -4sSL "https://www.netflix.com/title/80027042" | grep "page-404"`;
    result3=`curl -4sSL "https://www.netflix.com/title/70140425" | grep "page-404"`;
    result4=`curl -4sSL "https://www.netflix.com/title/70283261" | grep "page-404"`;
    result5=`curl -4sSL "https://www.netflix.com/title/70143860" | grep "page-404"`;
    result6=`curl -4sSL "https://www.netflix.com/title/70202589" | grep "page-404"`;
    
    if [[ "$result1" != "" ]] && [[ "$result2" != "" ]] && [[ "$result3" != "" ]] && [[ "$result4" != "" ]] && [[ "$result5" != "" ]] && [[ "$result6" != "" ]];then
        echo -e "\033[33m这台机的IP可以打开Netflix 但是仅解锁自制剧\033[0m";
        return;
    fi
    
    echo -e "\033[32m这台机的IP可以打开Netflix 并解锁全部流媒体\033[0m";
    return;
}

function test_ipv6() {
    result=`curl -6sSL "https://www.netflix.com/" | grep "Not Available"`;
    if [ "$result" != "" ];then
        echo -e "\033[34m很遗憾 Netflix不服务此地区\033[0m";
        return;
    fi
    
    result=`curl -6sSL "https://www.netflix.com/title/80018499" | grep "page-404"`;
    if [ "$result" != "" ];then
        echo -e "\033[34m这台机的IP不能看Netflix\033[0m";
        return;
    fi
    
    result1=`curl -6sSL "https://www.netflix.com/title/70143836" | grep "page-404"`;
    result2=`curl -6sSL "https://www.netflix.com/title/80027042" | grep "page-404"`;
    result3=`curl -6sSL "https://www.netflix.com/title/70140425" | grep "page-404"`;
    result4=`curl -6sSL "https://www.netflix.com/title/70283261" | grep "page-404"`;
    result5=`curl -6sSL "https://www.netflix.com/title/70143860" | grep "page-404"`;
    result6=`curl -6sSL "https://www.netflix.com/title/70202589" | grep "page-404"`;
    
    if [[ "$result1" != "" ]] && [[ "$result2" != "" ]] && [[ "$result3" != "" ]] && [[ "$result4" != "" ]] && [[ "$result5" != "" ]] && [[ "$result6" != "" ]];then
        echo -e "\033[33m这台机IP可以打开Netflix 但是仅解锁自制剧\033[0m";
        return;
    fi
    
    echo -e "\033[32m这台机的IP可以打开Netflix 并解锁全部流媒体\033[0m";
    return;
}
export LANG=us_EN;
clear;
echo -e "\033[31m测试结束\033[0m";

curl -V > /dev/null 2>&1;
if [ $? -ne 0 ];then
    echo -e "\033[31m记得安装Curl\033[0m";
    exit;
fi

echo " >> IPv4解锁情况结果";
check4=`ping 1.1.1.1 -c 1 2>&1 | grep -i "unreachable"`;
if [ "$check4" == "" ];then
    test_ipv4;
else
    echo -e "\033[34m当前主机不支持IPv4,已跳过...\033[0m";
fi

echo " >> IPv6解锁情况结果";
check6=`ping6 240c::6666 -c 1 2>&1 | grep -i "unreachable"`;
if [ "$check6" == "" ];then
    test_ipv6;
else
    echo -e "\033[34m当前主机不支持IPv6,已跳过...\033[0m";
fi
