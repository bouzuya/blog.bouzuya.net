WSHの5回目。ここまで4回をかけてスクリプトを書いてきたのだけれど、ブログに貼り付けるには長くなりすぎてきた感がある。それにPadLeftなどの汎用的に使える部品などは切り出して再利用したいものだ。そこで、今回はVBScriptのExecuteGlobalステートメントを使って、外部ファイルに切り出そうと思う。

ExecuteGlobalステートメントは引数として渡された式をグローバルなスコープで評価してくれる。つまり文字列で持っているプロシージャを追加で定義できる。実際に活用するプロシージャが次のものだ。

<div><script src="https://gist.github.com/3221136.js?file=import.vbs"></script><noscript>
<pre><code>Public Sub Import(ByVal strFileName)
    Const ForReading = 1
    Dim objFso, objFile
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    Set objFile = objFso.OpenTextFile(strFileName, ForReading, False)
    ExecuteGlobal objFile.ReadAll()
    objFile.Close()
End Sub

Call Import(&quot;string.vbs&quot;)</code></pre></noscript></div>

このImportプロシージャは"string.vbs"を読み込み、評価する。

Importプロシージャを使ってrotate-backup.vbsを簡素化してみた。

<div><script src="https://gist.github.com/3221168.js?file=rotate-backup.vbs"></script><noscript>
<pre><code>Option Explicit

Public Sub Import(ByVal strFileName)
    Const ForReading = 1
    Dim objFso, objFile
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    Set objFile = objFso.OpenTextFile(strFileName, ForReading, False)
    ExecuteGlobal objFile.ReadAll()
    objFile.Close()
End Sub

Call Import(&quot;string.vbs&quot;)
Call Import(&quot;rotate-backup-arguments.vbs&quot;)
Call Import(&quot;rotate-backup-datetime.vbs&quot;)

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

    Main = 0
End Function

WScript.Quit(Main())</code></pre></noscript></div>

本来切り出す必要のない部分もあるけれど、ブログ掲載の都合で切り出している。また、これまでのスクリプト一式を[GitHubにまとめてみたので](https://github.com/bouzuya/wsh-study/tree/b0432b1d55f77e53a84a0f40a285e773b52bf0f9)参考にしてほしい。

13 min.
