---
layout: post
pubdate: "2012-11-01T22:41:07+09:00"
title: LINQ(ToDictionary)
tags: [linq]
pagetype: posts
---
友人が唐突に`IDictionary<TKey,TValueA>`から`IDictionary<TKey,TValueB>`への変換はどうやるのが良いかたずねられた。なんでもそういうコードを考えたが良い方法が思いつかず、foreachで強引に詰め替え処理を書いたらしい。

安全ではあるが面白くないやりかただったので、「`System.Linq.Enumerable.ToDictionary<TSource,TKey>`を使え」と教え、動作確認していない、次のようなC#のコードを示した。

    // C#
    // Dictionary<string,string> -> Dictionary<string,int>
    var d1 = new Dictionary<string, string>()
    {
        {"apple", "300"},
        {"banana", "100"},
        {"orange", "200"}
    };
    var d2 = d1.ToDictionary(p => p.Key, p => int.Parse(p.Value));

`int.Parse`の部分に`Func<TValueB,TValueA>`のような変換するため手続きを渡せば良い。C#、そしてLINQは良い。とても便利な道具である。

12 min.
