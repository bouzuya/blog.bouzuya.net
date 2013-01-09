---
layout: post
pubdate: "2013-01-09T23:01:04+09:00"
title: GitHub Pages がビルドしてくれない
tags: misc
pagetype: posts
---
GitHub Pages がビルドしてくれなくなった。

どうやら原因は `_config.yml` の `include: ./_includes` を解釈してくれなくなったらしい。理由は分からないけど、解釈してくれない。でも、指定しなくても `./_includes` を見てくれるので、記述をコメントアウトして対応した。

貴重な朝プロの時間をトラブル対応にとられてしまった。残念。

3 min.
