---
layout: post
pubdate: "2013-11-30T23:59:59+09:00"
title: HUBOTとSkypeとを連携させる
tags: [javascript ]
minutes: 12
pagetype: posts
---
[HUBOT][github/hubot]とSkypeとを連携させる。連携以前にHUBOTを導入してさえないのだけれど。

HUBOTについての正確な説明は公式にゆずるとして、ぼくの理解ではHUBOTは汎用BOT。任意のクライアントから仕事を指示し、その結果をクライアントに返す。そういうBOT。

BOTというと通常特定のサービスをターゲットにしていると思うのだけれど、HUBOTはadapterを使って様々なサービスにつなげることを想定している汎用BOT。例えば本家のGitHubではCampfireと連携させて使っているようだし、TwitterやSkypeやIRCなどとの連携ができるようだし、その他についてもadapterさえ書けば連携できるとうたっている。

GitHubではCampfire経由でデプロイなどをできるようにしているらしい。

オシャレな感じがしたので、さっそく取り入れることにした。普段はSkypeでやりとりしているので、[hubot-skype][netpro2k/hubot-skype]というadapterを使ってHUBOTとSkypeとを連携させた。Ubuntu12.04にSkypeをインストールし、それをhubot-skype(内部的にはSkype4Py経由)で操作する。せっかくなので専用のサーバーを設置した。サーバー用途だとGUIは要らないものなのだけれど、Skypeの都合でGUI(LXDE)を入れて、VNC経由でごちゃごちゃした。

解説もそのへんに転がっているので、大して苦労はしないと思う。

HUBOTの運用について考えているのだけれど、実際問題Jenkinsのscriptsの方がいまのところ重要度が高いので、せいぜいJenkinsのビルドURLを叩くくらいのことしかしないような。まあ、いいか。

12 min.

[github/hubot]: https://github.com/github/hubot
[netpro2k/hubot-skype]: https://github.com/netpro2k/hubot-skype
