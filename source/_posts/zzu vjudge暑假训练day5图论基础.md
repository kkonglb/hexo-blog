---
title: zzu vjudge暑假训练day5:图论基础
date: 2024年11月27日 22:34:54
tags:
---

# zzu vjudge暑假训练day5:图论基础

## A 查找文献
[https://www.luogu.com.cn/problem/P5318](https://www.luogu.com.cn/problem/P5318)

## B - 图的遍历

[https://www.luogu.com.cn/problem/P3916](https://www.luogu.com.cn/problem/P3916)

==这一题总共做过两遍，第一次的时候从1开始正向dfs没有做出来也不知道哪里错了，后来看了题解学会了反向dfs，第二次想着用正向dfs做一下但是还是失败了，但是已经清除是错在哪里了，现在分享一下正确的做法和错误的思路==

**这个是正确做法**

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
using ll = long long;
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<vector<int>>adj(n+1);
    for(int i=1;i<=m;i++)
    {
        int a,b;
        cin>>a>>b;
        adj[b].push_back(a);// 反向建边，从n到1进行dfs
    }    
    vector<int>ans(n+1);
    iota(ans.begin(),ans.end(),0);// 这个函数是从0开始递增赋值，因为一个数其本身也是他能到达的数字
    vector<bool>vis(n+1);
    auto dfs=[&](auto self,int u,int shu)->int{
        vis[u]=1;
        ans[u]=max(ans[u],shu);
        for(auto v:adj[u])
        {
            if(vis[v])continue;// 遇到已经染色的就跳过，因为之前染色的数值一定比现在的大
            self(self,v,shu);
        }
        return ans[u];
    };
    for(int i=n;i>=1;i--)if(!vis[i])dfs(dfs,i,i);// 从n开始，将能走到的地方逐步染色，接着n-1，直到1。
    for(int i=1;i<=n;i++)cout<<ans[i]<<" \n"[i==n];

    return 0;    
}
```

**这个是正向dfs，如果同样是用正向dfs做的但是不知道哪里错的可以看一下接下来这组数据**

```
3 3
1 2 
2 1 
1 3



```

从1开始dfs，到2的时候更新2,2又用1来更新自己，但是此时1的dfs并没有走完，1并没有走到3，所以ans[2]的更新后的结果是2，

正确结果 3 3 3 

错误结果 

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
using ll = long long;
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<vector<int>>adj(n+1);
    vector<int>ans(n+1),vis(n+1);
    for(int i=1;i<=m;i++)
    {
        int a,b;
        cin>>a>>b;
        adj[a].push_back(b);
    }    
    iota(ans.begin(),ans.end(),0);
    auto dfs=[&](auto self,int u)->int{
        vis[u]=1;
        for(auto v:adj[u])
        {
            if(vis[v])
            {
                ans[u]=max(ans[u],ans[v]);
                continue;
            }
            ans[u]=max(ans[u],self(self,v));
        }
        return ans[u];
    };
    for(int i=1;i<=n;i++)if(!vis[i])dfs(dfs,i);
    for(int i=1;i<=n;i++)cout<<ans[i]<<" \n"[i==n];
    return 0;    
}
```

