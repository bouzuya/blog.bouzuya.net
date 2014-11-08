---
layout: post
pubdate: "2012-08-20T23:45:27+09:00"
title: ClojureでMarkdownを使う
tags: [clojure]
minutes: 7
pagetype: posts
---
ClojureでMarkdownを使う。きっとClojure製のMarkdownパーサーはあるのだろうけど、今回はJavaのライブラリ[MarkdownJ](http://code.google.com/p/markdownj/)を使うことにした。簡単にしか使ってないけれど、これでぼくの目的は十分果たせそうなので良しとする。コード全体は[GitHubにclj-ex-mkdとして公開](https://github.com/bouzuya/clj-ex-mkd)している。

<div><script src="https://gist.github.com/3404829.js?file=core.clj"></script><noscript><pre><code>(ns clj-ex-mkd.core
  (:import (com.petebevin.markdown MarkdownProcessor)))

(defn markdown-to-html
  [markdown]
  (-&gt;
    (MarkdownProcessor.)
    (.markdown markdown)))

(defn read-markdown-file
  [file-name]
  (with-open [reader (clojure.java.io/reader file-name)]
    (markdown-to-html (apply str (interpose &quot;\n&quot; (line-seq reader))))))

(defn -main
  [&amp; args]
  (print (read-markdown-file &quot;./README.md&quot;)))</code></pre></noscript></div>

今回のゴールはJekyllからmisakiへの移行である。misakiでMarkdownを使えるように手を加え、過去の記事と執筆スタイルをなるべく維持しつつ、Clojureのスキルを高めるという一石二鳥じゃ物足りない人向けのプランである。さて、どうなることやら。

7 min.
