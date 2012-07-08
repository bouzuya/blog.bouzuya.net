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
        month.css({textDecoration: "underline", color: "#35766c"});
        month.hover(function() {
            month.css({color: "#ffffff", backgroundColor: "#35766c", textDecoration: "none", cursor: "pointer"});
        }, function() {
            month.css({color: "#35766c", backgroundColor: "transparent", textDecoration: "underline", cursor: "default"});
        });
    });
});

