---
layout: post
pubdate: "2012-07-16T21:49:56+09:00"
title: ssh_configを活かす
tags: [misc]
pagetype: posts
---
ぼくは普段からsshを使う。VirtualBox上で動いている我が家のUbuntuのほとんどはsshを使ってログインしているからだ。

ポートを既定値から変えているサーバーがあったり、GitHubのようにそのための鍵を別途用意していたりする。こういう既定値では対応できない場合は、`ssh -p 666`のようにコマンドラインオプションで明示したり、`alias sshhoge='ssh -i ~/.ssh/id_rsa.hoge hoge.org'`のようにaliasを設定していたのだけれど、どうやらこのための設定ファイルがあるようだ。

`man 5 ssh_config`を見るのが良いが、`~/.ssh/config`に設定を記述しておくことができる。例えば次のような設定を記述できる。

<div><script src="https://gist.github.com/3120203.js?file=config"></script><noscript><pre><code>Host 560
  HostName very.long.host.name
  User user560
  Port 560
  IdentityFile ~/.ssh/id_rsa.560</code></pre></noscript></div>

この設定であれば`ssh 560`で記述した設定に従って接続できる。長いホスト名などの際にもこの方法が使える。変更が不要なパラメーターについては省略できる。

aliasでも十分対応はできるのだけれど、`sshhoge`のような不自然な名前になってしまうし、せっかく機構として用意されているので、こちらを使っていこうと思う。

17 min.
