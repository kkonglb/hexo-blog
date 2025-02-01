---
title: Meet in the middle
date: 2024年11月27日 22:35:24
categories:
- 算法
tags:
- 算法
---

# Meet in the middle

oiwiki上的内容,具体可以看这个网址   https://oi-wiki.org/search/bidirectional/

## P2962 [USACO09NOV] Lights G

[https://www.luogu.com.cn/problem/P2962](https://www.luogu.com.cn/problem/P2962)

```cpp
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
    map<ll,int>mp;
    vector<ll>a(40);
    a[0]=1;
    for(int i=1;i<40;i++)a[i]=a[i-1]<<1;
    for(int i=1;i<=m;i++)
    {
        int u,v;
        cin>>u>>v;
        u--,v--;
        a[u]|=(1ll<<v);
        a[v]|=(1ll<<u);
    }    
    for(int i=0;i<(1<<(n/2));i++)
    {
        int cnt=0;
        ll t=0;
        for(int j=0;j<n/2;j++)
        {
            if((i>>j)&1)
            {
                cnt++;
                t^=a[j]; 
            }
        }
        if (!mp.count(t))mp[t] = cnt;
        else
        mp[t] = min(mp[t], cnt);
    }
    int ret=inf;
    for(int i=0;i<(1<<(n-n/2));i++)//这一步很妙,把状态前移
    {
        int cnt=0;
        ll t=0;
        for(int j=0;j<(n-n/2);j++)
        {
            if((i>>j)&1)
            {
                cnt++;
                t^=a[j+n/2];
            }
        }
        if(mp.contains(((1ll<<n)-1)^t))ret=min(ret,cnt+mp[((1ll<<n)-1)^t]);
    }
    cout<<ret<<"\n";
    return 0;    
}
```

## P1466 [USACO2.2] 集合 Subset Sums

[https://www.luogu.com.cn/problem/P1466](https://www.luogu.com.cn/problem/P1466)

这一题可以直接用动态规划进行解决,同时因为数据范围比较特殊,也可以使用Meet in the middle

```cpp
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
    int n;
    cin>>n;
    ll sum=1ll*n*(n+1)/2;
    if(sum&1)return cout<<0<<'\n',0;
    sum/=2;
    vector<ll>dp(sum+1);
    dp[0]=1;
    for(int i=1;i<=n;i++)
    {
        for(int j=sum;j>=i;j--)
        {
            dp[j]+=dp[j-i];
        }
    }    
    cout<<dp[sum]/2<<'\n';

    return 0;    
}
```

```cpp
// 附上洛谷上别人写的Meet in the middle解法
#include<cstdio>
typedef long long LL;
const int M=1e3+5;
LL b[M];
int n;
LL ans;
int main(){
    scanf("%d",&n);
    if(((1+n)*n/2)&1)puts("0");
    else{
        for(int i=0;i<(1<<(n/2));++i){
            int cur=0;
            for(int j=0;(i>>j)>0;++j)if((i>>j)&1)cur+=(j+1);
            b[cur]++;
        }
        for(int i=0;i<(1<<(n-n/2));++i){
            int cur=0;
            for(int j=0;(i>>j)>0;++j)if((i>>j)&1)cur+=j+n/2+1;
            if((1+n)*n/4>=cur)
            ans+=b[(1+n)*n/4-cur];
        }
        printf("%lld\n",ans/2);
    }
    return 0;
}
```

