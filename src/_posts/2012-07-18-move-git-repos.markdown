---
layout: post
pubdate: "2012-07-18T23:32:42+09:00"
title: gitのマスターリポジトリの引越し
tags: [misc]
pagetype: posts
---
gitのマスターリポジトリをSambaサーバー上の共有ディレクトリに移動し、それをマウントして、見せるようにした。

`sudo apt-get install cifs-utils`でcifsをインストールして、`sudo mount -t cifs //samba/shared /mnt/smb/ -o user=user`で手動マウントするのも良いのだけれど、さすがにサーバーがそれだとまずいので`/etc/fstab`に記述した。

<div><script src="https://gist.github.com/3136324.js?file=gistfile1"></script><noscript><pre><code>//samba/shared/repos/git	/repos	cifs	user=user,password=password	0	0</code></pre></noscript></div>
こうしといて、あとは`sudo mount /repos`、次回以降は起動時にマウントされる。

意外と設定ファイルのちょっとした書きかたを忘れる。なんとかならないかなあ、慣れか、そもそも覚える必要がないか。

20 min.
