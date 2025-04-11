---
title: AtCoder Beginner Contest 393
tags:
  - Atcoder
categories:
  - Atcoder
date: 2025-03-20 22:17:53
---

 # **C - Make it Simple**

[https://atcoder.jp/contests/abc393/tasks/abc393_c](https://atcoder.jp/contests/abc393/tasks/abc393_c)

这一题想要把一个无向图变成简单图，我说实话就是用set数组直接存边，同时不存自循环边，最后再把边数之差算出来就行了

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
    int n,m;
    cin>>n>>m;
    set<int>s[n+1];
    int cnt=0;
    for(int i=1;i<=m;i++)
    {
        int u,v;
        cin>>u>>v;
        if(u==v)continue;
        s[u].insert(v);
        s[v].insert(u);
    }    
    for(int i=1;i<=n;i++)
    {
        cnt+=s[i].size();
    }
    cnt/=2;
    int ret=m-cnt;
    cout<<ret<<'\n';

    return 0;    
}
```

# **D - Swap to Gather**

[https://atcoder.jp/contests/abc393/tasks/abc393_d](https://atcoder.jp/contests/abc393/tasks/abc393_d)

## 方法一 （我的）

我的这个方法比较蠢，但是确实想到的比较快。

就是首先进行预处理，然后枚举所有位置，然后让左右两边的1往这个位置上靠，不断更新最终的结果ans。

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
    int n;
    cin>>n;
    string s;
    cin>>s;
    s=" "+s;
    vector<int>pre(n+1),precnt(n+1),suf(n+2),sufcnt(n+2);
    for(int i=1;i<=n;i++)
    {
        pre[i]=pre[i-1]+(s[i]=='1'?i:0);
        precnt[i]=precnt[i-1]+(s[i]=='1'?1:0);
    }    
    for(int i=n;i>=1;i--)
    {
        suf[i]=suf[i+1]+(s[i]=='1'?i:0);
        sufcnt[i]=sufcnt[i+1]+(s[i]=='1'?1:0);
    }
    int ans=LLONG_MAX;
    for(int i=1;i<=n;i++)
    {
        int ret1=0,ret2=0;
        ret1=1ll*i*precnt[i]-pre[i]-1ll*(precnt[i]-1)*precnt[i]/2;
        ret2=suf[i+1]-1ll*(i+1)*sufcnt[i+1]-1ll*(sufcnt[i+1]-1)*sufcnt[i+1]/2;
        ans=min(ans,ret1+ret2);
    }
    cout<<ans<<'\n';

    return 0;    
}
```

## 官方解法（很妙）

==官方做法：==
我们先考虑某一个0：如果它左侧的1比较少，那么应该将其移动至其左侧所有1的左侧；如果它右侧的1比较少，那么应该将其移动至其右侧所有1的右侧，因此对于每个0，它的代价都是：min（左侧的1的个数，右侧的1的个数）答案即为所有0的代价的和、

这个方法太妙了，比我的傻鸟预处理好多了。他是将每一个1进行移动，然后每一步都很好写，但是我的就是同时移动所有的1，虽然感觉我的复杂度也不是很高。

```cpp
#include <bits/stdc++.h>
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
    int n;
    cin >> n;
    string s;
    cin >> s;
    int sum = 0;
    for (auto ch : s)
    {
        if (ch == '1')
            sum++;
    }
    int ans = 0;
    int cnt = 0;
    for (int i = 0; i < n; i++)
    {
        if (s[i] == '0')
        {
            ans += min(cnt, sum - cnt);
        }
        else
        {
            cnt++;
        }
    }
    cout << ans << '\n';

    return 0;
}
```



# **E - GCD of Subset** 

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
const int N=1200010;
const int MAXN=1000010;
int n,k;
int a[N];
int cnt[MAXN];
int multi[MAXN];
int ans[MAXN];
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cin>>n>>k;
    int maxn=0;
    for(int i=1;i<=n;i++)
    {
        cin>>a[i];
        maxn=max(maxn,a[i]);
        cnt[a[i]]++;
    }

    for(int x=1;x<=maxn;x++)
    {
        for(int y=x;y<=maxn;y+=x)
        {
            multi[x]+=cnt[y];
        }
    }

    for(int i=1;i<=maxn;i++)
    {
        if(multi[i]<k)continue;
        for(int j=i;j<=maxn;j+=i)
        {
            ans[j]=max(ans[j],i);
        }
    }
    for(int i=1;i<=n;i++)
    {
        cout<<ans[a[i]]<<'\n';
    }

    return 0;    
}
```



