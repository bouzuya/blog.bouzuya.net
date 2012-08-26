---
layout: post
pubdate: "2012-03-26T22:36:16+09:00"
title: Vimでprefixキーを持つkey mappingについて
tags: vim
pagetype: posts
---
Vimでprefixキーを持つkey mappingについて書く。

Vimではkey mappingという機能がある。この機能は入力キーの動作を変更できる。例えば既定の動作ではノーマルモードでiキーを押したとき挿入モードに移るが、この動作が気に食わないならoキーの動作に変更できる。キーを別のキーの動作にするだけではなく、一連のキー操作にすることもできる。iキーを押したときに:execute 'help' expand('<cword>')のようなコマンドを実行できる。この機能は決まりきった動作を簡略化する上で非常に重要な機能である。

簡単な例を挙げる。

    " 1. 基本的なkey mapping
    nnoremap <Space>   <Nop>
    nnoremap <Space>w  :setlocal wrap!<C-m>
    nnoremap <Space>h  :nohlsearch<C-m>

3つのkey mappingを定義している。

+ ノーマルモードで「&lt;Space&gt;」を入力しても何もしないkey mapping
+ ノーマルモードで「&lt;Space&gt;w」を入力することで'wrap'を切り替えるkey mapping
+ ノーマルモードで「&lt;Space&gt;h」を入力することで:nohlsearchを実行するkey mapping

ノーマルモードの「&lt;Space&gt;」は「l」と同じ動作なので無くなっても困らない動作である。そこで&lt;Space&gt;キーをつぶしてprefixキーとして使い、&lt;Space&gt;に続くwキーとhキーに別の機能を割り当てている。

上記の例は改善できる。実際に動かしてみると分かるが、&lt;Space&gt;は入力しても入力されているのかどうかが確認しづらい。そこで次のような設定をすることで改善できる。

    " 2. <Space>を可視化する
    nnoremap [Space]   <Nop>
    nnoremap [Space]w  :setlocal wrap!<C-m>
    nnoremap [Space]h  :nohlsearch<C-m>
    nmap     <Space>   [Space]

この技法は「[Vim: &lt;Space&gt;で始まるkey mappingの可視化](http://whileimautomaton.net/2007/03/03205900)」で紹介されている。いち早くこの高みに到達している。さすがkana神である。

また、この技法には&lt;Space&gt;を可視化する以外の利点もある。「[Vim Hacks #59](http://vim-users.jp/2009/08/hack-59/)」で紹介されているとおり、「prefixキーを抽象化し明示できること」、「prefixキーの変更が容易になること」がこの方法の利点である。

&lt;Space&gt;だけに限らず、幅広くこの技法は適用できる。

実は上記の例をさらに改善できる。上記の例では「[Space]」というグローバルなkey mappingを設定しているためにkey mappingの定義によっては待ち時間が発生するという問題がある。そこで次のような設定をすることで改善できる。

    " 3. [Space]をscript-localに閉じ込める
    nnoremap          <SID>[Space]   <Nop>
    nnoremap          <SID>[Space]w  :setlocal wrap!<C-m>
    nnoremap          <SID>[Space]h  :nohlsearch<C-m>
    nnoremap <script> <Space>        <SID>[Space]

この技法は「[Vim Hacks #144](http://vim-users.jp/2010/05/hack-144/)」で紹介されている。<SID>を設定することでscript-localなkey mappingの定義ができる。こうすれば他のkey mappingとの衝突を心配する必要はない。

また最後のkey mappingで「script」オプションを使用している。これはkey mappingの右辺({rhs})で<SID>が使用されている場合に、その部分のみをremapする(noremapとは異なり再帰的にkey mappingを検索する)ようになる。

ここまでやれば十分なのだが中には怠け者が居る。怠け者はこう考えるのだ。「<SID>[Space]を何度も書くのがわずらわしい。くり返しは悪だ。」そこで、さらに高みを目指すVimmerには次のプラグインをおすすめする。

    " 4. prefixedmap.vimを使用する
    call prefixedmap#load()
    nnoremap <SID>[Space] <Nop>
    PrefixedMapBegin <SID>[Space]
      Pnnoremap w :setlocal wrap!<C-m>
      Pnnoremap h :nohlsearch<C-m>
    PrefixedMapEnd
    nnoremap <script> <Space> <SID>[Space]

「[prefixedmap](https://github.com/emanon001/prefixedmap.vim)」プラグインである。emanon001に書かれたプラグインであり、「[Vim でのプレフィックスキーを用いたキーマッピングの定義方法を改善する](http://emanon001.github.com/blog/2012/03/25/improve-key-mapping-using-prefix-key-in-vim/)」で紹介されている。詳細な説明はそちらを参照してほしい。

上記の例では、prefixキーに対して定義しているkey mappingが少ないため、余計に複雑になってしまう。しかし、この方法はprefixキーをコマンドごとにくり返し書く必要がないし、prefixキーの開始終了が明示され、より美しいだろう。(公開されたばかりのプラグインであり、「&lt;Nop&gt;」が醜いので、改善要望を出すつもりだ。)

現時点でぼくが知るprefixキーを使ったkey mappingについて書いた。参考にしてほしい。

55 min.
