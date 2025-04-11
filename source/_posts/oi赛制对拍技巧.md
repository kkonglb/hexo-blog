---
title: oi赛制对拍技巧
tags:
  - 技能积累
categories:
  - 技能积累
date: 2025-03-20 16:51:16
---

# 方法一

我们创建四个cpp文件

- quick.cpp  // 存放自己开始写的代码
- slow.cpp // 存放自己觉得一定对但是速度慢的代码
- data.cpp // 利用随机数等手段随机生成数据
- duipai.cpp //对拍

```cpp
// quick.cpp
#include<bits/stdc++.h>
using namespace std;
int main()
{
	int a,b;
	cin>>a>>b;
	if(a==1)cout<<1;
	cout<<a+b<<endl;	
}
```

```cpp
// slow.cpp
#include<bits/stdc++.h>
using namespace std;
int main()
{
	int a,b;
	cin>>a>>b;
	int sum=0;
	for(int i=1;i<=a;i++)sum++;
	for(int i=1;i<=b;i++)sum++;
	cout<<sum<<'\n';	
}
```

```cpp
#include<bits/stdc++.h>
using namespace std;
int main()
{
	srand(time(0));
	cout<<rand()%100<<' '<<rand()%100<<'\n';
	return 0;	
}
```

```cpp
#include<bits/stdc++.h>
using namespace std;
int main()
{
	int t=0;
	while(1)
	{
		cout<<"test: "<<t++<<endl;
		system("data.exe > data.in");//调用 data.exe 生成随机输入数据，并将输出重定向到 data.in 文件。
		// 将 data.in 作为输入，分别运行 slow.exe和 quick.exe
		// 结果分别输出到 slow.out 和 quick.out
		system("slow.exe < data.in > slow.out");
		system("quick.exe < data.in > quick.out");
        // 这个如果是linux的话是diff,如果是windows的话就是fc	
		if(system("diff slow.out quick.out > diff.log"))
		{
			cout<<"WA\n";
			break;
		}
		cout<<"AC\n";
	}
}
```



