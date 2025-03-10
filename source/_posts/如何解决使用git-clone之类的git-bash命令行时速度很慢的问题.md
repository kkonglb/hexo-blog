---
title: 如何解决使用git clone之类的git bash命令行时速度很慢的问题
date: 2024-12-01 10:29:49
categories:
- 技能积累
tags:
- git
---

# 出现的问题

我们平常使用git clone用来克隆github仓库时会出现速度很慢的问题，有时候不仅速度很慢，而且还可能会直接失败，可是我们已经开启代理了，直接访问github也十分的流畅，但就是使用git bash时就一直出问题。这是因为虽然我们已经开启代理了，但是git是没有开启代理的，我们需要自己设置。

# 解决方法

看这两篇文章应该就够了。这两篇看懂了就不需要看下面的了，下面的都是我随便写的一点

[关于git配置代理的方法和一些需要注意的细节](https://blog.csdn.net/weixin_45685193/article/details/120606369)

[在windows中如何查看代理的地址和端口](https://blog.csdn.net/qq_55888300/article/details/131498092)

[设置代理解决github被墙](https://zhuanlan.zhihu.com/p/481574024)

看代理IP地址和端口这样也可以

在设置里搜索 代理 找到自己的这两项（前提是自己必须有代理），在代理中其实也可以直接找到这个端口，应该设置里面都有，可以自己看一下。

![img](./image-20241201103720668.png)

总结一下就是我们上面输入的命令行操作其实就是为了修改[用户目录].gitconfig中的内容。

可以直接`cat ~/.gitconfig`看看成功了没	

![image-20250121214715901](./image-20250121214715901.png)

看来是成功了，那个lowspeedlimit和lowspeedtime不用管，忘了是什么时候设置的了。

# ssh-error


[解决方案](https://gist.github.com/Tamal/1cc77f88ef3e900aeae65f0e5e504794#file-git-ssh-error-fix-sh)
问题
$ ssh -T git@github.com
ssh: connect to host github.com port 22: Connection timed out

````bash
$ git clone git@github.com:xxxxx/xxxx.git my-awesome-proj
Cloning into 'my-awesome-proj'...
ssh: connect to host github.com port 22: Connection timed out
fatal: Could not read from remote repository.

$ # This should also timeout
$ ssh -T git@github.com
ssh: connect to host github.com port 22: Connection timed out

$ # but this might work
$ ssh -T -p 443 git@ssh.github.com
Hi xxxx! You've successfully authenticated, but GitHub does not provide shell access.
$ # Override SSH settings
$ vim ~/.ssh/config
```
# Add section below to it
Host github.com
  Hostname ssh.github.com
  Port 443
```
$ ssh -T git@github.com
Hi xxxxx! You've successfully authenticated, but GitHub does not
provide shell access.

$ git clone git@github.com:xxxxxx/xxxxx.git my-awesome-proj
Cloning into 'my-awesome-proj'...
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (15/15), done.
remote: Compressing objects: 100% (14/14), done.
remote: Total 15 (delta 0), reused 15 (delta 0), pack-reused 0
Receiving objects: 100% (15/15), 22.90 KiB | 4.58 MiB/s, done.
````

