#!/bin/sh
# 本脚本请在git bash中运行
# 作者：Konglb
# 在终端输入 ./deploy.sh 即可运行
# 博客：https://konglb.top

echo -e "\033[32m正在清理Hexo缓存...\033[0m"
hexo clean

echo -e "\033[32m正在生成Hexo静态文件...\033[0m"
hexo generate

echo -e "\033[32m正在部署Hexo博客...\033[0m"
hexo deploy

if [ $? -ne 0 ]; then
    echo -e "\033[31m 部署失败！请检查网络情况！ \033[0m"
else
    echo -e "\033[32m恭喜你！博客已成功部署！\033[0m"
fi