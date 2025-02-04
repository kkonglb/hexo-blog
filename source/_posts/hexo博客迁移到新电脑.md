---
title: hexo博客迁移到新电脑
date: 2025-02-01 21:57:08
categories:
- 技能积累
tags:
- 技能积累
---

这篇文章结合[备份和迁移hexo博客](https://www.bilibili.com/video/BV13g41147yV/?spm_id_from=333.337.search-card.all.click&vd_source=6759ab7a746b50893c564c06fbc6a752)和其他的一些博客文章来进行创作。

# hexo框架的简单原理结构

![image-20250202180032527](./image-20250202180032527.png)

其中，前四个是文件夹，后四个是文件

> 1. node_modlues是存放模块的一个目录,在我们初始化博客（hexo init）的过程中自动执行npm install这个命令生成这样的一个模块目录
> 2. public文件夹是hexo g命令产生的一个html静态文件目录，执行hexo d就会上传这个public文件夹里面的所有内容
> 3. scafflolds主要存放博客的一些模版，默认有draft.md，page.md，post.md这三个，我们一般修改post.md也就是博客的模板就行了。
> 4. source文件夹主要就是存放博客的一些基本内容，如里面的_post文件夹存放博客文章，其他的自己看看就行了
> 5. theme文件夹存放的是主题，自己用的是哪个主题可以看一下github上相关的介绍来进行操作
> 6. package.json是一个包管理器，主要是用于管理和组织项目的依赖、脚本命令以及项目信息。
> 7. yarn.lock也是一个包管理器，这个先不用管
> 8. _config.yml是一些基本配置文件
> 9. _config.xxx.yml是主题配置文件

`package.json` 和 `node_modules` 文件夹有密切关系：

1. **`package.json`**：这是一个包含项目元数据和依赖信息的配置文件。它列出了项目所需的所有 npm 包及其版本信息（即依赖）。
2. **`node_modules`**：这是一个自动生成的文件夹，用于存放通过 npm 安装的所有依赖包。当你运行 `npm install` 时，npm 会根据 `package.json` 中列出的依赖项下载并安装相关包，并将它们存储在 `node_modules` 文件夹中。

简而言之，`package.json` 描述了项目需要哪些依赖，`node_modules` 存放了这些依赖的实际文件。

# 安装git和nodejs

**![image-20250202181817404](./image-20250202181817404.png)**

.github和.gitignore和.git都和git有关

其中安装git和nodejs这里就不讲了，这个网上有很多教这个的，在这里就不赘述了。

# 备份原来电脑上的内容

```bash
git init  #初始化git仓库
git remote add origin git@github.com:kkonglb/hexo-blog.git  #最后这个是自己github仓库的ssh路径

# 下面是上传的三个命令
git add .#添加修改到缓存区
git commit -m "<自己写注释>"
git push origin master:main  #其中前一个master是本地的分支，main是github上自己想要上传的分支
```

其中可以把最后三个简化一下，用一个shell文件来执行，这个里面的内容不懂得可以问一下AI，都是比较基础的。然后新建一个push.sh文件把下面的内容放进去。在终端中输入./push.sh就可以一键上传到github仓库了，不过是之前的操作无误的前提下。

```shell
#!/bin/sh
# 本脚本请在git bash中运行
# 作者：Konglb
# 在终端输入 ./push.sh 即可打开脚本
# 博客：https://konglb.top

echo -e "\033[32m正在为你备份博客中.........\033[0m"
git add .
# 获取当前时间
current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo -e "\033[32m正在为你备份博客中.........\033[0m"
git commit -m "$current_time"
echo -e "\033[32m正在为你备份博客中.........\033[0m"
git push origin master:main 
if [ $? -ne 0 ]; then
    echo -e "\033[31m 备份失败！请检查网络情况！ \033[0m"
else
    echo -e "\033[32m恭喜你！已为你备份到你的GitHub仓库 backup \033[0m"
fi

```

  上传到github仓库上时有些内容没有上传上去，这是因为hexo将这些文件添加到了.gitignore里面，这些本来就没必要上传，所以不用在意。

  但是需要注意的是（我当时犯的错误）主题文件夹如我的是butterfly文件夹，这个里面可能会自带.git文件，这个必须删掉，不然上传的时候也无法上传上去。具体的原因可以自己搜一下。~~这个当时给我害死了~~[git clone 含有子模块的项目](https://blog.csdn.net/hujin2017/article/details/99432167)

# hexo博客如何迁移到新电脑

## 安装hexo环境

- [nodejs](https://nodejs.org/zh-cn/)

- [git](https://www.gitclone.com/docs/feature/github_git)

- [vscode](https://code.visualstudio.com/)   这个安不安装都行，我一般习惯直接在vscode中操作博客文件夹和执行git bash命令。

```shell
npm install -g cnpm --registry=https://registry.npmmirror.com#安装cpnm，npm的镜像源，可有可无，npm慢的话可以试一下这个
```

```shell
npm install hexo-cli -g #全局安装hexo
```

## 配置ssh密钥

- 生成 SSH 公钥
  - `ssh-keygen -t rsa`
  - 不断回车
    - 如果公钥已经存在，则自动覆盖
- 命令介绍
  - `ssh-keygen` 是生成 SSH 密钥对的工具。
  - `-t rsa` 指定了密钥的类型为 RSA（即使用 RSA 算法生成公钥和私钥）。
  - 行该命令后，会生成一对公钥和私钥，默认存储在 `~/.ssh/id_rsa` 和 `~/.ssh/id_rsa.pub` 文件中。私钥（`id_rsa`）用于身份验证，而公钥（`id_rsa.pub`）则可以被添加到远程服务器（如 GitHub、GitLab、服务器等）上的授权密钥列表中，以便安全地进行无密码登录或操作。
- Gitee 设置账户共公钥
  - 获取公钥
    - `cat ~/.ssh/id_rsa.pub`== 本地生成的 SSH 公钥和私钥默认存储在 **用户主目录的 .ssh 文件夹** 中 ==
  - 刚才![](./image-20250202184141115.png)![image-20250202184236309](./image-20250202184236309.png)
  - 验证是否配置成功
    - `ssh -T git@gitee.com`

## git clone 仓库ssh地址

![image-20250202184458596](./image-20250202184458596.png)

```shell
git clone <仓库ssh地址>
```

克隆完仓库之后我们也可以先修改一下文件名，然后进入到文件夹里面进行操作

## npm install

执行`npm install`安装相关依赖项，这里我们提过。会生成node_modlues文件夹还有其他依赖项。

好像还有要再安装一遍hexo的部署插件，这个我忘了是不是必须的，但是弄一遍总是没啥问题的。

`npm install --save hexo-deployer-git`

到此就结束了，然后就是`hexo cl&&hexo g&&hexo d`丝滑连招推送到github上去。

# 参考

- [Hexo博客迁移到新电脑](https://blog.csdn.net/qq_43698421/article/details/120407042)

+   [GitHub+Hexo 搭建个人网站详细教程](https://zhuanlan.zhihu.com/p/26625249)
+   [使用hexo，如果换了电脑怎么更新博客？](https://www.zhihu.com/question/21193762)
