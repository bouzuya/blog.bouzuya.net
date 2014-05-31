---
layout: post
pubdate: "2012-08-02T23:37:04+09:00"
title: WSH(6)〜外部ファイルへの切り出し〜
tags: [wsh]
pagetype: posts
---
昨日、外部ファイルへの切り出しについて書いたのだけれど、もっと良い方法を見つけてしまった。

VBScriptだけで実現しようとするとExecuteGlobalステートメントを使うことになるが、あの方法だと毎回Importプロシージャを書かなくてはいけない。

WSFを使っていれば、単純にscript要素を並べるだけで良いことが分かった。外部のスクリプトからプロシージャや関数を使う場合にはPublicをつけておく。使わない場合はPrivateをつけておく。

<div><script src="https://gist.github.com/3237513.js?file=scripts.wsf"></script><noscript><pre><code>&lt;?xml version=&quot;1.0&quot; standalone=&quot;yes&quot;?&gt;
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
                Example: cscript scripts.wsf //Job:RotateBackup /srcfile:src.zip /dstdir:C:\dst
            &lt;/example&gt;
        &lt;/runtime&gt;
        &lt;script language=&quot;VBScript&quot; src=&quot;string.vbs&quot; /&gt;
        &lt;script language=&quot;VBScript&quot; src=&quot;rotate-backup-arguments.vbs&quot; /&gt;
        &lt;script language=&quot;VBScript&quot; src=&quot;rotate-backup-datetime.vbs&quot; /&gt;
        &lt;script language=&quot;VBScript&quot; src=&quot;rotate-backup.vbs&quot; /&gt;
    &lt;/job&gt;
    &lt;job id=&quot;EchoWscriptProperties&quot;&gt;
        &lt;?job error=&quot;false&quot; debug=&quot;true&quot;?&gt;
        &lt;runtime&gt;
            &lt;description&gt;
                WScriptのプロパティを出力する。
            &lt;/description&gt;
            &lt;example&gt;
                Example: cscript scripts.wsf //Job:EchoWscriptProperties
            &lt;/example&gt;
        &lt;/runtime&gt;
        &lt;script language=&quot;VBScript&quot; src=&quot;echo-wscript-properties.vbs&quot; /&gt;
    &lt;/job&gt;
    &lt;job id=&quot;EchoDateTimeFunction&quot;&gt;
        &lt;?job error=&quot;false&quot; debug=&quot;true&quot;?&gt;
        &lt;runtime&gt;
            &lt;description&gt;
                VBScriptのDate/Time関数の結果を出力する。
            &lt;/description&gt;
            &lt;example&gt;
                Example: cscript scripts.wsf //Job:EchoDateTimeFunction
            &lt;/example&gt;
        &lt;/runtime&gt;
        &lt;script language=&quot;VBScript&quot; src=&quot;echo-datetime-function.vbs&quot; /&gt;
    &lt;/job&gt;
&lt;/package&gt;</code></pre></noscript></div>

[https://github.com/bouzuya/wsh-study/tree/b520d8f960bc89c9faa2c4ac36d21b5119a23ae4](https://github.com/bouzuya/wsh-study/tree/b520d8f960bc89c9faa2c4ac36d21b5119a23ae4)

全然進んでいないけれど、ファイルコピーだけできるようにしてみた。次回はもうすこし進めるよ。そろそろ飽きてきたしね。

<div><script src="https://gist.github.com/3237589.js?file=rotate-backup.vbs"></script><noscript><pre><code>Option Explicit

Private Sub Copy(ByVal strSrc, ByVal strDst)
    Dim objFso
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    If objFso.FileExists(strSrc) Then
        Call objFso.CopyFile(strSrc, strDst)
    Else
        ' do nothing
    End If
End Sub

Private Function Main()
    If Not ValidateArguments() Then
        Main = 1
        Exit Function
    End If
    Dim strSrcFile, strDstDir
    strSrcFile = WScript.Arguments.Named.Item(&quot;srcfile&quot;)
    strDstDir = WScript.Arguments.Named.Item(&quot;dstdir&quot;)

    Dim strDate
    strDate = FormatDate(Date())
    WScript.Echo(&quot;strDate: &quot; &amp; strDate)
    WScript.Echo()

    WScript.Echo(&quot;Hello, WSH!&quot;)
    WScript.Echo()

    WScript.Echo(&quot;srcfile:&quot; &amp; strSrcFile)
    WScript.Echo(&quot;dstdir :&quot; &amp; strDstDir)
    WScript.Echo()

    Call Copy(strSrcFile, strDstDir)

    Main = 0
End Function

WScript.Quit(Main())</code></pre></noscript></div>

12 min.
