---
title: AtCoder Beginner Contest 394
tags:
  - 技能积累
categories:
  - 技能积累
date: 2025-03-21 11:13:32
---


[https://www.bilibili.com/video/BV1E2ASeiE8b/?spm_id_from=333.337.search-card.all.click&vd_source=6759ab7a746b50893c564c06fbc6a752](https://www.bilibili.com/video/BV1E2ASeiE8b/?spm_id_from=333.337.search-card.all.click&vd_source=6759ab7a746b50893c564c06fbc6a752)

 # **C - Debug**

[https://atcoder.jp/contests/abc394/tasks/abc394_c](https://atcoder.jp/contests/abc394/tasks/abc394_c)

纯模拟

``` cpp
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
    string s;
    cin>>s;
    int n=s.size();
    s=" "+s;
    for(int i=1;i<n;i++)
    {
        if(s[i]=='W'&&s[i+1]=='A')
        {
            s[i]='A',s[i+1]='C';
            int j=i;
            while(j>=2&&s[j-1]=='W')
            {
                s[j-1]='A',s[j]='C';
                j--;
            }
        }
    }    
    for(int i=1;i<=n;i++)cout<<s[i];
    return 0;    
}
```

# **D - Colorful Bracket Sequence**

[https://atcoder.jp/contests/abc394/tasks/abc394_d](https://atcoder.jp/contests/abc394/tasks/abc394_d)

这一题也是模拟，就是模拟个栈。

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
char a[N];
int cnt=0;
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    string s;
    cin>>s;
    map<char,int>mp;
    mp['(']=0,mp[')']=1,mp['[']=2,mp[']']=3,mp['<']=4,mp['>']=5;
    int n=s.size();
    for(int i=0;i<n;i++)
    {
        a[++cnt]=s[i];
        while(cnt>=2&&mp[a[cnt]]>mp[a[cnt-1]]&&(mp[a[cnt]]^mp[a[cnt-1]])==1)
        {
            cnt-=2;
        }
    }
    if(cnt==0)cout<<"Yes\n";
    else cout<<"No\n";
    return 0;    
}
```

# 