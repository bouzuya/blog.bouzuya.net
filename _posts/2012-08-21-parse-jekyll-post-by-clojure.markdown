---
layout: post
pubdate: "2012-08-21T23:27:42+09:00"
title: ClojureでJekyllのpostを解釈する
tags: jekyll, clojure
---
今日も昨日に続き、[Jekyll](https://github.com/mojombo/jekyll)から[misaki](https://github.com/liquidz/misaki)への移行をはかる。

今日はJekyllのpostを解釈する。

Jekyllのpostの構造はふたつの部分からなる。ひとつはファイル先頭の[YAML](http://www.yaml.org/)で書かれたoptionであり、もうひとつはそれ以降に続く[Markdown](http://daringfireball.net/projects/markdown/)で書かれたcontentである。Markdownについては純粋なMarkdownではなく[Liquid](http://liquidmarkup.org/)により拡張されたMarkdownである。

今回は純粋なMarkdownであると仮定して、Jekyllのpostを解釈してみた。コード全体は[昨日と同様にclj-ex-mkdとしてGitHubに公開](https://github.com/bouzuya/clj-ex-mkd)している。

<div><script src="https://gist.github.com/3416052.js?file=core.clj"></script><noscript><pre><code>(defn load-jekyll-post-file
  [post-file]
  (let [text (slurp post-file)
        [_ yaml content] (re-find #&quot;(?m)(?s)^---\s*(.*?)^---\s*^(.*)&quot; text)]
    (reduce (fn [m [_ k v]] (assoc m (keyword k) v))
            {:content (markdown-to-html content)}
            (re-seq #&quot;(\w+):\s*(.*)\n&quot; yaml))))</code></pre></noscript></div>

戻り値は`{:tags "jekyll", :title "Jekyllを試す", :layout "post", :content "<p>test</p>"}`のようなClojureで扱いやすいmap形式だ。contentをHTMLとするかMarkdownのままとするか迷ったが、面倒なのでHTMLに変換してしまった。あとは複数行の正規表現にてこずった。普段はあまり使わないから、仕方ないのは確かだけど、情けない。

さて、すこしずつではあるが移行の準備は進んでいる。明日はenliveでlayout部分をさわってみようかな。

14 min.
