---
title: AtCoder Beginner Contest 395
tags:
  - 技能积累
categories:
  - 技能积累
date: 2025-03-21 15:42:43
---

[https://atcoder.jp/contests/abc395](https://atcoder.jp/contests/abc395)

[https://www.bilibili.com/video/BV1vE98YDEXA/?vd_source=6759ab7a746b50893c564c06fbc6a752](https://www.bilibili.com/video/BV1vE98YDEXA/?vd_source=6759ab7a746b50893c564c06fbc6a752)

 # **C - Shortest Duplicate Subarray**

[https://atcoder.jp/contests/abc395/tasks/abc395_c](https://atcoder.jp/contests/abc395/tasks/abc395_c)

这一题很简单

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin>>n;    
    map<int,int>mp;
    int ans=INT_MAX;
    for(int i=1;i<=n;i++)
    {
        int x;
        cin>>x;
        if(mp.contains(x))
        {
            ans=min(ans,i-mp[x]+1);
            mp[x]=i;
        }
        else 
        {
            mp[x]=i;
        }
    }
    cout<<(ans==INT_MAX?-1:ans)<<'\n';
    return 0;    
}
```

# **D - Pigeon Swap**

[https://atcoder.jp/contests/abc395/tasks/abc395_d](https://atcoder.jp/contests/abc395/tasks/abc395_d)

这一题用了偷懒的方法，在步骤二中直接切换两个鸽子笼的编号。

平常没做过这种题，即使想出来了在实现的时候也遇到了很多困难，把自己绕进去好几次。

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin>>n;    
    map<int,int>mp;
    int ans=INT_MAX;
    for(int i=1;i<=n;i++)
    {
        int x;
        cin>>x;
        if(mp.contains(x))
        {
            ans=min(ans,i-mp[x]+1);
            mp[x]=i;
        }
        else 
        {
            mp[x]=i;
        }
    }
    cout<<(ans==INT_MAX?-1:ans)<<'\n';
    return 0;    
}
```

# **E - Flip Edge**

[https://atcoder.jp/contests/abc395/tasks/abc395_e](https://atcoder.jp/contests/abc395/tasks/abc395_e)

非常标准的双层图，建图之后直接跑dijkstra就行了。

但是一般都是多开一维数组，根据当前状态去走。不然层数多状态多的话根本无法存下所有的边。

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
int n,m,x;
const int N=2e5+10;
vector<pair<int,int>>adj[2*N];
int dis[2*N];
bool vis[2*N];
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cin>>n>>m>>x;
    for(int i=1;i<=m;i++)
    {
        int u,v;
        cin>>u>>v;
        adj[u].push_back({v,1});
        adj[v+n].push_back({u+n,1});
    }
    for(int i=1;i<=n;i++)
    {
        adj[i].push_back({i+n,x});
        adj[i+n].push_back({i,x});
    }
    fill(begin(dis),end(dis),LLONG_MAX);
    dis[1]=0;
    priority_queue<pair<int,int>,vector<pair<int,int>>,greater<>>pq;
    pq.push({0,1});
    while(pq.size())
    {
        auto [_,u]=pq.top();
        pq.pop();
        if(vis[u])continue;
        vis[u]=1;
        for(auto [v,w]:adj[u])
        {
            if(dis[u]+w<dis[v])
            {
                dis[v]=dis[u]+w;
                pq.push({dis[v],v});
            }
        }
    }
    cout<<min(dis[n],dis[2*n])<<'\n';



    return 0;    
}
```





