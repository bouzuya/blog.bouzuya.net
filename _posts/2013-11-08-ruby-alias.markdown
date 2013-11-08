---
layout: post
pubdate: "2013-11-08T23:59:59+09:00"
title: Ruby の alias の落とし穴
tags: ruby
pagetype: posts
---
Ruby の alias の落とし穴。落とし穴なんてのは普通落ちないもので、他人が落ちているのを見て笑うためにあると思っているし、事実そうである。

前置きはともかく、[icalendar/icalendar][icalendar/icalendar] にプルリクエスト [#44][icalendar/icalendar/pull/44]をした。もうマージされているようなので、そのうち RubyGems にもリリースされるだろう。くだらないバグだったのだけれど、どうなっているの一瞬分からなかったのでメモ。

バグはふたつある。

ひとつめは `attr_accessor` と alias のからみで分かりづらくなっている例。

<script src="https://gist.github.com/bouzuya/7374868.js"></script>

A.a も A.b も nil を返す。 :x を返しそうなものだけれど、b は a の alias で @a を読むので、@b に何を設定しても無駄だ。正しくはこう。@a に代入するだけ。

<script src="https://gist.github.com/bouzuya/7374939.js"></script>

もうひとつは、alias の設定である。`attr_accessor :a` の場合、`alias :b :a` しても `:b=` は定義されない。忘れず `alias :b= :a=` する必要がある。

普通そんなにハマらない気はするけど、たまにあるんだろうな。attribute に対して alias を設定する場合は注意した方が良いかもしれない。

15 min.

[icalendar/icalendar]: https://github.com/icalendar/icalendar
[icalendar/icalendar/pull/44]: https://github.com/icalendar/icalendar/pull/44

