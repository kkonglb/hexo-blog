---
title: Codeforces Round 991 (Div. 3)
date: 2024-12-07 00:01:01
tags: 
- codeforces
categories: 
- Codeforces刷题
---

# Codeforces Round 991 (Div. 3)

## A. Line Breaks

[https://codeforces.com/contest/2050/problem/A](https://codeforces.com/contest/2050/problem/A)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
void solve(){
    int n,m;
    cin>>n>>m;
    ll sum=0;
    int cnt=0;
    for(int i=1;i<=n;i++)
    {
        string s;
        cin>>s;
        sum+=s.size();
        if(sum<=m)cnt++;
    }    
    cout<<cnt<<'\n';
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;cin>>tt;
    while(tt--){
        solve();
    }


    return 0;    
}
```

## B. Transfusion

[https://codeforces.com/contest/2050/problem/B](https://codeforces.com/contest/2050/problem/B)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
void solve(){
    int n;
    cin>>n;
    vector<int>a(n+1);
    for(int i=1;i<=n;i++)cin>>a[i];
    ll sum=accumulate(a.begin()+1,a.end(),0ll);
    if(sum%n)return cout<<"NO\n",void();
    int aver=sum/n;
    for(int i=1;i<=n-2;i++)
    {
        int shu=a[i]-aver;
        a[i+2]+=shu;
    }    
    if(a[n-1]==aver&&a[n]==aver)cout<<"YES\n";
    else cout<<"NO\n";
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;cin>>tt;
    while(tt--){
        solve();
    }


    return 0;    
}
```

## C. Uninteresting Number

[https://codeforces.com/contest/2050/problem/C](https://codeforces.com/contest/2050/problem/C)

```cpp
#include <bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
// #define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
void solve()
{
    string s;
    cin >> s;
    int n = s.size();
    int sum = 0;
    int cnt2 = 0, cnt3 = 0;
    for (int i = 0; i < n; i++)
    {
        sum += s[i] - '0';
        if (s[i] == '2')
            cnt2++;
        else if (s[i] == '3')
            cnt3++;
    }
    sum %= 9;
    int shu = (9 - sum) % 9;
    if (shu == 0)
        return cout << "YES\n", void();
    set<int> se;
    int it;
    for (int i = 0; i <= min(cnt2, 9); i++)
    {
        for (int j = 0; j <= min(cnt3, 9); j++)
        {
            it = (2 * i + 6 * j) % 9;
            se.insert(it);
        }
    }
    if (se.contains(shu))
        cout << "YES\n";
    else
        cout << "NO\n";
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;
    cin >> tt;
    while (tt--)
    {
        solve();
    }

    return 0;
}
```

## D. Digital string maximization

[https://codeforces.com/contest/2050/problem/D](https://codeforces.com/contest/2050/problem/D)

这道题就是往后看8个位置就行了，找到实际价值最大的，一直往左移就行了。

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
void solve(){
    string s;
    cin>>s;
    int n=s.size();
    for(int i=0;i<n;i++)
    {
        int k=i;
        for(int j=i;j<n&&j<i+9;j++)
        {
            if(s[j]-j>s[k]-k)k=j;
        }
        while(k>i)
        {
            s[k]--;
            swap(s[k],s[k-1]);
            k--;
        }
    }    
    cout<<s<<'\n';
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;cin>>tt;
    while(tt--){
        solve();
    }


    return 0;    
}
```

## E. Three Strings

[https://codeforces.com/contest/2050/problem/E](https://codeforces.com/contest/2050/problem/E)

看到数据范围1e3，一眼i和j双层循环，

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
//#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
void solve(){
    string a,b,c;
    cin>>a>>b>>c;
    int n=a.size(),m=b.size();
    vector dp(n+1,vector<int>(m+1,inf));
    dp[0][0]=0;
    for(int i=0;i<=n;i++)
    {
        for(int j=0;j<=m;j++)
        {
            if(i<n)dp[i+1][j]=min(dp[i+1][j],dp[i][j]+(a[i]!=c[i+j]));
            if(j<m)dp[i][j+1]=min(dp[i][j+1],dp[i][j]+(b[j]!=c[i+j]));
        }
    }
    cout<<dp[n][m]<<'\n';
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;cin>>tt;
    while(tt--){
        solve();
    }


    return 0;    
}
```

## F. Maximum modulo equality

[https://codeforces.com/contest/2050/problem/F](https://codeforces.com/contest/2050/problem/F)

这一道题可以用ST表和线段树来解决，就是用线段树维护区间内元素的差值，将+号重载为gcd就行了，找到范围内差值的最大公约数就是最终的答案。

```cpp
#include <bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
// #define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
template <class Info>
struct SegmentTree
{
    int n;
    vector<Info> info;

    SegmentTree(): n(0) {}

    SegmentTree(int n, Info _init = Info())
    {
        init(vector<Info>(n, _init));
    }

    SegmentTree(const vector<Info> &_init)
    {
        init(_init);
    }

    void init(const vector<Info> &_init)
    {
        n = (int)_init.size();
        info.assign((n << 2) + 1, Info());
        function<void(int, int, int)> build = [&](int p, int l, int r)
        {
            if (l == r)
            {
                info[p] = _init[l - 1];
                return;
            }
            int m = (l + r) / 2;
            build(2 * p, l, m);
            build(2 * p + 1, m + 1, r);
            pull(p);
        };
        build(1, 1, n);
    }

    void pull(int p)
    {
        info[p] = info[2 * p] + info[2 * p + 1];
    }

    void modify(int p, int l, int r, int x, const Info &v)
    {
        if (l == r)
        {
            info[p] = v;
            return;
        }
        int m = (l + r) / 2;
        if (x <= m)
        {
            modify(2 * p, l, m, x, v);
        }
        else
        {
            modify(2 * p + 1, m + 1, r, x, v);
        }
        pull(p);
    }

    void modify(int p, const Info &v)
    {
        modify(1, 1, n, p, v);
    }

    Info query(int p, int l, int r, int x, int y)
    {
        if (l > y || r < x)
        {
            return Info();
        }
        if (l >= x && r <= y)
        {
            return info[p];
        }
        int m = (l + r) / 2;
        return query(2 * p, l, m, x, y) + query(2 * p + 1, m + 1, r, x, y);
    }

    Info query(int l, int r)
    {
        return query(1, 1, n, l, r);
    }

    int find_first(int p, int l, int r, int L, int R, const function<bool(const Info &)> &f, Info &pre)
    {
        if (l > R || r < L)
        {
            return r + 1;
        }
        if (l >= L && r <= R)
        {
            if (!f(pre + info[p]))
            {
                pre = pre + info[p];
                return r + 1;
            }
            if (l == r)
                return r;
            int m = (l + r) / 2;
            int res;
            if (f(pre + info[2 * p]))
            {
                res = find_first(2 * p, l, m, L, R, f, pre);
            }
            else
            {
                pre = pre + info[2 * p];
                res = find_first(2 * p + 1, m + 1, r, L, R, f, pre);
            }
            return res;
        }
        int m = (l + r) / 2;
        int res = m + 1;
        if (L <= m)
        {
            res = find_first(2 * p, l, m, L, R, f, pre);
        }
        if (R > m && res == m + 1)
        {
            res = find_first(2 * p + 1, m + 1, r, L, R, f, pre);
        }
        return res;
    }

    int find_first(int l, int r, const function<bool(const Info &)> &f)
    {
        Info pre = Info();
        return find_first(1, 1, n, l, r, f, pre);
    }

    int find_last(int p, int l, int r, int L, int R, const function<bool(const Info &)> &f, Info &suf)
    {
        if (l > R || r < L)
        {
            return l - 1;
        }
        if (l >= L && r <= R)
        {
            if (!f(info[p] + suf))
            {
                suf = info[p] + suf;
                return l - 1;
            }
            if (l == r)
                return r;
            int m = (l + r) / 2;
            int res;
            if (f(info[2 * p + 1] + suf))
            {
                res = find_last(2 * p + 1, m + 1, r, L, R, f, suf);
            }
            else
            {
                suf = info[2 * p + 1] + suf;
                res = find_last(2 * p, l, m, L, R, f, suf);
            }
            return res;
        }
        int m = (l + r) / 2;
        int res = m;
        if (R > m)
        {
            res = find_last(2 * p + 1, m + 1, r, L, R, f, suf);
        }
        if (L <= m && res == m)
        {
            res = find_last(2 * p, l, m, L, R, f, suf);
        }
        return res;
    }

    int find_last(int l, int r, const function<bool(const Info &)> &f)
    {
        Info suf = Info();
        return find_last(1, 1, n, l, r, f, suf);
    }
};
struct Info
{
    int g;
};
Info operator+(const Info& a,const Info& b)
{
    return {gcd(a.g, b.g)};
}
void solve()
{
    int n, q;
    cin >> n >> q;
    vector<int> a(n + 1);
    for (int i = 1; i <= n; i++)
        cin >> a[i];
    vector<Info> init(n);
    for (int i = 0; i < n; i++)
    {
        init[i].g = a[i + 1] - a[i];
    }
    SegmentTree<Info> seg(init);
    while (q--)
    {
        int l, r;
        cin >> l >> r;
        int t = seg.query(l + 1, r).g;
        cout << t << ' ';
    }
    cout << '\n';
}

signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int tt;
    cin >> tt;
    while (tt--)
    {
        solve();
    }

    return 0;
}
```



