misakiのcompilerを作ってみた。Markdownはcontentの埋め込みに手間がかかりそうなので、ひとまずLESS compilerを作った。

[bouzuya/misaki-lesscss](https://github.com/bouzuya/misaki-lesscss)で公開した。

LESS Compiler for Javaを使ったmisaki compilerのサンプルと言った方が良いかも。まだmisakiの側が複数compilerに対応していないので、強引に処理をしている。対応されたら修正予定。

サンプルはないけど、使い方はシンプル。`template/less/main.css.less`のように配置すると、`public/css/main.css`ができる。以上。

5 min.
