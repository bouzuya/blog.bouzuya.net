ドットインストールで Rails 学習している。予定では 1 日動画 10 本ずつ。10 本と言っても 30 分くらい。「これならぼくにもできるよ」とお母さんに言いたくなる。 5 日で終わる。今日は 3 日目にあたる。

さて、今日は `config/routes.rb` をさわって root に特定の route を割り当てたり、記事の詳細を表示する show を実装したり、記事を追加する new / create を実装したり、 create で validation がかかるように model に validates を設定したりした。

routes 設定手軽。resource だけで良い感じに /show とか /new とか設定しておいてくれる。幸せである。

 ActiveRecords っていうのかな。 ORM の機能。Posts.all とか Posts.find とかするだけで良い感じに DB からデータを取ってこれる。

validates も良くできている。model に設定しておくだけで、きちんと validation かけて、エラーメッセージもとれる。

あと flash scope の変数とかも便利。

最近のフレームワーク(ASP.NET MVCなど)だと当たり前の機能ではあるけれど、当たり前のものが当たり前にあるのは良いね。そのうち不満が出るだろうけど、とりあえずは Rail に従って、その生産性の高さを感じたい。

14 min.

