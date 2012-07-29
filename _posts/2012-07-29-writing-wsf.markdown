---
layout: post
pubdate: "2012-07-29T23:07:55+09:00"
title: WSH(2)〜WSFを書く〜
tags: wsh
---
WSH(Windows Script Host)について調べている。今日はWSFについて書いておく。

WSFはWindows Script Fileの略である。XML形式で書かれており、WSHスクリプトの動作を設定できる、らしい。

「らしい」と書いたのは、実は書いたことがないからだ。このWSFファイルはスクリプトの実行には必須ではない。VBScriptやJScriptをwscript.exeやcscript.exeに渡せば実行できてしまう。必須でないものというのは、きちんと勉強しないと知らないままに過ごすことが多い。WSFはその典型なのだ。

今回はそのWSFのサンプルを書く。はじめてのWSFだ。

まず今回書くサンプルの仕様を書く。バックアップをローテーションさせるスクリプトである。元ファイルと先ディレクトリとを指定。日付つきで実行時点から一週間分を保持しよう。古いファイルを消し、新しいファイルを日付つきで保持する。対象を選べるようsrcfileとdstdirというオプションを持たせよう。より実用的であるよう、好きではないけど、VBScriptを使う。こんな感じの仕様で作るつもりだ。

仕様が定まったので、さっそく実装する。WSFを作成する。

<div><script src="https://gist.github.com/3199211.js?file=rotate-backup.wsf"></script><noscript><pre><code>&lt;?xml version=&quot;1.0&quot; standalone=&quot;yes&quot;?&gt;
&lt;package&gt;
    &lt;job id=&quot;RotateBackup&quot;&gt;
        &lt;?job error=&quot;false&quot; debug=&quot;true&quot;?&gt;
        &lt;runtime&gt;
            &lt;description&gt;
                バックアップをローテーションする。
            &lt;/description&gt;
            &lt;named
                name=&quot;srcfile&quot;
                helpstring=&quot;バックアップするファイル&quot;
                type=&quot;string&quot;
                required=&quot;true&quot;
                /&gt;
            &lt;named
                name=&quot;dstdir&quot;
                helpstring=&quot;バックアップ先のディレクトリ&quot;
                type=&quot;string&quot;
                required=&quot;true&quot;
                /&gt;
            &lt;example&gt;
                Example: rotate-backup.wsf /srcfile:src.zip /dstdir:C:\backup
            &lt;/example&gt;
        &lt;/runtime&gt;
        &lt;script language=&quot;VBScript&quot;&gt;
            WScript.Echo(&quot;Hello, WSH!&quot;)
        &lt;/script&gt;
    &lt;/job&gt;
&lt;/package&gt;</code></pre></noscript></div>

こんな感じ。コードはとりあえず「Hello, WSH!」にした。ここからコードを書いていく。とはいえ実際はここに記載せず別ファイルに切り出すつもりだ。script要素のsrc属性にファイル名を指定できるらしいから。

ひとまず今日はここまで。明日は引数処理かなあ。

17 min.
