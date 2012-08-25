---
layout: post
pubdate: "2012-08-13T20:09:24+09:00"
title: WMIクエリーを投げるスクリプト
tags: wmi
---
WMIスクリプト入門の1〜3部を読み終えた。ざっとだけれど。

- [WMIスクリプト入門:第1部](http://msdn.microsoft.com/ja-jp/library/ms974579)
- [WMIスクリプト入門:第2部](http://msdn.microsoft.com/ja-jp/library/ms974592)
- [WMIスクリプト入門:第3部](http://msdn.microsoft.com/ja-jp/library/ms974547)

読み終えたことで、WMIクエリーを投げてクラスのプロパティを読み取れば良いことくらいは分かった。ほかにも例の[WMI Fun!!](http://www.wmifun.net/)や[Creating a WMI Script](http://msdn.microsoft.com/en-us/library/windows/desktop/aa389763)などを見た。読んだではなく見た。

SWbemLocatorで特定のサーバーに接続して、SWbemServicesを取得する。SWbemServicesにWMIクエリーを投げると、SWbemObjectSetが得られる。名前の通りSWbemObjectSetはSWbemObjectの集合なので、For Eachなどで各SWbemObjectを取り出してやる。SWbemObjectから任意のプロパティを取得することで、欲しい情報を取得する。何のことやらと言った感じだが、おおよそこの流れで間違いない。

試しにスクリプトを書いてみた。

スクリプト全体は[wsh-wmi-study](https://github.com/bouzuya/wsh-wmi-study)という名前でGitHubに公開した。以下にコアな部分のみを抜き出したものを示す。

<div><script src="https://gist.github.com/3339759.js?file=wmi-properties.vbs"></script><noscript><pre><code>Option Explicit

Private Function GetNamedArguments(ByVal strName, ByVal strDefault)
    If WScript.Arguments.Named.Exists(strName) Then
        GetNamedArguments = WScript.Arguments.Named.Item(strName)
    Else
        GetNamedArguments = strDefault
    End If
End Function

Private Function FormatProperty(ByVal objProperty)
    Dim strMessage
    strMessage = &quot;&quot;
    strMessage = strMessage &amp; PadRight(objProperty.Name, 32, &quot; &quot;)
    strMessage = strMessage &amp; &quot; : &quot;
    If objProperty.IsArray Then
        If IsNull(objArray) Then
            strMessage = strMessage &amp; &quot;&quot;
        Else
            strMessage = strMessage &amp; Join(objArray, &quot;,&quot;)
        End If
    Else
        strMessage = strMessage &amp; objProperty.Value
    End If
    FormatProperty = strMessage
End Function

Private Sub EchoArguments(ByVal strServer, ByVal strNamespace, ByVal strClassName, ByVal strPropertyName)
    Dim strArgs
    strArgs = &quot;&quot;
    strArgs = strArgs &amp; &quot;Query info&quot; &amp; vbCrLf
    strArgs = strArgs &amp; &quot;  Server       : &quot; &amp; strServer &amp; vbCrLf
    strArgs = strArgs &amp; &quot;  Namespace    : &quot; &amp; strNamespace &amp; vbCrLf
    strArgs = strArgs &amp; &quot;  ClassName    : &quot; &amp; strClassName &amp; vbCrLf
    strArgs = strArgs &amp; &quot;  PropertyName : &quot; &amp; strPropertyName &amp; vbCrLf
    WScript.Echo(strArgs)
End Sub

Private Sub EchoProperties(ByVal strServer, ByVal strNamespace, ByVal strClassName, ByVal strPropertyName)
    Dim strQuery
    strQuery = &quot;SELECT * FROM &quot; &amp; strClassName
    Dim objLocator, objServices, objObjectSet, objObject, objProperty, intIndex
    Set objLocator = WScript.CreateObject(&quot;WbemScripting.SWbemLocator&quot;)
    Set objServices = objLocator.ConnectServer(strServer, strNamespace)
    Set objObjectSet = objServices.ExecQuery(strQuery)
    intIndex = 0
    For Each objObject In objObjectSet
        Dim strMessage
        strMessage = &quot;[&quot; &amp; CStr(intIndex) &amp; &quot;]&quot; &amp; vbCrLf
        For Each objProperty In objObject.Properties_
            If strPropertyName = &quot;&quot; Or _
                InStr(1, objProperty.Name, strPropertyName, vbBinaryCompare) &gt; 0 Then
                strMessage = strMessage &amp; FormatProperty(objProperty) &amp; vbCrLf
            End If
        Next
        WScript.Echo(strMessage)
        intIndex = intIndex + 1
    Next
End Sub

Function Main()
    ' Get arguments
    Dim strServer, strNamespace, strClassName, strPropertyName
    strServer = GetNamedArguments(&quot;Server&quot;, &quot;.&quot;)
    strNamespace = GetNamedArguments(&quot;Namespace&quot;, &quot;root\cimv2&quot;)
    strClassName = GetNamedArguments(&quot;ClassName&quot;, &quot;&quot;)
    strPropertyName = GetNamedArguments(&quot;PropertyName&quot;, &quot;&quot;)

    ' Check arguments
    If strClassName = &quot;&quot; Then
        WScript.Echo(&quot;ClassName is required.&quot;)
        Main = 1
        Exit Function
    End If

    Call EchoArguments(strServer, strNamespace, strClassName, strPropertyName)
    Call EchoProperties(strServer, strNamespace, strClassName, strPropertyName)

    Main = 0
    Exit Function
End Function

WScript.Quit(Main())</code></pre></noscript></div>

引数で渡されたクラスのプロパティを一覧表示するスクリプトである。省略可能引数で表示する対象を絞り込むことができる。wmicコマンドでできそうな気はするが、まあいいだろう。

28 min.
