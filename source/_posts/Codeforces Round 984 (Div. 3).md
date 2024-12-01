---
title: Codeforces Round 984 (Div. 3)
date: 2024年11月27日 22:35:37
tags:
---

# [Codeforces Round 984 (Div. 3)](https://codeforces.com/contest/2036)

赛时最后一道没有写出来，但是现在看最后一道依然很难受😡

## A. Quintomania

[https://codeforces.com/contest/2036/problem/A](https://codeforces.com/contest/2036/problem/A)

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
    int ok=1;
    for(int i=2;i<=n;i++)
    {
        if(abs(a[i]-a[i-1])!=5&&abs(a[i]-a[i-1])!=7)
        {
            ok=0;
            break;
        }
    }  
    cout<<(ok?"YES\n":"NO\n");
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

## B. Startup

[https://codeforces.com/contest/2036/problem/B](https://codeforces.com/contest/2036/problem/B)

货架数最多为k，所以压根不需要离散化，又是写复杂的一天。

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
    int n,k;
    cin>>n>>k;
    vector<int>s(k+1);
    for(int i=1;i<=k;i++)
    {
        int a,b;
        cin>>a>>b;
        s[a]+=b;
    }    
    sort(s.begin()+1,s.end(),greater<>());
    n=min(n,k);
    int ans=accumulate(s.begin()+1,s.begin()+1+n,0ll);
    cout<<ans<<'\n';
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

## C. Anya and 1100

[https://codeforces.com/contest/2036/problem/C](https://codeforces.com/contest/2036/problem/C)

第一个是我写的傻鸟代码，因为当时没有想到什么比较好的边界处理办法，只能这么写了。😭

第二个是从大佬那里学来的代码风格。🤩

`for(int i=max(1,p-3);i<=min(p,n-3);i++)`就是这一步，当时脑子短路了，只能直接枚举了。

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
    s=" "+s;
    set<int>vis;
    for(int i=1;i<=n-3;i++)
    {
        if(s[i]=='1'&&s[i+1]=='1'&&s[i+2]=='0'&&s[i+3]=='0')vis.insert(i);
    }
    int q;
    cin>>q;
    while(q--)
    {
        int i,v;
        cin>>i>>v;
        v='0'+v;    
        if(s[i]==v){
            if(vis.size())cout<<"YES\n";
            else cout<<"NO\n";
            continue;
        }
        if(s[i]=='1')
        {
            if(n-i>=3)
            {
                if(s[i+1]=='1'&&s[i+2]=='0'&&s[i+3]=='0')vis.erase(i);
            }
            if(n-i>=2)
            {
                if(s[i-1]=='1'&&s[i+1]=='0'&&s[i+2]=='0')vis.erase(i-1);
            }
            if(n-i>=1&&i>=3)
            {
                if(s[i-2]=='1'&&s[i-1]=='1'&&s[i+1]=='0')vis.insert(i-2);
            }
            if(n-i>=0&&i>=4)
            {
                if(s[i-3]=='1'&&s[i-2]=='1'&&s[i-1]=='0')vis.insert(i-3);
            }
        }
        else 
        {
            if(n-i>=3)
            {
                if(s[i+1]=='1'&&s[i+2]=='0'&&s[i+3]=='0')vis.insert(i);
            }
            if(n-i>=2)
            {
                if(s[i-1]=='1'&&s[i+1]=='0'&&s[i+2]=='0')vis.insert(i-1);
            }
            if(n-i>=1&&i>=3)
            {
                if(s[i-2]=='1'&&s[i-1]=='1'&&s[i+1]=='0')vis.erase(i-2);
            }
            if(n-i>=0&&i>=4)
            {
                if(s[i-3]=='1'&&s[i-2]=='1'&&s[i-1]=='0')vis.erase(i-3);
            }
        }
        s[i]=v;
        if(vis.size())cout<<"YES\n";
        else cout<<"NO\n";
    }    
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
    s=" "+s;
    int q;
    cin>>q;
    int cnt=0;
    for(int i=1;i<=n-3;i++)
    {
        cnt+=s.substr(i,4)=="1100";     
    }
    while(q--)
    {
        int p;
        char ch;
        cin>>p>>ch;
        for(int i=max(1,p-3);i<=min(p,n-3);i++)// 这一步学会了
        {
            cnt-=s.substr(i,4)=="1100";
        }
        s[p]=ch;
        for(int i=max(1,p-3);i<=min(p,n-3);i++)
        {
            cnt+=s.substr(i,4)=="1100";
        }
        cout<<(cnt?"YES\n":"NO\n");
    }
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

## D. I Love 1543

[https://codeforces.com/contest/2036/problem/D](https://codeforces.com/contest/2036/problem/D)

这一题就是一层一层的处理就行了，不过最后使用上

```cpp
	s+=s;
	for(int i=0;i<s.size()/2;i++)cnt+=(s.substr(i,4)=="1543");
```

这一步能够节省时间

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
    vector v(n+1,vector<char>(m+1));
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<=m;j++)cin>>v[i][j];
    }    
    int cnt=0;
    for(int k=1;k<=(min(n,m)/2);k++)
    {
        string s;
        for(int j=k;j<=m-k;j++)s+=v[k][j];
        for(int i=k;i<=n-k;i++)s+=v[i][m-(k-1)];
        for(int j=m-(k-1);j>=k+1;j--)s+=v[n-(k-1)][j];
        for(int i=n-(k-1);i>=k+1;i--)s+=v[i][k];
        s+=s;
        for(int i=0;i<s.size()/2;i++)cnt+=(s.substr(i,4)=="1543");// 这一步能够节省时间
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

## E. Reverse the Rivers

[https://codeforces.com/contest/2036/problem/E](https://codeforces.com/contest/2036/problem/E)

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
    int n,k,q;
    cin>>n>>k>>q;
    vector v(k+1,vector<int>(n+1));
    for(int j=1;j<=n;j++)
    {
        for(int i=1;i<=k;i++)
        {
            cin>>v[i][j];
        }
    }    
    for(int i=1;i<=k;i++)
    {
        for(int j=2;j<=n;j++)
        {
            v[i][j]|=v[i][j-1];
        }
    }
    for(int i=1;i<=q;i++)
    {
        int m;
        cin>>m;
        int l=1,r=n;
        while(m--)
        {
            int a,b;
            char ch;
            cin>>a>>ch>>b;
            if(ch=='>')
            {
                int it=upper_bound(v[a].begin()+1,v[a].end(),b)-v[a].begin();
                l=max(l,it);
            }
            else
            {
                int it=--lower_bound(v[a].begin()+1,v[a].end(),b)-v[a].begin();
                r=min(r,it);
            }
        }
        if(l<=r)cout<<l<<'\n';
        else cout<<-1<<'\n';
        
    }

    return 0;    
}
```

## F. XORificator 3000      

[https://codeforces.com/contest/2036/problem/F](https://codeforces.com/contest/2036/problem/F)

![3aa3147a351829dce93bf07ee53db7e](D:\微信\WeChat Files\wxid_6tre2ztzy69k22\FileStorage\Temp\3aa3147a351829dce93bf07ee53db7e.jpg)

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
int get(int x)
{
    if(x<0)return 0;
    int shu=x%4;
    if(shu==0)return x;
    else if(shu==1)return 1;
    else if(shu==2)return x+1;
    else return 0;
}
void solve(){
    int i,k;
    ll l,r;
    cin>>l>>r>>i>>k;
    auto getb=[&](int x)->int{
        int t=x>>i<<i|k;
        int cnt=0;
        if(t<=x)
        {
            cnt=x>>i;
        }
        else cnt=(x>>i)-1;
        int shu=get(cnt)<<i;
        if(cnt%2==0)shu^=k;
        return shu;
    };
    int ans=0;
    ans^=get(r);
    ans^=get(l-1);
    ans^=getb(r);
    ans^=getb(l-1);
    cout<<ans<<'\n';
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

## G. Library of Magic

[https://codeforces.com/contest/2036/problem/G](https://codeforces.com/contest/2036/problem/G)

我再也不想看到G题了，等过一段时间再回来看吧。

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
#define i128 __int128
using ll = long long;
#define int ll
using u64 = unsigned long long;
const ll inf = 1e9;
const ll INF = 1e18;
ll query(ll l,ll r)
{
    cout<<"xor "<<l<<' '<<r<<endl;
    int x;
    cin>>x;
    return x;
}
void solve(){
    int n;
    cin >> n;

    int s = 0;
    vector<int> ans;
    auto find = [&] (auto self,int l, int r, int x){
        if(l == r ||s==2) {
            ans.push_back(x);
            return ;
        }
        int res1, res2;
        int mid = l + r >> 1;
        cout << "xor " << l << ' ' << mid << endl;
        cin >> res1;
        res2 = x ^ res1;
        if(res1 && res2) {
            s++;
            self(self,l, mid, res1);
            self(self,mid + 1, r, res2);
        }
        else if(res1){
            self(self,l, mid, res1);
        }
        else if(res2){
            self(self,mid + 1, r, res2);
        }
    };
    int t;
    cout << "xor " << 1 << ' ' << n << endl;
    cin >> t;
    if(t) find(find,1, n, t);
    else{
        int res, t = 1;
        while(t <= n) t <<= 1;
        while(1)
        {
            t>>=1;
            res=query(t,n);
            if(!res)continue;
            s=1;
            ans.push_back(res);
            find(find,t,n,res);
            break;
        }
        
    }
    cout << "ans";
    for(auto x : ans) cout <<' '<<x;
    cout << endl;
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



