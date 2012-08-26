---
layout: post
pubdate: "2012-08-22T21:33:33+09:00"
title: enliveでHTMLを生成する
tags: clojure
pagetype: posts
---
[昨日はJekyllのpostを解釈し、Clojureのmapに変換した](http://bouzuya.github.com/2012/08/21/parse-jekyll-post-by-clojure.html)。今日はこのmapを使って、今度は独自のHTMLを生成する。

テンプレートとなるHTMLを用意しておき、そこにmapから必要なデータを取得し埋めてやる。この動作にはClojure製テンプレートエンジンである[enlive](https://github.com/cgrand/enlive)を使う。enliveは[以前にも紹介したライブラリ](http://bouzuya.github.com/2012/06/18/try-enlive.html)である。

流れを整理すると、次のようになる。

    Jekyllのpost(既存の日記データ)
    |
    | (option(YAML),content(Markdown)を解釈. Markdown->HTML by MarkdownJ)
    |
    V
    Clojureのmap
    |
    | (テンプレートに埋め込み by enlive)
    |
    V
    HTML

最終的にはこの動きを[misaki](https://github.com/liquidz/misaki)のcompilerとして組み込めればと考えている。ただテンプレートとしてHTMLを要求するenliveの動作はmisakiのhiccupベースの動作とうまくとけあわないかもしれない。そもそもmisakiではファイル中に関数を書けるので、ファイルにこの動作をする関数を埋め込むだけでかたがつくかもしれない。最悪misakiベースのオレオレ静的Blogジェネレーターを作ることになるだけで、大した違いはない。

さて、今日のコードはこんな感じ。全体は[bouzuya/clj-ex-mkd](https://github.com/bouzuya/clj-ex-mkd/tree/e0c22ade7fa934e0ab1483f1af88e9a43999c0da)としてGitHubに公開している。enliveを普通に使っているくらいで、特に面白いところはない。Jekyllのpostが扱いやすい状態になっているおかげであとは好き勝手はめこむだけ。実際にはもうすこし凝ったことをやらないと実用的ではないが、これでも見れる形には変換される。

<div><script src="https://gist.github.com/3425273.js?file=core.clj"></script><noscript><pre><code>(ns clj-ex-mkd.core
  (:require [clojure.java.io :as io]
            [net.cgrand.enlive-html :as eh])
  (:import (com.petebevin.markdown MarkdownProcessor)))

(defn markdown-to-html
  [markdown]
  (-&gt;
    (MarkdownProcessor.)
    (.markdown markdown)))

(defn load-jekyll-post-file
  [post-file]
  (let [text (slurp post-file)
        [_ yaml content] (re-find #&quot;(?m)(?s)^---\s*(.*?)^---\s*^(.*)&quot; text)]
    (reduce (fn [m [_ k v]] (assoc m (keyword k) v))
            {:content (markdown-to-html content)}
            (re-seq #&quot;(\w+):\s*(.*)\n&quot; yaml))))

(def LAYOUT_FILE &quot;./template/layouts/post.html&quot;)
(def JEKYLL_POST_FILE &quot;./template/posts/2012-02-16-jekyll.markdown&quot;)

(eh/deftemplate post-html (io/file LAYOUT_FILE)
  [post]
  [:title] (eh/content (:title post))
  [:article :header :h1] (eh/content (:title post))
  [:article :div.post-body] (eh/html-content (:content post)))

(defn -main
  [&amp; args]
  (let [data (load-jekyll-post-file JEKYLL_POST_FILE)
        compiler #(apply str (post-html %))]
    (print (compiler data))))</code></pre></noscript></div>


テンプレートはこんな感じ。シンプルなHTML5によるマークアップである。

    <!DOCTYPE HTML>
    <html lang="ja">
    <head>
        <meta charset="UTF-8">
        <title>test</title>
    </head>
    <body>
        <article class="post">
            <header class="post-header">
                <h1 class="post-title">post-title</h1>
            </header>
            <div class="post-body"></div>
        </article>
    </body>
    </html>

Jekyllのpost(一部抜粋)はこんな感じ。pubdateがbouzuya.github.comの独自仕様だけど、それくらいかな。

    ---
    layout: post
    pubdate: '2012-02-16T15:50:06+09:00'
    title: Jekyllを試す
    tags: jekyll
    ---
    今日は[Jekyll][jekyll]を試した。今日からはGitHub Pages(Jekyll)でブログを書こうと思う。

出力結果は、こうなる(一部省略)。

    <!DOCTYPE HTML>
    <html lang="ja">
    <head>
        <meta charset="UTF-8" />
        <title>Jekyllを試す</title>
    </head>
    <body>
        <article class="post">
            <header class="post-header">
                <h1 class="post-title">Jekyllを試す</h1>
            </header>
            <div class="post-body"><p>今日は<a href="http://jekyllrb.com/">Jekyll</a>を試した。今日からはGitHub Pages(Jekyll)でブログを書こうと思う。</p>
    </div>
        </article>
    </body>
    </html>

いい感じに埋め込まれているのが分かるはず。この調子で進めばmisakiと仲良くなれる日も遠くないな。

- [bouzuya/clj-ex-mkd](https://github.com/bouzuya/clj-ex-mkd)
- [cgrand/enlive](https://github.com/cgrand/enlive)
- [liquidz/misaki](https://github.com/liquidz/misaki)

20 min.
