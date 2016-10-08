WSH(Windows Script Host)の第3回。今日は引数の扱いについて記録しておく。

引数の処理にはWshArgumentsオブジェクトを使うのが基本である。Argumentsオブジェクトは名前付き名前なしに関係なく、指定した順番で引数を得られる。名前付き引数の処理にはWshNamedオブジェクトを、名前なし引数の処理にはWshUnnamedオブジェクトを使う。今回は前回定めた仕様に従い、名前付き引数を扱う。

上記の通り、名前付き引数の処理にはWshNamedオブジェクトを使う。WshNamedオブジェクトにアクセスするためには、WScriptオブジェクトのArgumentsプロパティでWshArgumentsオブジェクトを得て、WshArgumentsオブジェクトのNamedプロパティでWshNamedオブジェクトを得る。日本語にすると分かりづらいが、コードにすると単純だ。

`WScript.Arguments.Named`

これだけのことだ。それぞれのオブジェクトが持つプロパティやメソッドについては、[WSHのオブジェクトのリファレンス](http://msdn.microsoft.com/ja-jp/library/cc364453)を参照すること。

説明が遅れたが、WScriptオブジェクトはWSHにおけるルートオブジェクトだ。インスタンス化なしに使える。出力や、オブジェクトの生成や、終了や、スクリプト自体の情報など、さまざまな用途で使う。引数処理のついでにWScriptオブジェクトのプロパティを一部出力してみた。

<div><script src="https://gist.github.com/3206580.js?file=rotate-backup.vbs"></script><noscript><pre><code>Option Explicit

Sub Main()
    Dim srcfile, dstdir
    If Not WScript.Arguments.Named.Exists(&quot;srcfile&quot;) Then
        WScript.Echo(&quot;srcfile is required.&quot;)
        WScript.Quit(1)
        Exit Sub
    End If
    srcfile = WScript.Arguments.Named.Item(&quot;srcfile&quot;)
    If Not WScript.Arguments.Named.Exists(&quot;dstdir&quot;) Then
        WScript.Echo(&quot;dstdir is required.&quot;)
        WScript.Quit(1)
        Exit Sub
    End If
    dstdir = WScript.Arguments.Named.Item(&quot;dstdir&quot;)

    WScript.Echo(&quot;Hello, WSH!&quot;)
    WScript.Echo()

    WScript.Echo(&quot;srcfile:&quot; &amp; srcfile)
    WScript.Echo(&quot;dstdir :&quot; &amp; dstdir)
    WScript.Echo()

    Call EchoWScriptProperties()

    WScript.Quit(0)
End Sub

Sub EchoWScriptProperties()
    WScript.Echo(&quot;WScript properties&quot;)
    WScript.Echo(&quot;WScript.Name          :&quot; &amp; WScript.Name)
    WScript.Echo(&quot;WScript.Version       :&quot; &amp; WScript.Version)
    WScript.Echo(&quot;WScript.Path          :&quot; &amp; WScript.Path)
    WScript.Echo(&quot;WScript.FullName      :&quot; &amp; WScript.FullName)
    WScript.Echo(&quot;WScript.Interactive   :&quot; &amp; WScript.Interactive)
    WScript.Echo(&quot;WScript.ScriptFullName:&quot; &amp; WScript.ScriptFullName)
    WScript.Echo(&quot;WScript.ScriptName    :&quot; &amp; WScript.ScriptName)
    WScript.Echo()
End Sub

Call Main()</code></pre></noscript></div>


    C:\Users\user\Dropbox>cscript //Nologo //Job:RotateBackup rotate-backup.wsf /srcfile:target.zip /dstdir:C:\Users\user\backup
    Hello, WSH!
    
    srcfile:target.zip
    dstdir :C:\Users\user\backup
    
    WScript properties
    WScript.Name          :Windows Script Host
    WScript.Version       :5.8
    WScript.Path          :C:\windows\system32
    WScript.FullName      :C:\windows\system32\cscript.exe
    WScript.Interactive   :True
    WScript.ScriptFullName:C:\Users\user\Dropbox\rotate-backup.wsf
    WScript.ScriptName    :rotate-backup.wsf

今日のところはここまで。はやくきれいなスクリプトを書けるようになれるといいなあ。楽しみながらやっていこう。

21 min.
