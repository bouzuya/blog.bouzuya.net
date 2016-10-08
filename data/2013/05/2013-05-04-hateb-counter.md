先日の Java で書いたはてなブックマーク数をスクレイピングしたものを使って、はてなグラフに日次でポストするようにした。

色々ハマった。Eclipse から Git をうまく使えなかったり、Eclipse から Maven をうまく使えなかったり、Maven で実行可能な JAR ファイルを作れなかったり、Maven から依存関係を含んだ JAR ファイルを作れなかったり、JAR を実行してみたら動かなったり。まあ色々あった。解決策は Twitter やら、はてブやらに書いたので、もう書かない。課題として GnuPG での署名まわりは、もうすこし調べた方が良さそうだ。

とりあえず、[Hatena::Graph API wrapper for Clojure](https://clojars.org/org.clojars.bouzuya/hatena.graph) を 0.2.1 にした。そんでもって、はてなグラフに [Hatena Bookmark](http://graph.hatena.ne.jp/bouzuya/Hatena Bookmark) を増やしている。まだデータが少ないので美しくないけどね。

ほぼ毎日はてなブックマークを追加しているので、そこそこ良い感じのグラフが表示されて、ぼくを満足させてくれるはずだ。楽しみだなあ。

8 min.

