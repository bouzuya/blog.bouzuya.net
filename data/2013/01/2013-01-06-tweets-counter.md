ツイート数などの情報をグラフ化したくなった。結果として公開リポジトリに [Tweets Counter][github-tweets-counter] を加え、[GitHub -> Hatena::Graph][github-to-hatena-graph] を改めた。

やりたいことの大まかな仕組みは、昨日の [GitHub Counter][github-github-counter] と同じである。まず情報を集め、CSV ファイルに書き込み、それをはてなグラフに送る。今回は情報の源が GitHub ではなく Twitter というだけだ。

[Tweets Counter][github-tweets-counter] は、ツイート/フォロー/フォロワー/お気に入りのそれぞれの数を CSV ファイルに書き込むコマンドラインユーティリティである。ソースコードは [bouzuya/clj-tweets-counter][github-tweets-counter] として公開している。

作ってみて、いくつかの課題があったのでメモしておく。

まずは Tweets Counter の課題。

最初はライブラリとして [clojure-twitter][clojure-twitter] を選び、書きはじめた。ところが clojure.contrib のせいかうまく動かず、諦めてライブラリを変えることにした。次は [twitter-api][twitter-api] を選び、書き直した。動くのだけれど、実行後に応答がなくなるので、これもダメ。最後に諦めて [Twitter4J][twitter4j] で書いた。さすがにこれは安定していて、期待通りに動いた。

Tweets Counter も GitHub Counter もそうだが、CSV ファイルに書き込むところまでをひとまとまりとしているが、そうではなく標準出力に書き込みを行い、それをシェルスクリプトでリダイレクトしてやるほうが扱いやすい。Clojure でのファイルの扱いの学習も兼ねてこうしているが、いつか直したい。

次に GitHub -> Hatena::Graph の課題。

こちらは GitHub Counter 向けに送るグラフが決め打ちになっていたので、properties ファイルで任意のグラフに切り換えられるように書きかえた。リソースとして埋め込むため、切り換えたあとにリビルドが要るが、ソースコードを書きかえるよりは易しいだろう。

動いた結果は、[ぼくのはてなグラフ][hatena-graph-bouzuya]に表示されるが、しばらくはデータのたまるのを待ったほうが良いだろう。

30 min.

[github-github-counter]: https://github.com/bouzuya/clj-github-counter
[github-tweets-counter]: https://github.com/bouzuya/clj-tweets-counter
[github-to-hatena-graph]: https://github.com/bouzuya/clj-github-to-hatena-graph
[clojure-twitter]: https://github.com/mattrepl/clojure-twitter
[twitter-api]: https://github.com/adamwynne/twitter-api
[twitter4j]: http://twitter4j.org
[hatena-graph-bouzuya]: http://graph.hatena.ne.jp/bouzuya/

