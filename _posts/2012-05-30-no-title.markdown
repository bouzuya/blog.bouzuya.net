---
layout: post
pubdate: "2012-05-30T21:49:14+09:00"
title: Hello, Android!
tags: android
---
今日は「Hello, Andoird!」した。Androidのための開発環境を構築した。来週の土曜日の『[Androidハッカソン@大阪](http://atnd.org/events/28658)』に向けた準備である。環境構築のための手順は他のWebページを見てもらうとして、構成をメモしておく。

- Windows 7 Home (Host OS)
- VirtualBox 4.1.14
- Ubuntu 12.04 desktop 32bit (Guest OS)
- OpenJDK 6
- Eclipse 3.7.2
- Android 2.3.3 (API 10)

Androidのバージョンが最新でないのは、手持ちの携帯電話(Galaxy S II)に合わせている。OpenJDKは`apt-get install eclipse`したところ入ってしまったもの。

ハマった点はUbuntu。はじめはUbuntuを64bitでインストールしたのだけれど、AVD(Android Virtual Device)が何やら安定しなかったので32bitに変えた。仮想マシンは良い。VirtualBoxで動かしていると手軽にOSを変えられるし、失敗しても環境を汚さないので良い。

正直、Androidアプリケーションの構成が全然分からない。急がないと間に合わないなあ。

15 min.
