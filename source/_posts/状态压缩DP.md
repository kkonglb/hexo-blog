---
title: 状态压缩
date: 2024年11月27日  22:31:50
categories:
- 动态规划
tags:
- 算法
- 动态规划
---

# 状态压缩

## P1896 [SCOI2005] 互不侵犯

https://www.luogu.com.cn/problem/P1896

这个状态枚举需要注意的是枚举行会直接枚举到n+1行，因为n+1行的`dp[n+1][k][0]`能和上一层所有符合条件的`dp[n][k][a]`兼容，所以就相当于直接把上一层的结果直接集成起来了，不过不这样做的话直接对最后一层的所有可能情况求和也是可以的，如果想要尝试这一种方法的话就看第二段代码（这个行遍历只到第n行）

```cpp
#include<bits/stdc++.h>
using namespace std;
using u32 = unsigned;
using ll = long long;
using u64 = unsigned long long;
const int inf = 2147483647;
const ll INF = 1e18;
ll dp[12][144][1<<12];
//f[i,j,a]表示前i行已放了j个国王，第i行的第a个状态时的方案数 

int main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,k;
    cin>>n>>k;
    vector<int>s(1<<n);
    vector<int>num(1<<n);
    int cnt=0;
    for(int i=0;i<(1<<n);i++)//枚举一行的所有状态
    {
        if(!(i&i>>1))//如果不存在相邻的1
        {
            s[cnt++]=i;//一行的合法状态集，例101
            for(int j=0;j<n;j++)
            {
                if(i>>j&1)
                {
                    num[i]++;//每个合法状态包含的国王数
                }
            }
        }
    }    
    dp[0][0][0]=1;// 边界
    for(int i=1;i<=n+1;i++)// 枚举行
    {
        for(int j=0;j<=k;j++)// 枚举国王数
        {
            for(int a=0;a<cnt;a++)// 枚举第i行的合法状态
            {
                for(int b=0;b<cnt;b++)// 枚举第i-1行的合法状态
                {
                    int c=num[s[a]];// 第i行第a状态的国王数
                    if(j<c||s[a]&s[b]||s[a]&(s[b]>>1)||s[a]&(s[b]<<1))continue;
                    dp[i][j][a]+=dp[i-1][j-c][b];//行间转移
                }
            }
        }
    }
    cout<<dp[n+1][k][0]<<'\n';//第n+1行不放国王的方案数
    return 0;
}
```

```cpp
ll sum=0;
for(int i=0;i<cnt;i++)
{
    sum+=dp[n][k][i];
}
cout<<sum<<'\n';	
```



## P1879 [USACO06NOV] Corn Fields G

https://www.luogu.com.cn/problem/P1879

玉米田这一道题整体上来说是比小国王简单的，但是多了一点需要处理行内土地是否肥沃这一种情况

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
int g[14];// 各行的状态值
int s[1<<14];//这个通过cnt存行内兼容的状态
int dp[14][1<<14];
const int mod=1e8;
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    cin>>n>>m;
    for(int i=1;i<=n;i++)// 处理各行的转态
    {
        for(int j=1;j<=m;j++)
        {
            int x;
            cin>>x;
            g[i]=(g[i]<<1)+x;
        }
    }
    int cnt=0;
    for(int i=0;i<(1<<m);i++)
    {
        if(!(i&(i>>1)))
        {
            s[cnt++]=i;
        }
    }
    dp[0][0]=1;// 这一种求方案数的一般都是给一个1，然后逐渐传递状态
    for(int i=1;i<=n+1;i++)// 注意必须要到n+1行
    {
        for(int a=0;a<cnt;a++)
        {
            for(int b=0;b<cnt;b++)
            {
                if((s[a]&g[i])!=s[a]||s[a]&s[b])continue;
                dp[i][a]=(dp[i][a]+dp[i-1][b])%mod;
            }
        }
    }
    cout<<dp[n+1][0]<<'\n';

    return 0;    
}
```

## P2704 [NOI2001] 炮兵阵地

https://www.luogu.com.cn/problem/P2704


```cpp

```

## P10975 Mondriaan's Dream  (蒙德里安的梦想)

https://www.luogu.com.cn/problem/P10975

如果该位置放的是一行两列的矩形，那么第一个位置是1，第二个位置是0。如果放的是两行一列的矩形，那么两个位置都是0。然后对每一列的状态进行状态压缩。判断相邻的两列是否兼容：两列进行|（或运算），如果某一位是0，说明这两列之一位置都是0，都不能是横放状态下的第一个，之后如果存在连续0的个数为奇数，竖放也放不下，所以不兼容，同时如果两列某一位置同时为1，也不能兼容。先创建一个vis数组处理两行|之后的结果是否兼容，然后再判断是否某一位同时为1。最后一列一列传递兼容的值，到最后一列只能全部为0，也就是状态0。

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
const int N=12,M=1<<N;
int vis[M];
signed main()
{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n,m;
    while(cin>>n>>m,n||m)
    {
        vector<vector<ll>>dp(m+1,vector<ll>(1<<n+1));
        for(int i=0;i<(1<<n);i++)// 处理vis[i],判断两列是否兼容,如果两列|之后的值vis[i]为1,那么就说明兼容. 
        {
            int cnt=0;
            vis[i]=true;
            for(int j=0;j<n;j++)
            {
                if(i>>j&1)
                {
                    if(cnt&1){vis[i]=false;break;}// 这里不用额外处理cnt是否重置为0,因为处理的事cnt的奇偶性,如果是偶数继续就行了,如果是奇数就退出
                }
                else cnt++;
            }
            if(cnt&1)vis[i]=false;//处理高位0的个数 
        }
        dp[0][0]=1;
        for(int i=1;i<=m;i++)// 遍历列
        {
            for(int j=0;j<(1<<n);j++)//状态：枚举第i列的状态
            {
                for(int k=0;k<(1<<n);k++)//状态：枚举第i-1列的状态
                {
                    if((j&k)==0&&vis[j|k])//两列状态兼容：不出现重叠的1，不出现连续的奇数个0 
                    {
                        dp[i][j]+=dp[i-1][k];
                    }
                }
            }
        }
        cout<<dp[m][0]<<'\n';//第m列不横放即答案 
    }    

    return 0;    
}
```

