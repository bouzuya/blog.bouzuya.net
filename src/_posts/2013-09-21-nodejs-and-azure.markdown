---
layout: post
pubdate: "2013-09-21T23:59:59+09:00"
title: Ubuntu に Windows Azure 向けの Node.js 環境を整える
tags: [javascript]
pagetype: posts
---
Ubuntu に Windows Azure 向けの Node.js 環境を整える。なんで Azure というつっこみはさておき、Ubuntu でやってみたくなったので試す。

まずは node をインストールする。apt で入れると 0.6.19 が入るみたい。Windows Azure では 0.6.17/0.6.20/0.8.4 が動くので、ソースからビルドしてインストールする。ちなみに Windows Azure でデフォルトの 0.6.20 をインストールする。

方法は [https://github.com/joyent/node/wiki/Installation][node-installation] を参照。

前提として必要なものを入れる。ぼくの環境では最初から整っていた。おそらく build-essentials と libssl-dev と git あたりを入れれば足りると思う。

    $ git clone https://github.com/joyent/node.git
    $ cd node
    $ git checkout v0.6.20
    $ ./configure && make && sudo make install

面倒なのでデフォルトのパスにインストール。/usr/local にインストールされたみたい。上々。

    $ which node
    /usr/local/bin/node
    $ node --version
    v0.6.20
    $ npm --version
    1.1.37

お次は Windows Azure のコマンドラインインタフェースをインストールする。これには npm を使う。

    $ sudo npm install azure-cli -g
    $ azure
    info:             _    _____   _ ___ ___
    info:            /_\  |_  / | | | _ \ __|
    info:      _ ___/ _ \__/ /| |_| |   / _|___ _ _
    info:    (___  /_/ \_\/___|\___/|_|_\___| _____)
    info:       (_______ _ _)         _ ______ _)_ _ 
    info:              (______________ _ )   (___ _ _)
    info:    
    info:    Windows Azure: Microsoft's Cloud Platform
    info:    
    info:    Tool version 0.7.1

npm は -g つけないとカレントディレクトリに `node_modules` ディレクトリつくってそこにインストールされる。控え目で素敵なパッケージマネージャーですね。

Windows Azure のアカウントは Web から取得してもらうとして、コマンドラインインタフェースの設定をしていく。検索すれば分かりそうだけど、コマンドでURLを確認する。ログインすればサブスクリプションがダウンロードできるはず。

    $ # Windows Azure のポータルを表示する
    $ azure portal
    info:    Executing command portal
    info:    Launching browser to http://go.microsoft.com/fwlink/?LinkId=254433

    $ # Windows Azure のサブスクリプションをダウンロードする
    $ azure account download
    info:    Executing command account download
    info:    Launching browser to http://go.microsoft.com/fwlink/?LinkId=254432
    help:    Save the downloaded file, then execute the command
    help:      account import <file>
    info:    account download command OK

    $ # Windows Azure のサブスクリプションをインポートする。ファイルの保存場所は任意。
    $ azure account import ~/Downloads/無料評価版-9-21-2013-credentials.publishsettings
    ...
    info:    account import command OK

これで Windows Azure の操作はバッチリ、クラウドサービスに PowerShell のコマンドレットみたいのでサクっとデプロイとかしていくかーとか張り切っていたのだけれど、どうやら、そういう操作は用意されていないみたいです。残念。

明日は Node.js で軽く遊ぶかな。

15 min.

[node-installation]: https://github.com/joyent/node/wiki/Installation
[node-on-azure-tutorial]: http://www.windowsazure.com/ja-jp/develop/nodejs/tutorials/getting-started/

