---
layout: post
pubdate: "2012-05-20T14:12:04+09:00"
title: Leiningenについて調べた
tags: [clojure]
minutes: 65
pagetype: posts
---
Leiningenについて調べたので記録しておく。

## Leiningenとは

LeiningenはClojureのプロジェクトまわりの雑務をこなすツールである。ビルドやテストや依存するライブラリの管理などをこなす。JavaにおけるMavenに近いものである。

前回はLeiningenを使ってClojureのREPL起動までを行っ。今回はもうすこし詳しくLeiningenを調べたいと思う。

## Leiningenのインストール

割愛する。GitHubから1.x系統を取得し、`lein`をPATHに設定しているものとする。今回の環境は次の通りである。

    $ lein version
    Leiningen 1.7.1 on Java 1.6.0_24 OpenJDK 64-Bit Server VM

`lein version`でLeiningenのバージョンを確認している。Leiningenではこのように`lein`のあとにタスクを指定して使用する。

## タスクの一覧やヘルプの表示〜lein help〜

最初に覚えるべきタスクは`help`である。`lein help [task]`で指定したタスクのヘルプを参照できる。タスクを指定しない場合は、タスクの一覧が表示される。`lein version`でインストールを確認できたら、`lein help`でタスクの一覧を確認すると良い。

    $ lein help
    Leiningen is a tool for working with Clojure projects.
    
    Several tasks are available:
    classpath   Print the classpath of the current project.
    clean       Remove compiled class files from project.
    compile     Compile Clojure source into .class files.
    deploy      Build and deploy jar to remote repository.
    deps        Download all dependencies and put them in :library-path.
    help        Display a list of tasks or help for a given task.
    install     Install the current project or download the project specified.
    interactive Enter interactive task shell.
    jar         Package up all the project's files into a jar file.
    javac       Compile Java source files.
    new         Create a new project skeleton.
    plugin      Manage user-level plugins.
    pom         Write a pom.xml file to disk for Maven interop.
    repl        Start a repl session either with the current project or standalone.
    retest      Run only the test namespaces which failed last time around.
    run         Run a -main function with optional command-line arguments.
    search      Search remote maven repositories for matching jars.
    test        Run the project's tests.
    test!       Run the project's tests after cleaning and fetching dependencies.
    trampoline  Run a task without nesting the project's JVM inside Leiningen's.
    uberjar     Package up the project files and deps into a jar file.
    upgrade     Upgrade Leiningen to specified version or latest stable.
    version     Print version for Leiningen and the current JVM.
    
    Run lein help $TASK for details.
    See also: readme, tutorial, copying, sample, deploying and news.

色々なタスクがあるようだ。タスク名とその説明からおおよそは理解できると思う。

## 新しいプロジェクトの作成〜lein new〜

`lein new [project-name]`は新しいプロジェクトを作成できる。次のようなファイルが生成される。

    $ cd
    $ lein new hello
    Created new project in: /home/user/hello
    Look over project.clj and start coding in hello/core.clj
    $ tree hello/
    hello/
    ├── project.clj
    ├── README
    ├── src
    │   └── hello
    │       └── core.clj
    └── test
        └── hello
            └── test
                └── core.clj
    
    5 directories, 4 files

`project.clj`はプロジェクト名や依存関係にあるライブラリなどを記載する。今回はエントリポイント(`:main`)だけを追加設定する。依存関係にあるライブラリの設定も非常に簡単に設定できるようになっている。

    $ cd hello/
    $ less project.clj
    (defproject hello "1.0.0-SNAPSHOT"
      :description "FIXME: write description"
      :dependencies [[org.clojure/clojure "1.3.0"]])
    $ vi project.clj
    $ less project.clj
    (defproject hello "1.0.0-SNAPSHOT"
      :description "FIXME: write description"
      :dependencies [[org.clojure/clojure "1.3.0"]]
      :main hello.core)

