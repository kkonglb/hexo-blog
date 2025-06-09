---
title: acm一些需要记的语法规则
tags:
  - 技能积累
categories:
  - 技能积累
date: 2025-04-22 17:17:23
---

 ## priority_queue，map，set自定义排序规则

STL 算法（如 `sort`）和容器（如 `priority_queue`）要求比较器是**类型**而非函数，`std::greater<int>` 满足这一要求。

`std::greater<int>` 是一个**类模板**（定义在 `<functional>` 头文件中）。

### priority_queue

`priority_queue` 的第三个模板参数需要是一个**类型（Type）**，而不是一个**函数或函数对象实例**。

==错误代码==

```cpp
priority_queue<node, vector<node>, compare()> pq;  // 错误：compare() 是函数调用
```

#### **方法 1：使用函数对象类型（`decltype` + 函数指针）**

将 `compare` 函数的地址作为模板参数，并通过 `decltype` 推导类型：

```cpp
priority_queue<node, vector<node>, decltype(&compare)> pq(compare);
```

#### **方法 2：使用 `std::function`**

显式指定函数签名：

```cpp
priority_queue<node, vector<node>, function<bool(node&, node&)>> pq(compare);
```

#### **方法 3：定义函数对象类（推荐）**

将 `compare` 改为一个函数对象类（重载 `operator()`）：

```cpp
struct Compare {
    bool operator()(node& a, node& b) {
        return a.val < b.val;  // 注意：优先队列的默认是最大堆
    }
};
priority_queue<node, vector<node>, Compare> pq;
```

### map

  map<int,int>也是需要的类型而不是函数对象，如果是greater<>这种的话因为是对键排序，所以键的位置是哪一种类型就用哪一种，比如map<string,int>就用的greater<string>

  然后就跟priority_queue差不多了。

```cpp
// 自定义比较规则：按字符串长度升序
struct CompareByLength {
    bool operator()(const std::string& a, const std::string& b) const {
        return a.length() < b.length();
    }
};
int main() {
    std::map<std::string, int, CompareByLength> wordMap;
    return 0;
}
```

## set

set也差不多，比如set<int>就用的greater<int>

```cpp
struct CompareByAgeDesc {
    bool operator()(const Person& a, const Person& b) const {
        return a.age > b.age; // 降序
    }
};
int main() {
    std::set<Person, CompareByAgeDesc> descSet ;
}
```

或者重载类中排序函数

```cpp
struct Person {
    std::string name;
    int age;

    // 重载 < 运算符（按 age 升序）
    bool operator<(const Person& other) const {
        return age < other.age; // 默认升序
    }
};
```

