---
layout: post
pubdate: "2012-08-04T01:33:35+09:00"
title: WSH(7)〜rotate-backup〜
tags: wsh
---
バックデート。さて、飽きてきたので、そろそろ完結する。

ファイルコピーと古いファイルを削除する機能を付けた。Copy/DeleteOldFiles関数がそれ。これで機能上はほぼ完成である。

<div><script src="https://gist.github.com/3249349.js?file=rotate-backup.vbs"></script><noscript><pre><code>Option Explicit

Private Function Main()
    If Not ValidateArguments() Then
        Main = 1
        Exit Function
    End If
    Dim strSrcFile, strDstDir
    strSrcFile = WScript.Arguments.Named.Item(&quot;srcfile&quot;)
    strDstDir = WScript.Arguments.Named.Item(&quot;dstdir&quot;)

    Dim strDstPath, strFileName
    strFileName = FormatDate(Date())
    strDstPath = PathCombine(strDstDir, strFileName)

    WScript.Echo(&quot;srcfile:&quot; &amp; strSrcFile)
    WScript.Echo(&quot;dstdir :&quot; &amp; strDstDir)
    WScript.Echo(&quot;dstpath:&quot; &amp; strDstPath)
    WScript.Echo()

    WScript.Echo(&quot;delete '&quot; &amp; strDstPath &amp; &quot;' if exists.&quot;)
    Call Delete(strDstPath)

    WScript.Echo(&quot;copy '&quot; &amp; strSrcFile &amp; &quot;' -&gt; '&quot; &amp; strDstPath &amp; &quot;'.&quot;)
    Call Copy(strSrcFile, strDstPath)

    WScript.Echo(&quot;delete old files '&quot; &amp; strDstDir &amp; &quot;'.&quot;)
    Call DeleteOldFiles(strDstDir, 7)

    Main = 0
End Function

WScript.Quit(Main())</code></pre></noscript></div>

ほとんど紹介できていないが、FileSystemObjectはWSHでファイル操作する上で中心となるオブジェクトである。それを使って今回のCopy関数などを作っている。CopyFileとCopyFolderをくっつけたようなものだ。今回の機能には別に必要ないのだけれど、何もないのも味気ないので、作ってみた。

それにしても使い勝手が悪い。VBScriptが部分的にSetを要求するうえ、オブジェクトの生成が面倒だからである。効率は悪いが都度生成している。メモリーリークするかは分からないけど、多少ならすぐ終了するし、問題ないだろう。

今回のやっつけFileSystemObjectライブラリーは次の通り。

<div><script src="https://gist.github.com/3249393.js?file=rotate-backup-fso.vbs"></script><noscript><pre><code>Option Explicit

Public Function PathCombine(ByVal strPath1, ByVal strPath2)
    Dim objFso
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    PathCombine = objFso.BuildPath(strPath1, strPath2)
End Function

Public Sub Copy(ByVal strSrcPath, ByVal strDstPath)
    Dim objFso
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    If objFso.FileExists(strSrcPath) Then
        Call objFso.CopyFile(strSrcPath, strDstPath)
    ElseIf objFso.FolderExists(strSrcPath) Then
        Call objFso.CopyFolder(strSrcPath, strDstPath)
    Else
        ' do nothing
    End If
End Sub

Public Sub Move(ByVal strSrcPath, ByVal strDstPath)
    Dim objFso
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    If objFso.FileExists(strSrcPath) Then
        Call objFso.MoveFile(strSrcPath, strDstPath)
    ElseIf objFso.FolderExists(strSrcPath) Then
        Call objFso.MoveFolder(strSrcPath, strDstPath)
    Else
        ' do nothing
    End If
End Sub

Public Sub Delete(ByVal strPath)
    Dim objFso
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    If objFso.FileExists(strPath) Then
        Call objFso.DeleteFile(strPath)
    ElseIf objFso.FolderExists(strPath) Then
        Call objFso.DeleteFolder(strPath)
    Else
        ' do nothing
    End If
End Sub

Public Function GetPaths(ByVal strDir)
    Dim objFso, objFolder, objFiles, objFile
    Set objFso = WScript.CreateObject(&quot;Scripting.FileSystemObject&quot;)
    Set objFolder = objFso.GetFolder(strDir)
    Set objFiles = objFolder.Files
    Dim objPaths(), i
    ReDim objPaths(objFiles.Count - 1)
    i = 0
    For Each objFile In objFiles
        objPaths(i) = objFile.Path
        i = i + 1
    Next
    GetPaths = objPaths
End Function

Public Function CloneArray(ByVal objArray)
    Dim objNewArray(), i
    ReDim objNewArray(UBound(objArray))
    For i = LBound(objArray) To UBound(objArray)
        objNewArray(i) = objArray(i)
    Next
    CloneArray = objArray
End Function

Public Function SortPaths(ByVal objPaths)
    Const vbBinaryCompare = 0, vbTextCompare = 1
    Dim objNewPaths, i, j
    objNewPaths = CloneArray(objPaths)
    For i = LBound(objNewPaths) To UBound(objNewPaths)
        For j = i + 1 To UBound(objNewPaths)
            If StrComp(objNewPaths(i), objNewPaths(j), vbBinaryCompare) &lt; 0 Then
                Dim strPath
                strPath = objNewPaths(i)
                objNewPaths(i) = objNewPaths(j)
                objNewPaths(j) = strPath
            End If
        Next
    Next
    SortPaths = objNewPaths
End Function

Public Sub DeleteOldFiles(ByVal strDir, ByVal intMaxCount)
    Dim objPaths, strPath, intCount
    objPaths = SortPaths(GetPaths(strDir))
    intCount = 0
    For Each strPath In objPaths
        intCount = intCount + 1
        If intCount &gt; intMaxCount Then
            Call Delete(strPath)
        End If
    Next
End Sub</code></pre></noscript></div>

うん。Copy/Move/Deleteあたりは再利用を意識したけれど、わざわざ再利用するほどのものでもないなあ。

最後に全体を示しておく。

[https://github.com/bouzuya/wsh-study/tree/5bc7764e2f3459ff356260baf12f39b4cf249b5d](https://github.com/bouzuya/wsh-study/tree/5bc7764e2f3459ff356260baf12f39b4cf249b5d)

もしかしたら、また整理するかもしれないけれど、ひとまず終了。あー眠い。

14 min.