`src/`, `test/`の下にプロジェクト名に従ったファイルが生成される。

    $ less src/hello/core.clj
    (ns hello.core)
    
    $ vi src/hello/core.clj
    $ less src/hello/core.clj
    (ns hello.core
      (:gen-class))
    
    (defn msg [target]
      (format "Hello, %s!" target))
    
    (defn -main [& args]
      (println (msg (first args))))
    
    $ less test/hello/test/core.clj
    (ns hello.test.core
      (:use [hello.core])
      (:use [clojure.test]))
    
    (deftest replace-me ;; FIXME: write
      (is false "No tests have been written."))
    
    $ vi test/hello/test/core.clj
    $ less test/hello/test/core.clj
    (ns hello.test.core
      (:use [hello.core])
      (:use [clojure.test]))
    
    (deftest test-msg
      (is "Hello, Clojure!" (msg "Clojure")))

## コンパイルの実行〜lein compile〜

`lein compile`はコンパイルを実行する。依存関係にあるライブラリを自動で取得する。後述する`lein deps`で明示的に取得することもできる。

    $ lein compile
    Copying 1 file to /home/user/hello/lib
    Compiling hello.core
    Compilation succeeded.
    $ ls classes/hello/
    core.class  core__init.class  core$loading__4505__auto__.class  core$_main.class  core$msg.class

## テストの実行〜lein test〜

`lein test`はテストを実行する。`test/hello/test/core.clj`に記述したものである。

    $ lein test
    
    lein test hello.test.core
    
    Ran 1 tests containing 1 assertions.
    0 failures, 0 erros.

## プロジェクトの実行〜lein run〜

`lein run`はプロジェクトを実行する。事前にエントリポイントなどの設定が必要である。上記「新しいプロジェクトの作成〜lein new〜」で設定しているので、そちらを参照すること。

    $ lein run
    Hello, null!
    $ lein run Leiningen
    Hello,Leiningen!

## 依存関係にあるライブラリの取得〜lein deps〜

`lein deps`は依存関係にあるライブラリを取得する。project.cljの`:dependencies`に指定したファイルを`lib/`に保存する。このタスクを明示的に実行せずとも`lein compile`や`lein test`や`lein run`などを実行すると、自動で依存関係にあるライブラリが取得される。

    $ lein deps
    Copying 1 file to /home/user/hello/lib
    $ ls lib/
    clojure-1.3.0.jar

## REPLの実行〜lein repl〜

`lein repl`はREPLを起動する。依存関係にあるライブラリを自動でクラスパスに設定し、`src/hello/core.clj`を自動で読み込んでくれる。

    $ lein repl
    REPL started; server listening on localhost port 27036
    hello.core=> (-main)
    Hello, null!
    nil
    hello.core=> (-main "Clojure")
    Hello, Clojure!
    nil
    hello.core=>

## jarの作成〜lein uberjar〜

`lein uberjar`はjarファイルを作成できる。類似のタスクに`lein jar`がある。`lein jar`との違いは依存関係にあるライブラリをjarに格納し、スタンドアロン実行できる点である。

    $ lein uberjar
    Copying 1 file to /home/user/hello/lib
    Compiling hello.core
    Compilation succeeded.
    Created /home/user/hello/hello-1.0.0-SNAPSHOT.jar
    Including hello-1.0.0-SNAPSHOT.jar
    Including clojure-1.3.0.jar
    Created /home/user/hello/hello-1.0.0-SNAPSHOT-standalone.jar

## Mavenリポジトリからのライブラリの検索〜lein search〜

`lein search [keyword]`でMavenリポジトリからライブラリを検索できる、らしいがぼくは使っていない。

[Clojars](http://clojars.org/)で検索したものをproject.cljに貼り付けるだけで十分な気がしている。

## その他

今回紹介したほかにもpom.xmlを生成したり、リポジトリにデプロイしたり、プラグインを組み込んだりと機能はあるようだが、そこはもう誰かにお任せする。

Leiningenはもう2.xの開発が進められているので、そちらも気になるところ。ひとまずぼくはLeiningenを活用してClojureでのプログラム作成をスムーズに進められるようにしたいと思う。

65 min.
