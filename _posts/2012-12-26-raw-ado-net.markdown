---
layout: post
pubdate: "2012-12-26T00:56:02+09:00"
title: 生のADO.NETのコードサンプル
tags: ado.net
pagetype: posts
---
遅いのがまずいなら、早くすれば良いのではないか。連続して今日の分の記録。

生の ADO.NET での INSERT 文のサンプル。元ページのコメントも参照。

<div><script src="https://gist.github.com/4374051.js?file=gistfile1.cs"></script><noscript><pre><code>var providerName = &quot;Npgsql&quot;;
var connectionString = &quot;Server=db.bouzuya.jp;Port=5432;User Id=postgres;Password=postgres;Database=mydb&quot;;
var sql = &quot;INSERT INTO users(username,password) VALUES(:username, :password)&quot;;
var parameters = new Dictionary&lt;string, object&gt;() { {&quot;username&quot;, &quot;bouzuya&quot;}, {&quot;password&quot;, &quot;password&quot;} };
var factory = DbProviderFactories.GetFactory(providerName);
using (var connection = factory.CreateConnection ()) {
	connection.ConnectionString = connectionString;
	connection.Open ();
	using (var transaction = connection.BeginTransaction ()) {
		try {
			int result;
			using (var command = connection.CreateCommand ()) {
				command.Connection = connection;
				command.Transaction = transaction;
				command.CommandType = CommandType.Text;
				command.CommandText = sql;
				foreach (var parameter in parameters) {
					var p = command.CreateParameter();
					p.ParameterName = parameter.Key;
					p.Value = parameter.Value;
					command.Parameters.Add (p);
				}
				result = command.ExecuteNonQuery ();
			}
			transaction.Commit ();
			return result;
		} catch {
			transaction.Rollback ();
			throw;
		}
	}
}
</code></pre></noscript></div>

10 min.
