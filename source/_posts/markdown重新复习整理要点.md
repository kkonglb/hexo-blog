---
title: markdown重新复习整理要点
date: 2025-01-31 22:25:46
categories:
- 技能积累
tags:
- 
---

[菜鸟编程](https://www.runoob.com/markdown/md-advance.html)

# markdown重新复习整理要点

## Markdown 标题

## Markdown 段落



Markdown 段落没有特殊的格式，直接编写文字就好，**段落的换行是使用两个以上空格加上回车**。

![img](markdown重新复习整理要点/36A89BDA-A062-4D66-A41B-0EBEE7891AB9.jpg)

当然也可以在段落后面使用一个空行来表示重新开始一个段落。

![img](markdown重新复习整理要点/3F254936-778E-417A-BEF2-467116A55D00.jpg)

不过对于typora来说,默认就是<kbd>enter</kbd>就是开启一个新段落，使用<kbd>shifit</kbd> +<kbd>enter</kbd>是换行

Markdown 可以使用以下几种字体：

```
*斜体文本*
_斜体文本_
**粗体文本**
__粗体文本__
***粗斜体文本***
___粗斜体文本___
~~删除线~~
<u>带下划线文本</u>
[^要注明的文本]
```

以下实例演示了脚注的用法：

```
创建脚注格式类似这样 [^RUNOOB]。

[^RUNOOB]: 菜鸟教程 -- 学的不仅是技术，更是梦想！！！
```

演示效果如下：

![img](markdown重新复习整理要点/md5.gif)

## Markdown 列表

``` 
- [x] //效果如下
```

- [x] 

## Markdown 区块（引用）

 

Markdown 区块引用是在段落开头使用 **>** 符号 ，然后后面紧跟一个**空格**符号：

```
> 区块引用
> 菜鸟教程
> 学的不仅是技术更是梦想
```

显示结果如下：

![img](markdown重新复习整理要点/DFE1124E-BC38-4C12-B7AC-053E560D4C9C-1738334716233-24.jpg)

另外区块是可以嵌套的，一个 **>** 符号是最外层，两个 **>** 符号是第一层嵌套，以此类推：

```
> 最外层
> > 第一层嵌套
> > > 第二层嵌套
```

显示结果如下：

![img](markdown重新复习整理要点/AA0A4A6A-33A7-48C7-971F-73FFC8FE85B0-1738334716234-27.jpg)

### 区块中使用列表

区块中使用列表实例如下：

```
> 区块中使用列表
> 1. 第一项
> 2. 第二项
> + 第一项
> + 第二项
> + 第三项
```

显示结果如下：

![img](markdown重新复习整理要点/E3BF6399-6483-4C7A-8502-AE75E8D66C96.jpg)

### 列表中使用区块

如果要在列表项目内放进区块，那么就需要在 **>** 前添加四个空格的缩进。

列表中使用区块实例如下：

```
* 第一项
    > 菜鸟教程
    > 学的不仅是技术更是梦想
* 第二项
```

显示结果如下：

![img](markdown重新复习整理要点/1B894FB4-53AC-4E2D-BA30-F4AE4DFA8B97.jpg)

- >




## Markdown 代码

如果是段落上的一个函数或片段的代码可以用反引号把它包起来（**`**），例如：

```
`printf()` 函数
```

显示结果如下：

![img](markdown重新复习整理要点/C928FDA3-E0A7-4AFF-AB2A-B3AF44F93DF9.jpg)

你也可以用 **```** 包裹一段代码，并指定一种语言（也可以不指定）：

````
```javascript
$(document).ready(function () {
    alert('RUNOOB');
});
```
````

显示结果如下：

![img](markdown重新复习整理要点/88F52386-2F98-4D7E-8935-E43BECA6D868.jpg)

## Markdown 链接

链接使用方法如下：

```
[链接名称](链接地址)

或者

<链接地址>
```

例如：

```
这是一个链接 [菜鸟教程](https://www.runoob.com)
```

显示结果如下：

![img](markdown重新复习整理要点/49E6CB42-F780-4DA6-8290-DC757B51FB9A.jpg)

直接使用链接地址：

```
<https://www.runoob.com>
```

显示结果如下：

![img](markdown重新复习整理要点/9BFF60A1-DD71-4B63-987B-4665B31C7787.jpg)

### 高级链接

我们可以通过变量来设置一个链接，变量赋值在文档末尾进行：

```
这个链接用 1 作为网址变量 [Google][1]
这个链接用 runoob 作为网址变量 [Runoob][runoob]
然后在文档的结尾为变量赋值（网址）

  [1]: http://www.google.com/
  [runoob]: http://www.runoob.com/
```

显示结果如下：

![img](markdown重新复习整理要点/EC3ED5D2-4F0D-492A-81B3-D485623D1A9E.jpg)

## Markdown 图片

## Markdown 表格

表格直接使用typora右键新建一个表格就行了

## Markdown 高级技巧

### 支持的 HTML 元素

不在 Markdown 涵盖范围之内的标签，都可以直接在文档里面用 HTML 撰写。

目前支持的 HTML 元素有：`<kbd> <b> <i> <em> <sup> <sub> <br>`等 ，如：

```
使用 <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>Del</kbd> 重启电脑
```

输出结果为：

![img](markdown重新复习整理要点/81999271-F914-428D-B7BF-164BDC67CAAC.jpg)
