---
title: 背包DP
date: 2024年11月27日 22:34:44 
tags:
---

# 背包DP

## 0-1 背包

### P2871 [USACO07DEC] Charm Bracelet S

[https://www.luogu.com.cn/problem/P2871](https://www.luogu.com.cn/problem/P2871)

```cpp
// 这一种是01背包的朴素写法
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<vector<int>>dp(n+1,vector<int>(m+1));
    for(int i=1;i<=n;i++)
    {
        int v,w;
        cin>>v>>w;
        for(int j=1;j<=m;j++)
        {
            if(j>=v)dp[i][j]=max(dp[i-1][j],dp[i-1][j-v]+w);
            else dp[i][j]=dp[i-1][j];
        }
    }    
    cout<<dp[n][m]<<'\n';

    return 0;    
}
```



```cpp
// 这一种是01背包的滚动数组写法
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<int>dp(m+1);
    for(int i=1;i<=n;i++)
    {
        int w,d;
        cin>>w>>d;
        for(int j=m;j>=w;j--)
        {
            dp[j]=max(dp[j],dp[j-w]+d);
        }
    }    
    cout<<dp[m]<<'\n';

    return 0;    
}
```

## 完全背包

### P1616 疯狂的采药

[https://www.luogu.com.cn/problem/P1616](https://www.luogu.com.cn/problem/P1616)

```cpp
// 完全背包朴素做法
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int m,n;
    cin>>m>>n;
    vector<vector<ll>>dp(n+1,vector<ll>(m+1));
    for(int i=1;i<=n;i++)
    {
        int v,w;
        cin>>v>>w;
        for(int j=1;j<=m;j++)
        {
            if(j>=v)dp[i][j]=max(dp[i-1][j],dp[i][j-v]+w);
            else dp[i][j]=dp[i-1][j];
        }
    }
    cout<<dp[n][m]<<'\n';
    return 0;    
}
```



```cpp
// 完全背包滚动数组做法
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int m,n;
    cin>>m>>n;
    vector<ll>dp(m+1);
    for(int i=1;i<=n;i++)
    {
        int a,b;
        cin>>a>>b;
        for(int j=a;j<=m;j++)dp[j]=max(dp[j],dp[j-a]+b);
    }    
    cout<<dp[m]<<'\n';
    return 0;    
}
```

## 多重背包

### P1776 宝物筛选

[https://www.luogu.com.cn/problem/P1776](https://www.luogu.com.cn/problem/P1776)

~~这一题很傻鸟~~，他先给的物品的价值，再给的物品的重量，所以要cin>>w>>v>>s;

```cpp
// 多重背包的朴素算法，但是会TLE
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 2147483647;
const ll INF = 1e18;
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;    
    vector<ll>dp(m+1);
    for(int i=1;i<=n;i++)
    {
        int w,v,g;
        cin>>w>>v>>g;
        for(int j=m;j>=v;j--)
        {
            for(int k=1;k<=g;k++)
            {
                if(j>=k*v)dp[j]=max(dp[j],dp[j-k*v]+k*w);
                else break;
            }
        }
    }
    cout<<dp[m]<<'\n';
    return 0;    
}
```



```cpp
// 多重背包的二进制优化
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 2147483647;
const ll INF = 1e18;
struct node
{
    int v,w;
};
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<ll>dp(m+1);
    vector<node>goods;
    for(int i=1;i<=n;i++)
    {
        int w,v,s;
        cin>>w>>v>>s;
        for(int j=1;j<=s;j<<=1)
        {
            s-=j;
            goods.push_back({j*v,j*w});
        }
        if(s)goods.push_back({s*v,s*w});
    }    
    for(auto node:goods)
    {
        for(int j=m;j>=node.v;j--)
        {
            dp[j]=max(dp[j],dp[j-node.v]+node.w);
        }
    }
    cout<<dp[m]<<'\n';
    return 0;    
}
```

## 混合背包

混合背包就是把01背包，完全背包，多重背包合在一起了，如果对前面理解透彻的话这个应该也没有什么问题。

如果是用二维DP数组递推的话，01背包是从左上方递推而来，完全背包是从同一层的左边递推而来，而多重背包则是一种特殊的01背包，由多个符合条件的左上方递推而来，多了一个循环遍历个数而已

### P1833 樱花

[https://www.luogu.com.cn/problem/P1833](https://www.luogu.com.cn/problem/P1833)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    string a,b;
    cin>>a>>b;
    int n;
    cin>>n;
    int zuo=0,you=0;
    if(a.size()==4)zuo=(a[0]-'0')*60+stoi(a.substr(2));
    else zuo=(stoi(a.substr(0,2))*60+stoi(a.substr(3)));
    if(b.size()==4)you=(b[0]-'0')*60+stoi(b.substr(2));
    else you=(stoi(b.substr(0,2))*60+stoi(b.substr(3)));
    int m=you-zuo;
    vector<ll>dp(m+1);
    for(int i=1;i<=n;i++)
    {
        int v,w,s;
        cin>>v>>w>>s;
        if(s==0)
        {
            for(int j=v;j<=m;j++)dp[j]=max(dp[j],dp[j-v]+w);
        }
        else if(s==1)
        {
            for(int j=m;j>=v;j--)dp[j]=max(dp[j],dp[j-v]+w);
        }
        else
        {
            for(int j=m;j>=v;j--)
            {
                for(int k=1;k<=s;k++)
                {
                    if(j>=k*v)dp[j]=max(dp[j],dp[j-k*v]+k*w);
                }
            }
        }
    }
    cout<<dp[m]<<'\n';
    return 0;    
}
```

## 二维费用背包

二维费用背包基本上和一维的01背包是一样的，只不过多开了一个维度而已

### P1855 榨取kkksc03

[https://www.luogu.com.cn/problem/P1855](https://www.luogu.com.cn/problem/P1855)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m,t;
    cin>>n>>m>>t;
    vector<vector<int>>dp(m+1,vector<int>(t+1));
    for(int i=1;i<=n;i++)
    {
        int a,b;
        cin>>a>>b;
        for(int j=m;j>=a;j--)
        {
            for(int k=t;k>=b;k--)
            {
                dp[j][k]=max(dp[j][k],dp[j-a][k-b]+1);
            }
        }
    }    
    cout<<dp[m][t]<<'\n';
    return 0;    
}
```

## 分组背包

分组背包也是从左上角递推过来，只不过这个是由一组中的多个物品分别递推而来，而多重背包是由第i个物品的第k倍递推而来

### P1757 通天之分组背包

[https://www.luogu.com.cn/problem/P1757](https://www.luogu.com.cn/problem/P1757)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 2147483647;
const ll INF = 1e18;
struct node
{
    int v,w;
};
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>m>>n;
    vector<ll>dp(m+1);
    int k=-inf;
    vector<vector<node>>a(n+1);
    for(int i=1;i<=n;i++)
    {
        int v,w,s;
        cin>>v>>w>>s;
        k=max(k,s);
        a[s].push_back({v,w});
    }    
    
    for(int i=1;i<=k;i++)
    {
        for(int j=m;j>=1;j--)
        {
            for(auto [v,w]:a[i])
            {
                if(j>=v)dp[j]=max(dp[j],dp[j-v]+w);
            }
        }
    }
    cout<<dp[m]<<'\n';
    return 0;    
}
```

# 有依赖的背包

## P1064 [NOIP2006 提高组] 金明的预算方案

[https://www.luogu.com.cn/problem/P1064](https://www.luogu.com.cn/problem/P1064)

这一题有一说一感觉也是一种分组背包，只不过需要细分进行讨论而已。因为一个物品的附属物品最多只有两件，所以可以直接枚举进行讨论。

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;
struct node
{
    int v,p,q;
    int jz;
};
int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int m,n;
    cin>>m>>n;
    vector<node>v(n+1);
    vector<vector<int>>adj(n+1);
    vector<ll>dp(m+1);
    for(int i=1;i<=n;i++)
    {
        cin>>v[i].v>>v[i].p>>v[i].q;
        v[i].jz=v[i].v*v[i].p;
        if(v[i].q)adj[v[i].q].push_back(i);
    }    
    for(int i=1;i<=n;i++)
    {
        if(v[i].q)continue;
        for(int j=m;j>=v[i].v;j--)
        {
            dp[j]=max(dp[j],dp[j-v[i].v]+v[i].jz);
            if(adj[i].size()==2)
            {
                if(j>=v[i].v+v[adj[i][0]].v)dp[j]=max(dp[j],dp[j-v[i].v-v[adj[i][0]].v]+v[i].jz+v[adj[i][0]].jz);

                if(j>=v[i].v+v[adj[i][0]].v+v[adj[i][1]].v)dp[j]=max(dp[j],dp[j-v[i].v-v[adj[i][0]].v-v[adj[i][1]].v]+v[i].jz+v[adj[i][0]].jz+v[adj[i][1]].jz);

                if(j>=v[i].v+v[adj[i][1]].v)dp[j]=max(dp[j],dp[j-v[i].v-v[adj[i][1]].v]+v[i].jz+v[adj[i][1]].jz);
                
            }
            else if(adj[i].size()==1)
            {
                if(j>=v[i].v+v[adj[i][0]].v)dp[j]=max(dp[j],dp[j-v[i].v-v[adj[i][0]].v]+v[i].jz+v[adj[i][0]].jz);
            }
        }
        
    }
    cout<<dp[m]<<'\n';
    return 0;    
}
```

