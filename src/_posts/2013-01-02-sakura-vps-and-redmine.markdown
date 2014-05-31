---
layout: post
pubdate: "2013-01-02T23:29:56+09:00"
title: さくらVPSでRedmineを動かす
tags: [misc]
pagetype: posts
---
[Backlog][] にふれたことで、ぼくの中でのバグトラッキングシステム (BTS) がにわかに盛り上がっている。BTS についての知識や経験を得たいと考えている。

注目しているのは [Backlog][]/[Trac][]/[Redmine][] だ。Backlog は以前から書いているので今回は省く。Trac はすこしだけふれたことがあるが、使いにくくつまらないものという印象を受けている。Redmine もすこしだけふれたことがあるが、自分で構築したことはなかった。

そこで、今回はさくらVPS上に Redmine 環境を構築することにした。

とは言ったものの、実は『 [Redmine 2.2をCentOS 6.3にインストールする手順][redmine-installation-centos]』としてやり方が確立されており、ぼくはほとんど書かれている通りに実行した。一部パラメーターは変更したが特に問題もなく完了した。良い手順書である。

『[Redmineを使い始めるための初期設定][redmine-first-step]』もこなして初期設定もできた。放置していたさくらVPSも活用できて一石二鳥である。

あとから気付いたことには [BitNami][] や [ALMinium][] として配布されている All-in-one インストーラー ( インストーラーや VM イメージが配布されている) を使えば良かった気がする。

今後は、ドメインの取得やサーバー証明書の発行などを行なって、自分の Redmine を立てる予定である。これらも練習をかねている。2013 年は独自サービスをひとつはリリースしたいと考えている。そのための準備である。

20 min.

[Backlog]: http://www.backlog.jp/
[Trac]: http://trac.edgewall.org/
[Redmine]: http://www.redmine.org/
[redmine-installation-centos]: http://blog.redmine.jp/articles/2_2/installation_centos/
[redmine-first-step]: http://redmine.jp/tech_note/first-step/admin/
[BitNami]: http://bitnami.org/ja/stack/redmine
[ALMinium]: https://github.com/alminium/alminium

