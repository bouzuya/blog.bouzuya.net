---
layout: post
pubdate: "2013-09-23T23:20:38+09:00"
title: Amazon Command Line Interface で Amazon EC2 インスタンスを操作する
tags: [aws]
pagetype: posts
---
Amazon Command Line Interface で Amazon EC2 インスタンスを操作する。はじめ『Amazon EC2 API Tools を使って Amazon EC2 インスタンスをコマンドラインから操作する』を書こうと思った。[http://aws.amazon.com/developertools/351][amazon-ec2-api-tools] からそれらの情報を得ることができる。書こうと思ったのだけれど、いまならもっと手軽に [AWS Command Line Interface][aws-cli] で同じことができそうなので、そちらを採用することにした。

まず、やりたいことを書く。

やりたいことは Jenkins から Amazon EC2 インスタンスを操作することだ。Jenkinsから操作すべき環境はひとつとは限らない。環境はいろいろある。Java/Clojure/Ruby/JavaScript etc. だが、それらの環境をひとつを共存させるのはしばしばトラブルの原因になる。だから複数の環境を動作させるインスタンスが必要だ。もちろん、Jenkins には元々分散ビルドの機能が備わっている。インスタンスを複数起動しておき、それらをスレーブとして扱うことは容易い。だが、EC2インスタンスを常時起動するのは高くつく。そこで、今回の要求が生まれたわけだ。必要なときだけインスタンスを起動し、不要になったら停止する。

今回は Amazon EC2 に用意されている AMI から Ubuntu 12.04 LTS を使って試す。

まずは Python をインストールする。Ubuntu 12.04 には初期で入っている。

    $ python --version
    Python 2.7.3

次に [pip][pip] をインストールする。厳密には setuptools をインストールしないといけないが、apt が合わせてインストールしてくれる。が、その前に `apt-get update` しておいたほうが良い気がする。

    $ sudo apt-get update
    $ sudo apt-get install python-pip -y

AWS Command Line Interface をインストールする。`/usr/local` とかに入るので `sudo` 。

    $ sudo pip install awscli

AWS Command Line Interface を設定する。いろいろな方法で設定できるのだけれど、今回は環境変数で設定する。きっと機能ごとに設定は違うのだろうけど、ぼくが今回やりたいことに最低限必要なものを挙げる。

事前準備として、IAM : Identity and Access Management で十分な権限を持ったグループを作成して、そこに所属するユーザーを作成して、Credential を取得しておくこと。あとは次のように環境変数に設定しておくだけ。めんどうなら `.bash_profile` やら `.bashrc` につっこんでもいいし、(xはそれぞれ上記のユーザーのCredentialを設定する)

    $ export AWS_DEFAULT_REGION=ap-northeast-1
    $ export AWS_ACCESS_KEY_ID=xxxxxxxxxxxxxxxxxxxx
    $ export AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

これで準備は完了。あとはコマンドを叩くだけ。ためしにインスタンスの一覧を取りたいなら。

    $ aws ec2 describe-instances

JSON で各インスタンスの状態が表示されます。

今回のお目当てのインスタンスの起動はこんな感じ。(i-xxxxxxxxには対象のインスタンスIDを設定する)

    $ aws ec2 start-instances --instance-ids i-xxxxxxxx

これを Jenkins のジョブとして登録して、hogehoge っと。そのへんは面倒なので割愛。とりあえず、こんなとこかな。node に戻ろっと。

30 min.

[amazon-ec2-api-tools]: http://aws.amazon.com/developertools/351
[aws-cli]: http://aws.amazon.com/jp/cli/
[pip]: https://pypi.python.org/pypi/pip
[pip-ref1]: http://d.hatena.ne.jp/rudi/20110107/1294409385

