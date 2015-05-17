---
layout: post
pubdate: "2013-01-01T23:10:09+09:00"
title: NPOI.DataSetExtensions を公開した
tags: [csharp, dotnet]
minutes: 27
pagetype: posts
---
[GitHub][] に [bouzuya/NPOI.DataSetExtensions][] を公開した。

アセンブリ `NPOI.DataSetExtensions` は `DataSet.WriteXls(fileName)`, `DataTable.WriteXls(fileName)` な拡張メソッドを提供する。`DataSet.WriteXml(fileName)` が XML ファイルに `DataSet` を書き出すのと同じように、XLS ファイルに `DataSet` を書き出すメソッドである。ヘッダー行や罫線などはなく、データを書き出す以上のことはしない。シンプルな機能にとどめている。

名前空間からも分かるとおり [NPOI][] を使った。NPOI は [Apache POI][] の .NET (CLR) 移植版である。EXCEL 2007 向けには Microsoft からライブラリ (OpenXMLSDK) が提供されているが、EXCEL 2003 向けには提供されていない。そこで今回は EXCEL 2003 ファイルを作るために NPOI を選んだ。

注意点としてメモリー使用量の問題がある。NPOI を使うにあたって性能の検証をしたのだが、どうも 256 列 65536 行だと書き出す前に OutOfMemoryException を投げてしまう。1 列 10000 行でもぼくの環境ではダメなようだ。解決策をさぐってみたが、POI が抱えている問題のようなので、そう簡単には対応できないだろう。環境によっても差が出る問題と思うので一概には言えないが、件数に注意して使うべきだろう。

ちなみに今回は統合開発環境には [MonoDevelop][] を使い、C# を使って書いている。このような画面などに依存しない DLL を作る用途だと MonoDevelop は必要十分な機能を備えているように思う。

27 min.

[bouzuya/NPOI.DataSetExtensions]: https://github.com/bouzuya/NPOI.DataSetExtensions
[GitHub]: https://github.com/
[NPOI]: http://npoi.codeplex.com/
[Apache POI]: http://poi.apache.org/
[MonoDevelop]: http://monodevelop.com/
