---
layout: post
pubdate: "2013-02-03T23:16:58+09:00"
title: VNOTE reader for Clojure をアップデートした
tags: [clojure]
minutes: 25
pagetype: posts
---
[bouzuya/clj-vnote][clj-vnote] を [0.2.0][clj-vnote-0.2.0] にアップデートした。

Quoted-Printable の parse を直して `CR` `LF` 以外も正しく読めるようにした。

ただ Galaxy S II ( SC-02C ) のメモアプリが出力する VNOTE の Quoted-Printable は [RFC2045][rfc2045] で定義されている Quoted-Printable とはずいぶん異なる。気づいている点をメモしておくと次の通り。

1. 1 行 76 文字の制限がない。改行が入らず、ソフト改行もない。
2. ASCII 範囲外の文字もエンコードされない。日本語などもそのまま表示される。

要するに Galaxy S II の VNOTE の Quoted-Printable は `:` と `CR` と `LF` を出現させないためのエンコードであって、それ以上の意味はない、たぶんだけど。上記の文字を避ける必要があるのは VNOTE というフォーマットにおいて、それが特別な意味を持つ文字だから。

ぼく個人的には BASE64 のほうが好きなんだけどな。

あと、今日はもう 1 点。 [Jenkins][jenkins] から [Leiningen][leiningen] を使ってみた。特に難しいことではなくて、`jenkins` という別ユーザーに Leiningen をインストールするだけ。ちなみに環境は Ubuntu 11.10 に `apt-get` で Jenkins をインストールしている。

    $ sudo su jenkins
    $ wget -O ~/bin/lein https://raw.github.com/technomancy/leiningen/stable/bin/lein
    $ chmod 755
    $ lein

これで `/var/lib/jenkins/.lein/` に self-installs やらなんやらがインストールされる。

Jenkins 側の設定としては「システム設定」から「環境変数」に「HOME=/var/lib/jenkins」を追加しておく。これをしていないと `/.lein/` などの見当違いの場所にファイルを探しに行ってしまう。

[公式に設定も記載されている](https://github.com/technomancy/leiningen/wiki/Jenkins)ので、そちらも参照。

25 min.

[clj-vnote]: https://github.com/bouzuya/clj-vnote/
[clj-vnote-0.2.0]: https://github.com/bouzuya/clj-vnote/tree/0.2.0
[rfc2045]: http://www.ietf.org/rfc/rfc2045.txt
[leiningen]: http://leiningen.org/
[jenkins]: http://jenkins-ci.org/

