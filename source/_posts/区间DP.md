---
title: 区间DP
date: 2024年11月27日 22:32:47
categories:
- 算法学习
tags:
- 算法
---

# 区间DP  O(n^3)

区间DP一般给的N的范围都会比较小，在我看来区间DP是一个比较宽泛的概念，刚开始只做了第二题石子合并，对区间DP理解的比较浅显，现在看来区间DP所共有的特点就是`dp[i][j]`所表示的i到j这个区间的一个值

## P1063 [NOIP2006 提高组] 能量项链

https://www.luogu.com.cn/problem/P1063

正整数 N（4≤N≤100）

正常的一道环形区间DP，每个变量存一下头标记和尾标记就行了

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
    int n;
    cin>>n;
    vector<pair<int,int>>v(2*n+1);
    vector<vector<int>>f(2*n+1,vector<int>(2*n+1,-inf/2)),g(2*n+1,vector<int>(2*n+1));
    for(int i=1;i<=n;i++)
    {
        cin>>v[i].first;
        v[i+n].first=v[i].first;
    }    
    for(int i=1;i<=2*n;i++)
    {
        v[i].second=v[i%n+1].first;
        f[i][i]=0;
        g[i][i]=0;
    }
    for(int len=2;len<=n;len++)// 区间长度
    {
        for(int i=1;i+len-1<=2*n;i++)// 起始位置
        {
            int j=i+len-1;// 末位置
            for(int k=i;k<j;k++)// 切割位置
            {
                f[i][j]=max(f[i][j],f[i][k]+f[k+1][j]+v[i].first*v[k].second*v[j].second);
            }
        }
    }
    int maxn=-inf;
    for(int i=1;i<=n;i++)// 枚举区间
    {
        maxn=max(maxn,f[i][i+n-1]);
    }
    cout<<maxn<<'\n';

    return 0;    
}
```

## P1880 [NOI1995] 石子合并

https://www.luogu.com.cn/problem/P1880

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
    int n;
    cin>>n;
    vector<int>a(2*n+1);
    vector<vector<int>>f(2*n+1,vector<int>(2*n+1,inf/2)),g(2*n+1,vector<int>(2*n+1,-inf/2));
    vector<ll>prev(2*n+1);
    for(int i=1;i<=n;i++)
    {
        cin>>a[i];
        a[i+n]=a[i];
    }
    for(int i=1;i<=2*n;i++)
    {
        prev[i]+=prev[i-1]+a[i];
        f[i][i]=0;
        g[i][i]=0;
    }
    for(int len=2;len<=n;len++)
    {
        for(int i=1;i+len-1<=2*n;i++)
        {
            int j=i+len-1;
            for(int k=i;k<j;k++)
            {
                f[i][j]=min(1LL*f[i][j],f[i][k]+f[k+1][j]+prev[j]-prev[i-1]);
                g[i][j]=max(1LL*g[i][j],g[i][k]+g[k+1][j]+prev[j]-prev[i-1]);
            }
        }
    }
    int minn=inf,maxn=-inf;
    for(int i=1;i<=n;i++)
    {
        minn=min(minn,f[i][i+n-1]);
        maxn=max(maxn,g[i][i+n-1]);
    }
    cout<<minn<<'\n'<<maxn<<'\n';
    return 0;    
}
```




## P1005 [NOIP2007 提高组] 矩阵取数游戏

https://www.luogu.com.cn/problem/P1005

高精度太难写了，只好现学python了 :cry:

- 求n行最大得分和，每一行取数又不会影响到其他行，那么只要确保每一行得分最大，管好自家孩子就行了。（这个在动规中叫**最优子结构**）
- 每次取数是在边缘取，那么每次取数完剩下来的元素一定是在一个完整的一个区间中，又是求最优解，**区间DP**应运而生。

```python
n,m=map(int,input().split())
a = [0]*(m+2)// 创建以为数组
dp = [[0] * (m+2) for _ in range(m+2)]创建二维数组
ans=0
for t in range(1,n+1):
    for i in range(m+2):
        for j in range(m+2):
            dp[i][j]=0
    a[1:m+1]=list(map(int,input().split()))
    for i in range(1,m+1):
        for j in reversed(range(i,m+1)):// 这个必须要反着来，从外wang'li
            dp[i][j]=max(dp[i][j],dp[i-1][j]+pow(2,m-j+i-1)*a[i-1])// 这个pow其实可以预处理一下
            dp[i][j]=max(dp[i][j],dp[i][j+1]+pow(2,m-j+i-1)*a[j+1])    
    maxn=0
    for i in range(1,m+1):  
        maxn=max(maxn,dp[i][i]+pow(2,m)*a[i])
    ans=ans+maxn
print(ans)
```

