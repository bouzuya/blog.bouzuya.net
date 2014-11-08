---
layout: post
pubdate: "2012-08-29T23:29:55+09:00"
title: 2台目のJenkinsサーバー
tags: [jenkins]
minutes: 15
pagetype: posts
---
Jenkinsサーバーの二台目を置いた。

二台目を置いた理由は、Windows上に置いてバッチスクリプトを動かしたかったからだ。以前書いたWSH:Windows Script Hostのバックアップスクリプトは当然だけれどWindowsでしか動かない。リモートで実行させるのも手だけれど、せっかくだから複数のJenkinsを連携させてみたかったのだ。

Windows側にはJavaさえインストールしていなかったので、JRE7u6をインストール。Pathを通してjava.exeを実行できるようにした。

次にJenkinsのインストール。Jenkinsの公式サイトにアクセスし、jenkins.warの最新版をダウンロード。`java -jar jenkins.war`でさくさく起動。

せっかくWindows環境に入れるのでサービスとして動くようにしてみた。OSの再起動はしていないのでなんとも言えないけど、たぶん動くだろう。

ジョブについても、相変わらず分かりやすいインタフェースで、難なく設定を終えた。

Linux側Jenkinsがバックアップ対象のアーカイブを終えたら、Windows側JenkinsのWSH実行ジョブを`wget http://......`の形でキックする。実際にはWSHスクリプトを`git clone`してやったり、Windows側Jenkinsから参照可能な位置にそのファイルを配置したりしているが、全体の流れとしては上記の通りだ。

なんだろう、大げさにしている感が否めないけど、満足だ。

15 min.
