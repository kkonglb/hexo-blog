---
title: zzu  vjudge暑假训练day3--动态规划
date: 2024年11月27日 22:35:05
tags:
---

# zzu  vjudge暑假训练day3--动态规划

## B最长上升子序列

[https://www.luogu.com.cn/problem/B3637](https://www.luogu.com.cn/problem/B3637)

```c++
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
    vector<int>a(n+1),dp(n+1,1);
    for(int i=1;i<=n;i++)cin>>a[i];   
    for(int i=1;i<=n;i++)
    {
        for(int j=1;j<i;j++)
        {
            if(a[j]<a[i])// 遍历i之前的dp数组，如果a[j]<a[i],更新dp[j];
            dp[i]=max(dp[i],dp[j]+1);
        }
    }
    cout<<*max_element(dp.begin()+1,dp.end())<<'\n';
    return 0;    
}
```



## D装箱问题

[https://www.luogu.com.cn/problem/P1049](https://www.luogu.com.cn/problem/P1049)

==这一题是个完全背包问题==

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
    int n,v;
    cin>>v>>n;
    vector<int>a(n+1),dp(v+1);
    for(int i=1;i<=n;i++)cin>>a[i];
    for(int i=1;i<=n;i++)
    {
        for(int j=v;j>=1;j--)
        {
            if(j>=a[i])
            dp[j]=max(dp[j],dp[j-a[i]]+a[i]);
        }
    }
    cout<<v-dp[v]<<'\n';

    return 0;    
}
```

## E - 榨取kkksc03 

[https://www.luogu.com.cn/problem/P1855](https://www.luogu.com.cn/problem/P1855)

==这一题是个双重背包，开二维dp数组就行了==

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
using ll = long long;
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;
struct node
{
    int m,v;
};
int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m,t;
    cin>>n>>m>>t;
    vector<node>a(n+1);
    vector<vector<int>>dp(m+1,vector<int>(t+1));    
    for(int i=1;i<=n;i++)cin>>a[i].m>>a[i].v;
    for(int i=1;i<=n;i++)
    {
        for(int j=m;j>=a[i].m;j--)
        {
            for(int k=t;k>=a[i].v;k--)
            {
                dp[j][k]=max(dp[j][k],dp[j-a[i].m][k-a[i].v]+1);
            }
        }
    }
    cout<<dp[m][t]<<'\n';
    return 0;    
}
```

## F - 石子合并

[https://www.luogu.com.cn/problem/P1880](https://www.luogu.com.cn/problem/P1880)

==这一题本来是想用贪心算法的，但是贪心本质逻辑是错误的，应该用区间dp==

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

**这个是洛谷上石子合并的弱化版，这个石子是呈线性分布的**

[https://www.luogu.com.cn/problem/P1775](https://www.luogu.com.cn/problem/P1775)

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
    vector<ll>prev(n+1);
    vector<int>a(n+1);
    vector<vector<int>>dp(n+1,vector<int>(n+1,inf/2));
    for(int i=1;i<=n;i++)
    {
        cin>>a[i];
        prev[i]=prev[i-1]+a[i];
        dp[i][i]=0;// 合并每个i本身没有花费，所以直接初始化为0
    }    
    for(int len=2;len<=n;len++)// 区间的大小，从2到n
    {
        for(int i=1;i+len-1<=n;i++)//区间起点
        {
            int j=i+len-1;// 区间终点
            for(int k=i;k<j;k++)// 切割位置
            {
                dp[i][j]=min(1LL*dp[i][j],dp[i][k]+dp[k+1][j]+prev[j]-prev[i-1]);
            }
        }
    }
    cout<<dp[1][n]<<'\n';// 合并从1到n这个区间的最小花费


    return 0;    
}
```

## [USACO16OPEN] 248 G
[https://www.luogu.com.cn/problem/P3146](https://www.luogu.com.cn/problem/P3146)

==区间dp==

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
    vector<int>a(n+1);
    int ret=-inf;
    for(int i=1;i<=n;i++){cin>>a[i];ret=max(ret,a[i]);}
    vector<vector<int>>dp(n+1,vector<int>(n+1));
    for(int i=1;i<=n;i++)dp[i][i]=a[i];  // dp[i][j]数组表示将从i到j完全合并所能生成的值，如果不能合并就是0
    for(int len=2;len<=n;len++)
    {
        for(int i=1;i+len-1<=n;i++)
        {   
            int j=i+len-1;
            for(int k=i;k<j;k++)
            {
                // 加这个dp[i][k]是防止dp[i][k]和dp[k+1][j]都是0而强行合并成1 
                if(dp[i][k]==dp[k+1][j]&&dp[i][k])dp[i][j]=max(dp[i][j],dp[i][k]+1);
                ret=max(ret,dp[i][j]);
            }
        }
    }
    cout<<ret<<'\n';
    return 0;    
}
```



## H - 没有上司的舞会

[https://www.luogu.com.cn/problem/P1352](https://www.luogu.com.cn/problem/P1352)

==树形DP,首先构建出整个树的结构，然后找出根节点，将每个节点分为选和不选两个状态（由dp数组第二维控制，0为不选，1为选），然后递归求解==

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
    vector<int>a(n+1),fa(n+1);
    for(int i=1;i<=n;i++)cin>>a[i];
    vector<vector<int>>adj;
    for(int i=1;i<n;i++)
    {
        int a,b;
        cin>>a>>b;
        adj[b].push_back(a);
        fa[a]=b;
    }    
    int root=0;
    for(int i=1;i<=n;i++)
    {
        if(fa[i]==0){root=i;break;}
    }
    vector<vector<int>>dp(n+1,vector<int>(2));
    auto dfs=[&](auto self,int u)->void{
        dp[u][1]+=a[u];
        for(auto v:adj[u])
        {
            self(self,v);
            dp[u][1]+=dp[v][0];
            dp[u][0]+=max(dp[v][0],dp[v][1]);
        }
    };
    dfs(dfs,root);
    cout<<max(dp[root][0],dp[root][1])<<"\n";
    return 0;    
}
```

## 最大子段和

[https://www.luogu.com.cn/problem/P1115](https://www.luogu.com.cn/problem/P1115)

==这一个题就是常规的DP，不过贪心更容易想到==

```cpp
#include<bits/stdc++.h>
using namespace std;
using ll = long long; 
const int N=2e5+10;
int arr[N];
int main()
{
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int n;
    cin>>n;
    for(int i=1;i<=n;i++)
    {
        cin>>arr[i];
    }
    vector<int>dp(n+1);
    for(int i=1;i<=n;i++)
    {
        if(dp[i-1]>0)dp[i]=dp[i-1]+arr[i];
        else dp[i]=arr[i];
    }
    int ret=*max_element(dp.begin()+1,dp.end());
    cout<<ret<<"\n";



    return 0;    
}
```

## 乌龟棋

[https://www.luogu.com.cn/problem/P1541](https://www.luogu.com.cn/problem/P1541)

==本题由于规定每个数字最多有40个，限定了大小，可以开四维数组求解

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
using ll = long long;
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;
const int maxn=41;
int dp[maxn][maxn][maxn][maxn];
int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    vector<int>a(n+1);
    for(int i=1;i<=n;i++)cin>>a[i];
    vector<int>cnt(5);
    for(int i=1;i<=m;i++)
    {
        int x;
        cin>>x;
        cnt[x]++;
    }
    dp[0][0][0][0]=a[1];
    for(int i=0;i<=cnt[1];i++)
    {
        for(int j=0;j<=cnt[2];j++)
        {
            for(int k=0;k<=cnt[3];k++)
            {
                for(int d=0;d<=cnt[4];d++)
                {
                    int r=1+i*1+j*2+k*3+d*4;// 计算到达的位置
                    if(i)dp[i][j][k][d]=max(dp[i][j][k][d],dp[i-1][j][k][d]+a[r]);
                    if(j)dp[i][j][k][d]=max(dp[i][j][k][d],dp[i][j-1][k][d]+a[r]);
                    if(k)dp[i][j][k][d]=max(dp[i][j][k][d],dp[i][j][k-1][d]+a[r]);
                    if(d)dp[i][j][k][d]=max(dp[i][j][k][d],dp[i][j][k][d-1]+a[r]);
                }
            }
        }
    }
    cout<<dp[cnt[1]][cnt[2]][cnt[3]][cnt[4]]<<'\n';

    return 0;    
}
```

