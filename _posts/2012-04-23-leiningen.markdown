---
layout: post
pubdate: "2012-04-23T22:52:10+09:00"
title: とりあえずLeiningen〜5分ではじめるClojure REPL〜
tags: clojure
---
間違いながら前進すべし。Clojureの勉強について書いていく。とりあえず、昨日の勉強会で聞いたLeiningenでClojureのREPL起動まで5分でやってみた。やり方はベストじゃないかもしれないけれど、ひとまず動いたのでぼくの勝ちだ。

まずはGitHubからLeiningenをダウンロードする。ちなみに今回の手順で一番難しい箇所はGitHubのユーザー名technomancyを覚えておくことである。

    $ cd
    $ git clone git://github.com/technomancy/leiningen

次に`lein self-install`を使ってお手軽インストールする。最新のものだと依存関係にあるライブラリが含まれていないぽい。ちゃんと見てないけど……。とりあえず今回は「動けば良し」「短時間」が目標なので割愛する。

    $ cd leiningen/
    $ git checkout 1.x
    $ ./bin/lein self-install

色々表示されてインストール完了。`~/.lein/`に何か保存されているみたいだけど、気にしない。

せっかくなのでPATHを通しておく(とは言え一時的なものなので環境変数には設定せず、シェル変数のみ設定する。

    $ PATH=$PATH:~/leiningen/bin/

最後にプロジェクト作って、REPL起動して、おしまい。

    $ lein new test
    $ cd test/
    $ ls
    project.clj README src/ test/
    $ lein repl
    REPL started; server listening on localhost port 37354
    user=> "Hello, Clojure!"
    "Hello, Clojure!"
    user=> 

ちなみにapt-get使った方が断然早い。1.1と1.2しかパッケージ化されていないみたいだけど……。

    $ sudo apt-get install clojure
    $ clojure
    Clojure 1.1.0
    user=> 

あとClojureってもともと単一のjarファイルだし、インストールなんて言うほどのことも元々ないはず。ソースからインストールしてもJavaやAnが要るくらいのはず……。

Leiningenをちゃんと使うのはまたそのうち。

15 min.
