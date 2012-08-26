jQuery.noConflict();
jQuery(document).ready(function($) {
    var append_tweet_button = function() {
        var get_count = function(url, callback) {
            var u = "http://urls.api.twitter.com/1/urls/count.json?url=" + encodeURIComponent(url) + "&callback=?";
            $.getJSON(u, null, function(data) { callback(data.count); });
        };
        var get_href = function(url, title) {
            var u = "https://twitter.com/intent/tweet";
            u += "?hashtags=15mind";
            u += "&original_referer=" + encodeURIComponent(url);
            u += "&related=bouzuya";
            u += "&source=tweetbutton";
            u += "&text=" + encodeURIComponent(title);
            u += "&url=" + encodeURIComponent(url);
            return u;
        };
        var url = location.href; // "http://www.google.co.jp/"
        var title = document.title;
        get_count(url, function(count) {
            var button = $("#bouzuya-twitter-button");
            var href = get_href(url, title);
            var html = "<a href=\"" + href + "\" title=\"Twitterに投稿する\">T[" + count + "]</a>";
            button.append(html);
        });
    };

    var append_hatena_button = function() {
        var get_count = function(url, callback) {
            var u = "http://b.hatena.ne.jp/entry/json/?url=" + encodeURIComponent(url) + "&callback=?";
            $.getJSON(u, null, function(data) { callback(data == null ? 0 : data.count); });
        };
        var get_href = function(url, title) {
            return "http://b.hatena.ne.jp/entry/" + encodeURI(url);
        };
        var url = location.href;
        var title = document.title;
        get_count(url, function(count) {
            var button = $("#bouzuya-hatebu-button");
            var href = get_href(url, title);
            var html = "<a href=\"" + href + "\" title=\"はてなブックマークに投稿する\">B[" + count + "]</a>";
            button.append(html);
        });
    };
    append_tweet_button();
    append_hatena_button();
});


