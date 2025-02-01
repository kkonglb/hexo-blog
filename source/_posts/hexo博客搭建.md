---
title: hexo博客搭建
date: 2024-11-17 23:34:32
categories:
- 技能积累
tags:
- hexo
---

[hexo](https://github.com/hexojs/hexo)

[hexo文档](https://hexo.io/zh-cn/docs/index.html)

[butterfly](https://github.com/jerryc127/hexo-theme-butterfly)

[butterfly文档](https://butterfly.js.org/)

# hexo博客搭建

## 配置的前提条件

### git

[https://git-scm.com/](https://git-scm.com/)

git的安装也比较简单。我们安装这个主要使用的就是其中的命令行工具git bash。

就是这个玩意。这里建议使用管理员身份打开，会省去一些麻烦

![image-20250121212202128](./image-20250121212202128.png)

Git Bash：Git提供的命令行工具  ==相当于一个小的linux窗口，使用shift+鼠标右键可以直接找到，不用选择更多选项==

使用git之前需要设置一下用户信息，这里我之前已经配置过了，所以就没有在进行尝试。



1. 打开Git Bash
2. 设置用户信息
   `git config --global user.name “itcast”`
   `git config --global user.email “hello@itcast.cn”`

查看配置信息
`git config --global user.name`
`git config --global user.email`

效果如下

![img](./image-20241117111134790.png)

### Node.js

[nodejs.org](nodejs.org)

这个下载直接下载，安装直接一直点next就行了 

![img](./image-20241117110020395.png)

安装过nodejs之后应该就可以直接通过终端调用nodejs和里面的npm，这篇文章我使用的都是git bash来进行命令行操作（下面会提到）。

分别输入`node -v`和`npm -v`看看是否配置成功，显示如下所示的版本号就是成功了。如果没有配置成功就自己配置一下环境变量或者重新安装一下，实在不行就看一下自己之前是否有老版本的nodejs，删了试一下。（这里就不多加赘述）

![img](./image-20241117110337580.png)

### git bash的一些简单命令

考虑到有些朋友没有怎么接触过命令行，这里附加一些下面用到和可能需要的命令行

`pwd`  查看当前目录

`mkdir blog` 在当前目录生成blog文件夹，这里并不是必须得写blog，只是一个示范而已

`cd` 切换目录

`ls -l` 列出目录中的文件和子目录信息

`Ctrl + C`  终端快捷键，通常用来中断或停止当前正在运行的进程或命令。

`cd ..` 跳到上一级目录

`cd ../..` 跳到上面第二级目录

### 具体功能

1. **终端中断**

## hexo搭建步骤

首先我们的这些操作都需要基于刚才提到的npm（包管理器）进行，但是由于这个在国内的速度比较慢，我们可以使用npm先安装一个国内淘宝的镜像源，如果你安装成功了，下面我所演示的所有步骤中的npm你都可以用cnpm来取代（~~因为我失败了，所以我直接用的npm~~）

git bash默认打开是在C盘的，当然你如果是在某个文件夹中直接右键打开的话那就直接在当前文件夹。

我习惯把东西都安装到D盘，所以下面就先切换到D盘进行操作了

### 打开git bash并且切换到D盘

![img](./image-20241117114110975.png)

### 初始化hexo

`hexo init` 初始化hexo，如果成功的话最后一行会显示“Start blogging with Hexo!"

![img](./image-20241117163950755-1737466647456-17.png)

### 本地运行博客

#### start hexo

启动hexo之后会如图所示有一个网址，这个网址是在本地的。

![image-20250121213846636](./image-20250121213846636.png)

输入网址打开之后效果如图所示

![img](./image-20241117164615714.png)

#### 断开接口

按ctrl+c断开，咱们上一步是start hexo，这一步是断开hexo。

这两步的作用就是我们对自己的hexo博客做出修改之后可以现在本地的这个接口自己看一眼，如果觉得不错的话，就断开进行接下来的步骤，把所进行的修改推送到自己托管的网站如github或者gitee之类的。

![image-20250121213913124](./image-20250121213913124.png)

### 如何写博客

`hexo new "文章名"`  这样就能新建一篇博客，这张截图上也显示了自己的博客创建在那个位置了，默认是在`blog/source/posts/`里面的。

![image-20250121213917705](./image-20250121213917705.png)

我们目前是在`blog`，想要进入这个博客目录看一眼需要往里进两级目录，如图所示就能进入了。

![image-20250121213920863](./image-20250121213920863.png)

`ls -l`看一眼确实是有两个博客，一个是默认创建的hello world博客，另一个就是我们刚创建的一篇博客。

![image-20250121213923191](./image-20250121213923191.png)	

想要修改的话就直接打开修改或者用自带的vim编辑器修改也行。

![image-20250121213926310](./image-20250121213926310.png)

这样就能进入vim编辑器进行修改了，怎么修改我就不管了，但是因为我们建的这种博客都是markdown格式的，个人感觉还是用typora或者vscode这种编辑器进行修改比较舒服一点。

![img](./image-20241117170500983.png)

推出vim编辑器的话就先按Esc，然后输入`:wq`回车就能退出了，==**wq是write和quit，保存并退出的意思**==，

![image-20250121213930460](./image-20250121213930460.png)

刚才我们进入到博客那一个目录下，现在我们要退回去，直接`cd ../..`连续回退两级目录。

![image-20250121213933362](./image-20250121213933362.png)

### 如何把博客部署到github上去

#### 创建一个仓库

仓库命名必须如图所示，仓库名字必须是这样的{username}.github.io

![img](./image-20241117171230685.png)

然后我们要安装一个支持git的hexo的部署插件`npm install --save hexo-deployer-git`\

再次友情提示，所有步骤都可能特别慢，我这一步4min才弄完

![image-20250121213940108](./image-20250121213940108.png)

#### 编辑 _config.yml文件_

![image-20250121213942540](./image-20250121213942540.png)

最下面这个deploy这一部分按照图中所示进行修改，第二个repo就填自己刚才新建的仓库的网址+`.git`

![image-20250121213959566](./image-20250121213959566.png)

#### 部署

- hexo clean //清除缓存
- hexo g //生成静态文件
- hexo d //部署

 这三步连着走就行了，如果想要简化的话可以直接`hexo clean && hexo g && hexo d`然后我们就发现我们的github仓库有东西了

![img](./image-20241117180800765.png)

## 更换hexo主题

我选择的是这个github上的yilia主题，可以自己直接使用git clone或者下载之后放进去就行了

[https://github.com/litten/hexo-theme-yilia](https://github.com/litten/hexo-theme-yilia)

![img](./image-20241117184457760.png)

再次打开_config.yml找到这个theme然后修改成yilia就行了_

![image-20250121214028252](./image-20250121214028252.png)

![](https://cdn.jsdelivr.net/gh/kkonglb/image/222.png

然后剩下的就是就是上一步讲的部署的三步了

- hexo clean //清除缓存

- hexo g //生成静态文件

- hexo d //部署


这样就能修改成功了，不过在部署之前也可以hexo s现在本地先看一眼效果

![img](./image-20241117184457760-1737466849086-27.png)

## 我的博客

最后附上我自己的博客 [https://www.konglb.top/](https://www.konglb.top/)(我这个是用的我自己的域名)

以后会增加留言板功能，如果有问题的话可以留言一起讨论一下。🥳🥳🥳

![image-20250121214131222](./image-20250121214131222.png)
