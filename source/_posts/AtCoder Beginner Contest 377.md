---
title: AtCoder Beginner Contest 377
date: 2024年11月27日 22:35:48
categories:
- AtCoder刷题
tags:
- AtCoder
---

# AtCoder Beginner Contest 377

## D - Many Segments 2

[https://atcoder.jp/contests/abc377/tasks/abc377_d](https://atcoder.jp/contests/abc377/tasks/abc377_d)

创建一个dp数组，dp[i]为第i个位置右边第一个区间的右边界。题中给了n组l和r，对于l来说,dp[l]=r;对于其他位置来说，从右往左传递状态，dp[i]=min(dp[i],dp[i+1])，然后对于每一个位置l来说，r所能到达的最右边的位置就是dp[l]-1，所以对于每一个l来说，有dp[l]-l个区间。

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
    int n,m;
    cin>>n>>m;
    vector<int>dp(m+1,m+1);
    for(int i=1;i<=n;i++)
    {
        int l,r;
        cin>>l>>r;
        dp[l]=min(dp[l],r);
    }    
    for(int i=m-1;i>=1;i--)
    {
        dp[i]=min(dp[i],dp[i+1]);
    }
    ll cnt=0;
    for(int i=1;i<=m;i++)
    {
        cnt+=(dp[i]-i);
    }
    cout<<cnt<<'\n';

    return 0;    
}
```

## E - Permute K times 2

[https://atcoder.jp/contests/abc377/tasks/abc377_e](https://atcoder.jp/contests/abc377/tasks/abc377_e)

原始置换是A,

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
ll power(ll x,ll y,int mod)
{
    ll ret=1;
    while(y)
    {
        if(y&1)ret=ret*x%mod;
        x=x*x%mod;
        y>>=1;
    }
    return ret;
}
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    ll k;
    cin>>n>>k;
    vector<int>p(n+1);
    for(int i=1;i<=n;i++)cin>>p[i];
    vector<bool>vis(n+1);
    for(int i=1;i<=n;i++)
    {
        if(vis[i])continue;
        vector<int>a;
        int j=i;
        while(!vis[j])
        {
            vis[j]=1;
            a.push_back(j);
            j=p[j];
        }
        int d=power(2,k,a.size());
        for(int x=0;x<a.size();x++)
        {
            p[a[x]]=a[(x+d)%a.size()];
        }
    }    
    for(int i=1;i<=n;i++)cout<<p[i]<<" \n"[i==n];
    return 0;    
}
```

## F - Avoid Queen Attack 

[https://atcoder.jp/contests/abc377/tasks/abc377_f](https://atcoder.jp/contests/abc377/tasks/abc377_f)

这一题主要是有四部分，横（Row)，竖（Line)，对角线（D)，反对角线（E)

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

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    ll ans=1ll*n*n;
    set<int>R,C,D,E;
    for(int i=1;i<=m;i++)
    {
        int a,b;
        cin>>a>>b;
        R.insert(a);
        C.insert(b);
        D.insert(a-b);
        E.insert(a+b);
    }    
    ans-=1ll*R.size()*n;// 首先把这四部分直接减掉
    ans-=1ll*C.size()*n;
    for(auto d:D)
    {
        ans-=n-abs(d);
    }
    for(auto e:E)
    {
        ans-=n-abs(n+1-e);
    }
    for(auto r:R)然后分别依次减掉与其他部分重合的地方
    {
        set<array<int,2>>s;
        for(auto c:C)
        {
            s.insert({r,c});
        }
        for(auto d:D)
        {
            int c=r-d;
            if(1<=c&&c<=n)
            {
                s.insert({r,c});
            }
        }
        for(auto e:E)
        {
            int c=e-r;
            if(1<=c&&c<=n)
            {
                s.insert({r,c});
            }
        }
        ans+=s.size();
    }
    for(auto c:C)
    {
        set<array<int,2>>s;
        for(auto d:D)
        {
            int r=c+d;
            if(1<=r&&r<=n)
            {
                s.insert({r,c});
            }
        }
        for(auto e:E)
        {
            int r=e-c;
            if(1<=r&&r<=n)
            {
                s.insert({r,c});
            }
        }
        ans+=s.size();
    }
    for(auto d:D)
    {
        set<array<int,2>>s;
        for(auto e:E)
        {
            if((1ll*d+e)%2)continue;
            int r=(1ll*d+e)/2;
            int c=(1ll*e-d)/2;
            if(1<=r&&r<=n&&1<=c&&c<=n)s.insert({r,c});
        }
        ans+=s.size();
    }
    cout<<ans<<'\n';
    return 0;    
}
```

## Edit to Match

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
const int N=2e5+10;
int Trie[N][26];
int dix;
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin>>n;
    vector<int>dis(N+1,inf);
    for(int i=1;i<=n;i++)
    {
        string s;
        cin>>s;
        int p=0;
        int ans=s.size();
        for(int j=0;j<s.size();j++)
        {
            int &q=Trie[p][s[j]-'a'];
            if(!q)q=++dix;
            p=q;
            ans=min(ans,(int)s.size()-1-j+dis[p]);
        }
        p=0;
        for(int j=0;j<s.size();j++)
        {
            p=Trie[p][s[j]-'a'];
            dis[p]=min(dis[p],(int)s.size()-1-j);
        }
        cout<<ans<<'\n';
    }    

    return 0;    
}
```



