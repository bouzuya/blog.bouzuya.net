---
layout: post
pubdate: "2012-06-28T23:53:37+09:00"
title: VimClojureでLeiningenの遅さを避ける
tags: clojure, vim
---
Leiningenの起動が遅いという問題をVimClojure(NailGunを内包)で解決できた。Leiningenの起動を速くできたわけではないけれど、LeiningenでしていたことVimClojureだと速くできるので問題を解決できた次第である。

VimClojureはVimのプラグインである。一般的なVimプラグインとは異なり、クライアントとサーバーとを持つ。サーバーがなくてもClojureのファイルタイププラグインとして動作する。

しかし、ポイントはVimClojureのサーバーである。NailGunを含んだサーバーであり、REPLの起動などにおいて高速に動作する。もともとぼくはNailgunを検討していた。NailGunはJavaを常駐させることで起動をなくし高速化をはかる。しかし、ClojureやLeiningenやVimなどツール間での連携対応が面倒そうだったので断念した経緯がある。

それをうまく解決できるような形でツール類があったので、今日はそれらの導入手順を示す。(時間の都合でコマンドの羅列になっている)

    # git
    sudo apt-get install git
    
    # java
    sudo apt-get install openjdk-7-jre-headless
    
    # VimClojure(Vim Script)のインストール
    # 割愛する。こんな感じでどうぞ。
    # 
    # NeoBundle 'vim-script/VimClojure'
    #

    # Nailgun Clientのインストール
    wget https://bitbucket.org/kotarak/vimclojure/get/tip.tar.gz
    tar zxf tip.tar.gz
    # make, gcc はNailgun Clientのインストールに必要
    sudo apt-get install gcc make
    cd client
    make
    mv ng ~/.vim/bundle/VimClojure/bin/
    ln -s ~/.vim/bundle/VimClojure/bin/ng ~/bin/ng

    # Leiningen
    # Clojureのビルド等を行うツール。お約束。
    # lein new [project-name] でプロジェクト作ったり
    # lein test でテストしたり、
    # プラグインで拡張したりできる
    wget https://raw.github.com/technomancy/leiningen/preview/bin/lein
    mv lein ~/bin/
    chmod 755 ~/bin/lein
    lein help

    # lein-tarsier
    # Leiningenのプラグイン。
    # VimClojureサーバーをLeiningenから起動できるように
    # lein vimclojure を追加する。
    # VimClojureサーバーを手軽にインストールできる。
    cat > ~/.lein/profiles.clj <<EOT
    {:user {:plugins [[lein-tarsier "0.9.1"]]}}
    EOT
    lein new hello
    cd hello/
    lein

    # 使ってみる
    # バックグラウンドでVimClojureサーバーを起動する
    lein vimclojure &
    # VimでClojureのファイルを開く
    vim project.clj
    # あとは\sr(*1)でREPL立ち上げたり、
    # \rtでテスト走らせたりする。

もうすこし使いこんでから追加で報告する。

20 min.

