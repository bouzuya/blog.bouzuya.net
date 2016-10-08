[misaki](http://liquidz.github.com/misaki/)のcompilerを作っている。`.markdown->.html`するだけの動きを考えて作ったのだけれど、いまいちだ。

なぜなら出力されるのが`template/posts/*.markdown`をparseしただけのHTMLファイルだからだ。h1要素からはじまるイケてないHTMLが出力される。

parseしたHTMLを`template/layouts/post.html.clj`のcontentとしてうめこむのが良いのだろうけど、そのためにはタイトルやタグなどのメタ情報が必要だ。しかし、plainなMarkdownだとそのようなメタ情報を付けることができない。このメタ情報の付与を明日は考えたい。

16 min.
