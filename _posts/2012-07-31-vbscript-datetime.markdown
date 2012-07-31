---
layout: post
pubdate: "2012-07-31T21:09:06+09:00"
title: WSH(4)〜VBScriptにおけるDateTime〜
tags: wsh
---
WSHの4回目。今日は日付の扱いと、命名規則をガイドラインに準拠させることについて記録しておく。どちらもWSHというよりはVBScriptの範囲である。

まずは日付の扱いについて。VBScriptで、現在の日付を得るにはDate関数を使う。現在の時刻を得るにはNow関数を使う。その他にも日時を取り出す関数や差を得る関数などが用意されている。詳細は[VBScriptランゲージリファレンス](http://msdn.microsoft.com/ja-jp/library/cc392480)を参照すること。

文字列に整形するための関数にはFormatDateTimeがあるけど、用意されている形式が足りない。システム設定に影響されるし、初期設定だとコロンやスラッシュで区切られてしまうので使いづらい。

諦めて自作する。ハイフン区切りで先頭をゼロ埋めして桁数を合わせてほしい。printfみたいのがあれば一発で片付くのに……と不満をこぼしつつ、汎用で使えそうなPadLeft関数を作り、それを使って今回の目的に合わせたFormatDate関数を作る。できたものは次のような感じ。

<div><script src="https://gist.github.com/3216635.js?file=rotate-backup.vbs"></script><noscript><pre><code>Option Explicit

Private Function ValidateArguments()
    If Not WScript.Arguments.Named.Exists(&quot;srcfile&quot;) Then
        WScript.Echo(&quot;srcfile is required.&quot;)
        ValidateArguments = False
        Exit Function
    End If
    If Not WScript.Arguments.Named.Exists(&quot;dstdir&quot;) Then
        WScript.Echo(&quot;dstdir is required.&quot;)
        ValidateArguments = False
        Exit Function
    End If
    ValidateArguments = True
End Function

Private Sub EchoDateTimeFunction()
    WScript.Echo(&quot;Echo VBScript Date/Time Function result&quot;)
    Dim dtmToday, dtmNow
    dtmToday = Date()
    WScript.Echo(&quot;Date()         :&quot; &amp; dtmToday)
    WScript.Echo(&quot;Year(today)    :&quot; &amp; Year(dtmToday))
    WScript.Echo(&quot;Month(today)   :&quot; &amp; Month(dtmToday))
    WScript.Echo(&quot;Day(today)     :&quot; &amp; Day(dtmToday))
    WScript.Echo(&quot;Weekday(today) :&quot; &amp; Weekday(dtmToday))
    Select Case Weekday(dtmToday)
        Case vbSunday
            WScript.Echo(&quot;Sunday sun sun&quot;)
        Case vbMonday
            WScript.Echo(&quot;Monday mon mon&quot;)
        Case vbTuesday
            WScript.Echo(&quot;Tuesday tue tue&quot;)
        Case vbWednesday
            WScript.Echo(&quot;Wednesday wed wed&quot;)
        Case vbThursday
            WScript.Echo(&quot;Thursday thu thu&quot;)
        Case vbFriday
            WScript.Echo(&quot;Friday fri fri&quot;)
        Case vbSaturday
            WScript.Echo(&quot;Saturday sat sat&quot;)
        Case Else
            WScript.Echo(&quot;Invalid Weekday&quot;)
    End Select
    dtmNow = Now()
    WScript.Echo(&quot;Now()       :&quot; &amp; dtmNow)
    WScript.Echo(&quot;Hour(now)   :&quot; &amp; Hour(dtmNow))
    WScript.Echo(&quot;Minute(now) :&quot; &amp; Minute(dtmNow))
    WScript.Echo(&quot;Second(now) :&quot; &amp; Second(dtmNow))
End Sub

Private Function PadLeft(ByVal strValue, ByVal intTotalLength, ByVal strPadding)
    Dim strResult
    strResult = strValue
    While Len(strResult) &lt; intTotalLength
        strResult = strPadding &amp; strResult
    Wend
    PadLeft = strResult
End Function

Private Function FormatDate(ByVal dtmDate)
    Dim strYear, strMonth, strDay
    strYear = CStr(Year(dtmDate))
    strMonth = PadLeft(CStr(Month(dtmDate)), 2, &quot;0&quot;)
    strDay = PadLeft(CStr(Day(dtmDate)), 2, &quot;0&quot;)
    FormatDate = strYear &amp; &quot;-&quot; &amp; strMonth &amp; &quot;-&quot; &amp; strDay
End Function

Private Function Main()
    If Not ValidateArguments() Then
        Main = 1
        Exit Function
    End If
    Dim strSrcFile, strDstDir
    strSrcFile = WScript.Arguments.Named.Item(&quot;srcfile&quot;)
    strDstDir = WScript.Arguments.Named.Item(&quot;dstdir&quot;)

    Call EchoDateTimeFunction()
    Dim strDate
    strDate = FormatDate(Date())
    WScript.Echo(&quot;strDate: &quot; &amp; strDate)

    WScript.Echo(&quot;Hello, WSH!&quot;)
    WScript.Echo()

    WScript.Echo(&quot;srcfile:&quot; &amp; strSrcFile)
    WScript.Echo(&quot;dstdir :&quot; &amp; strDstDir)
    WScript.Echo()

    Main = 0
End Function

WScript.Quit(Main())</code></pre></noscript></div>

出力結果はこんな感じ。

    C:\Users\user\Dropbox\wsh>cscript //Nologo //Job:RotateBackup rotate-backup.wsf /srcfile:target.zip /dstdir:C:\Users\user\backup
    Echo VBScript Date/Time Function result
    Date()         :2012/07/31
    Year(today)    :2012
    Month(today)   :7
    Day(today)     :31
    Weekday(today) :3
    Tuesday tue tue
    Now()       :2012/07/31 21:32:04
    Hour(now)   :21
    Minute(now) :32
    Second(now) :4
    strDate: 2012-07-31
    Hello, WSH!
    
    srcfile:target.zip
    dstdir :C:\Users\user\backup

今回は、上記の日付処理のほか、関数に切り出すなどのリファクタリングや、命名規則をガイドラインに準拠させてある。

ガイドラインはぼくが見るかぎりあまり好きになれないものだ。ハンガリアン記法などは書いていてうんざりする。[とは言え、それが標準とMSDNにある](http://msdn.microsoft.com/ja-jp/library/cc392255)ので従っておく。郷に入ってはなんとやらだ。それに、型のサポートが弱く、大文字小文字を区別しないVBScriptではそれなりに有効性があるかもしれない。似ているからと言ってVisual Basic 7.0以降(.NET FrameworkのVisual Basic)では選択してほしくない規則なのは間違いない。(余談だけど、[実際.NET向けのガイドラインではハンガリアン記法を禁止するように書いてある](http://msdn.microsoft.com/ja-jp/library/ms229045)。)

それぞれの考え方にとりあえず合わせてみて、どうしても合わなければ考える。一度は受け入れてみることが大事だと思う。やり直しが効くことだしね。

23 min.
