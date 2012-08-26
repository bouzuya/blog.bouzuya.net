---
layout: post
pubdate: "2012-02-19T17:51:50+09:00"
title: はてなブログにPythonでポストする
tags: jekyll,python
pagetype: posts
---
今日ははてなブログにPythonでポストするスクリプトを書いた。

先日からGitHubでブログを書いている。GitHubで使われているJekyllは自由が効くし、ぼくには使いやすい。一方で「はてなブログ」ではじめたこともあって、こちらを読んでくださる方も居る。どちらも大切にしたい。だけど両方に毎日コピーして載せるのも面倒だ。

そこで両方に一度に投稿できるようにプログラムを書くことにした。

名前は「hatenablogger.py」とした。いい名前が思い浮かばなかったのでblogを書くならbloggerでいいやといういいかげんな気持ちからである。

Jekyllで直近の記事だけをファイルに出力するようにしておき、それをPythonスクリプトで読み出してはてなブログに自動的に投稿する仕組みである。かんたんな仕組みである。しかし今回利用したプログラミング言語Pythonはほとんどはじめて書いたこともあって、そこそこてこずった。

次に詳細を示す。

Jekyllで直近の記事を出力する部分は、タイトル(2行目)と本文(4行目以降)をテキストファイルに出力しておくだけのものである。ローカルでJekyllを動かして確認することを前提にしている。ぼくのためのものなのでこれで十分である。次のようなファイルを置くだけでかんたんにできる。

    ---
    layout: nil
    ---
    {{ "{" }}% for post in site.posts limit:1 %}
    {{ "{" }}{ post.title }}
    
    {{ "{" }}{ post.content }}
    {{ "{" }}% endfor %}

Pythonスクリプトではてなブログに投稿する部分は、自動でWebアクセスするためにmechanizeモジュールを使っている。mechanizeはコマンドひとつでインストールできた。

    easy_install mechanize

また、設定ファイルからはてなIDやパスワードなどを取得している。設定ファイルは~/.hatenabloggerという名前で置いている。名前にこだわりはない。

    [config]
    hatenaid=bouzuya
    password=??????????
    blogdomain=bouzuya.hatenablog.com
    latestpost=/home/user/bouzuya.github.com/_site/latest

短いプログラムなのでここにそのまま掲載する。

{% highlight python %}
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import re
import mechanize
import ConfigParser

def read_entry(path):
    pattern = re.compile('^\s*$')
    is_start = False
    f = open(path, 'r')
    lines = f.readlines()
    f.close()
    return [lines[1], "\n".join(lines[3:])]

def post_hatenablog(username, password, domain, title, body):
    browser = mechanize.Browser()
    
    # login
    browser.open('https://www.hatena.ne.jp/login')
    browser.select_form(nr=0)
    browser.form['name'] = username
    browser.form['password'] = password
    browser.submit()
    
    # post 
    url = 'http://blog.hatena.ne.jp/%s/%s/edit' % (username, domain)
    browser.open(url)
    browser.select_form(nr=0)
    browser.form["title"] = title
    browser.form["body"] = body
    browser.submit()

config = ConfigParser.SafeConfigParser()
config.read([os.path.expanduser('~/.hatenablogger')])
(title, body) = read_entry(config.get('config', 'latestpost'))
post_hatenablog(
        config.get('config', 'hatenaid'),
        config.get('config', 'password'),
        config.get('config', 'blogdomain'),
        title,
        body)
{% endhighlight %}

はじめてのPythonだったけど、きちんと動くものができた。なにかをつくるって楽しいなあ。

30 min.
