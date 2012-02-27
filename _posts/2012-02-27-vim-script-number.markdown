---
layout: post
pubdate: "2012-02-27T20:30:19+09:00"
title: ':help script-local'
tags: vim
---
Vimにおけるスクリプトローカルとは何かを調べた。

きっかけは'statusline'を設定していて「%!」という記法を知ったことだ。`:help 'statusline'`によると%!は次のように使用する。

    :set statusline=%!MyStatusLine()

ここで関数`MyStatusLine`は%{}を含む文字列を返してもよく、きちんと評価された結果になるらしい。なかなか面白そうな機能ではあるが、次の2つの問題がある。

1. MyStatusLineのスコープ
2. MyStatusLineの名前

ぼくはなるべく関数をスクリプトローカルにしたいし、関数を`lowercase_with_underscore`の形で名前付けしている。試しに次のように設定してみる。

    :set statusline=%!s:my_status_line()

するとE120というエラーが発生する。スクリプト以外では`s:`を使えないというエラーだ。じゃあ`<SID>`が使えるかというとそれもダメだ。まずは`<SID>`を調べることにした。`:help <SID>`を実行すると`<SID>`がどう動作するのかが説明されている。

`<SID>NAME`とあると`<SNR>\d\+_NAME`の形に展開される。これによりスクリプトローカル(s:)な関数を外部から参照することができる。つまりスクリプトローカル(s:)とは通常では定義できない`<SNR>\d\+_...`の形で関数を定義しているにすぎない。`\d\+`さえ分かれば外部からでも参照できるのである。この`\d\+`がSNR=script numberであり、これは:scriptnamesやスクリプト内であれば次のような関数で確認することができる。

    function s:SID()
      return matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
    endfun

そこで自分なりにscript number関連の関数を作ってみた。

<script src="https://gist.github.com/1923109.js?file=sid.vim">
</script>

`s:snr()`は同一スクリプト内であれば有用である。`:help <SID>`にあるs:SID()と同様の動作をする。`\d\+`部分はSIDというよりはscript numberだろうと考えて`s:snr()`に改名した。

`s:sid()`は`<SID>`と同様の感覚で使える文字列を返す。展開されたあとの`<SNR>\d\+_`の形式で返してくれるので外部から参照する必要がある関数についてはこれを使うと良い。冒頭に挙げた'statusline'の問題はこの関数で解決である。`<SID>`をマッピングで書くのと似た形になる。

    let &statusline = '%!' . s:sid() . 'my_status_line()'

`s:parse_script_names()`は:scriptnamesをparseする。`[{'snr': snr, 'path': path}, { ... } ...]`の形で返してくれる。`s:path_to_snr()`を作成する際にできたユーティリティである。

`s:path_to_snr()`は`s:snr()`の汎用版である。`s:snr()`が同一スクリプト内でなければ使えないのに対し、`s:path_to_snr()`はpath(scriptname)さえ分かればどこからでも使える。任意のスクリプトのscript numberを取得できる。

車輪の再発明に違いないけど、これらの関数の作成を通じて、Vimにおける「スクリプトローカル」の動作について理解が進んだ。また関数の作成にあたっては元同僚の[@emanon001](https://twitter.com/#!/emanon001)に多くのヒントをいただいた。ありがとう、えまのんわん。

    :help script-local

42 min.
