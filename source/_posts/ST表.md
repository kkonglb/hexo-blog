---
title: ST表
date: 2024年11月27日 22:35:13
categories:
- 算法
tags:
- 算法
---

# ST表

[oiwiki链接](https://oi-wiki.org/ds/sparse-table/)

ST 表（Sparse Table，稀疏表）是用于解决 **可重复贡献问题** 的数据结构。

可重复贡献问题我的理解是区间重复不会影响结果，比如如果求[1,4]区间和[1,4]区间的最大值，实际上还是求[1,4]区间的最大值，但是如果是求和问题，那么[1,4]和[1,4]放在一起就会得出正确结果的两倍。

## P3865 【模板】ST 表 && RMQ 问题

RMQ 是英文 Range Maximum/Minimum Query 的缩写，表示区间最大（最小）值

[https://www.luogu.com.cn/problem/P3865](https://www.luogu.com.cn/problem/P3865)

![img](./image-20241012151116609.png)

![img](./image-20241012151321753.png)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
#define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<vector<int>>dp(n+1,vector<int>(22));
    for(int i=1;i<=n;i++)cin>>dp[i][0];
    for(int len=1;len<=20;len++)
    {
        for(int i=1;(i+(1<<len)-1)<=n;i++)
        {
            dp[i][len]=max(dp[i][len-1],dp[i+(1<<(len-1))][len-1]);
        }
    }
    for(int i=1;i<=m;i++)
    {
        int l,r;
        cin>>l>>r;
        int k=log2(r-l+1);
        cout<<max(dp[l][k],dp[r-(1<<k)+1][k])<<'\n';
    }

    return 0;    
}
```

## 2279. 「SCOI2007」降雨量

[https://www.luogu.com.cn/problem/P2471](https://www.luogu.com.cn/problem/P2471)

一共有4种情况(以下大于小于号皆为比较降雨量)

1. y,x都未知，直接输出maybe

2. y未知,x已知,若y到x中有数>=x，则输出false，否则为maybe

3. y已知,x未知，若y到x中有数>=y,则输出false，否则为maybe

4. y,x都已知，若x>y或y到x中有数>=x,则输出false，否则若y到x中所有年份的降雨量都已知，则输出true，否则输出maybe

```cpp
#include <bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
// #define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    vector<int> a(n + 1), b(n + 1);
    vector<vector<int>>st(n+1,vector<int>(22));
    for (int i = 1; i <= n; i++)
    {
        cin >> a[i] >> b[i];
        st[i][0]=b[i];
    }
    for(int len=1;(1<<len)<=n;len++)
    {
        for(int i=1;i+(1<<len)-1<=n;i++)
        {
            st[i][len]=max(st[i][len-1],st[i+(1<<(len-1))][len-1]);
        }
    }
    auto RMQ=[&](int l,int r)->int{
        if(l>r)return -1e9;// 这里需要注意一下，不然范围出错会发生RE等错误
        if(l>n||r>n)return -1e9;
        int k=log2(r-l+1);  
        return max(st[l][k],st[r-(1<<k)+1][k]);
    };
    int q;
    cin >> q;
    for (int i = 1; i <= q; i++)
    {
        auto func = [&]()// 这个函数是因为当时想直接跳出所有循环，又不太会写所以直接写了个函数然后用return了
        {
            int l, r;
            cin >> l >> r;
            if (l >= r)
            {
                cout << "maybe\n";
                return;
            }
            auto ll = lower_bound(a.begin() + 1, a.end(), l) - a.begin();
            auto rr = lower_bound(a.begin() + 1, a.end(), r) - a.begin();
            bool okl = (a[ll] == l), okr = (a[rr] == r);
            if (!okl && !okr)
            {
                cout << "maybe\n";
                return;
            }
            else if (okl && !okr)
            {
                if(RMQ(ll+1,rr-1)>=b[ll])cout<<"false\n";
                else cout << "maybe\n";
            }
            else if (!okl && okr)
            {
                if(RMQ(ll,rr-1)>=b[rr])cout<<"false\n";
                else cout<<"maybe\n";
            }
            else if (okl && okr)
            {
                if (b[rr] > b[ll])
                {
                    cout << "false\n";
                    return;
                }
                if(RMQ(ll+1,rr-1)>=b[rr]){cout<<"false\n";return;}
                if (rr - ll == r - l)
                    cout << "true\n";
                else
                    cout << "maybe\n";
            }
        };
        func();
    }
    return 0;
}
```

## P2880 [USACO07JAN] Balanced Lineup G

[https://www.luogu.com.cn/problem/P2880](https://www.luogu.com.cn/problem/P2880)

这一题就是用两个ST表分别预处理最大最小值就行了

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
    int n,q;
    cin>>n>>q;
    vector<int>a(n+1);
    vector<vector<int>>dp1(n+1,vector<int>(22)),dp2(n+1,vector<int>(22));
    for(int i=1;i<=n;i++){
        cin>>dp1[i][0];
        dp2[i][0]=dp1[i][0];
    }
    for(int len=1;(1<<len)<=n;len++)
    {
        for(int i=1;i+(1<<len)-1<=n;i++)
        {
            dp1[i][len]=max(dp1[i][len-1],dp1[i+(1<<(len-1))][len-1]);
            dp2[i][len]=min(dp2[i][len-1],dp2[i+(1<<(len-1))][len-1]);
        }
    }
    for(int i=1;i<=q;i++)
    {
        int l,r;
        cin>>l>>r;
        int k=log2(r-l+1);
        int ret=max(dp1[l][k],dp1[r-(1<<k)+1][k])-min(dp2[l][k],dp2[r-(1<<k)+1][k]);
        cout<<ret<<'\n';
    }    

    return 0;    
}
```

## ST表

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128;
using ll = long long;
#define int ll
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<vector<int>>dp(n+1,vector<int>(22));
    for(int i=1;i<=n;i++)cin>>dp[i][0];
    for(int len=1;len<=20;len++)
    {
        for(int i=1;(i+(1<<len)-1)<=n;i++)
        {
            dp[i][len]=max(dp[i][len-1],dp[i+(1<<(len-1))][len-1]);
        }
    }
    for(int i=1;i<=m;i++)
    {
        int l,r;
        cin>>l>>r;
        int k=log2(r-l+1);
        cout<<max(dp[l][k],dp[r-(1<<k)+1][k])<<'\n';
    }

    return 0;    
}
```

