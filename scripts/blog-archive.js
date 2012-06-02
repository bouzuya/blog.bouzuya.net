jQuery(document).ready(function($){
    var posts = $(".posts li");
    var root = $(document.createElement("ul")).addClass("root");
    var prev = null;
    var ul = null;
    posts.each(function() {
        var curr = $(this).children(".pubdate").text().substring(0, 7);
        if (prev != curr) {
            prev = curr;
            ul = $(document.createElement("ul"));
            ul.hide();
            var li = $(document.createElement("li"))
            li.append($(document.createElement("span")).addClass("month").text(curr));
            li.append(ul);
            li.click(function() {
                $(this).children("ul").toggle();
            });
            root.append(li);
        }
        ul.append(this);
    });
    $(".posts").before(root);
    $(".month").each(function() {
        var month = $(this);
        month.text(month.text() + "(" + $(this).parent().find("li").size() + ")");
        month.css({textDecoration: "underline", color: "#3366ff"});
        month.hover(function() {
            month.css({backgroundColor: "#ffcc33", cursor: "pointer"});
        }, function() {
            month.css({backgroundColor: "transparent", cursor: "default"});
        });
    });
});

