Clojure 向けの Backlog API ライブラリを作っている([bouzuya/clj-backlog](https://github.com/bouzuya/clj-backlog))。0.2.0 に向けてしゅくしゅくと作っている。develop/0.2.0 ブランチを見れば進みが分かる。

ひとまず手軽に作れるところはひととおり作った。あとは [brehaut/necessary-evil](https://github.com/brehaut/necessary-evil) の直しが要るところとか、管理者向けのところとか、マックスプランのみのところとか、引数が多くて大変なところとか、そんなところ。

先は長いな。

得た Clojure の知識を覚え書き。Clojure での省略可能引数はぼくは次のように書くことにした。

    (defn add-version
      [project-id name & {:keys [start-date due-date]}]
      (call :backlog.addVersion
            (into {} (remove (comp nil? val)
                             {:project_id project-id
                              :name name
                              :start_date start-date
                              :due_date due-date}))))

`(add-version project-id name :due-date "20121231")` のように呼ぶ。どうかな。

`{:keys [key1 key2 ...]}` がみそ。`{:keys [key1 key2] :or [key1 \1 key2 \2]}` のようにデフォルト値も指定できるが、今回は `nil` で十分なので、指定していない。この `let` などで使える書き方っていつまで経っても覚えられないんだよなあ。

12 min.
