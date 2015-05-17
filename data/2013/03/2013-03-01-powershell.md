---
layout: post
pubdate: "2013-03-01T23:59:59+09:00"
title: PowerShell スクリプトで DB 操作
tags: [powershell]
minutes: 10
pagetype: posts
---
わけあって PowerShell スクリプトで DB を操作した。

Web 検索すると [ADO を使用する方法][link1] が紹介されている。リンク先は Access が相手だからかもしれないが、ADO を使っていた。PowerShell では ADO.NET が使える。つまり、Oracle が相手なら ODP.NET を使えるので、.NET 開発者にとってもっと慣れた方法がとれる。

System.Reflection.Assembly クラスの LoadWithPartial メソッドを使って該当のアセンブリをロードする。次のように実行すると良い。

    [System.Reflection.Assembly]::LoadWithPartial("Oracle.DataAccess")

[CodeZine の PowerShell 記事][link2]でも同様の方法で読みこんでいる。他にもメソッドはあるので、そちらはリンク先を参照してほしい。

あとは `New-Object` コマンドレットで Connection などを使っていくだけだ。

    $connectionString = "Data Source=127.0.0.1:1521/db;User Id=user;Password=password"
    $connection = New-Object Oracle.DataAccess.Client.OracleConnection($connectionString)
    ...

なるほど、簡単だ。

10 min.

[link1]: http://gallery.technet.microsoft.com/office/f6cd8ac6-6ef2-4c27-b495-218b3eca6516
[link2]: http://codezine.jp/article/detail/3572?p=2

