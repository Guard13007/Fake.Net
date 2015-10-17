html = require "lapis.html"

class HomepageLayout extends html.Widget
    content: =>
        html_5 ->
            head ->
                element "meta", charset: "UTF-8"
                title @title or "Tweaker"
                element "link", rel: "stylesheet", href: "static/pure-min-0.6.0.css"
                style "
                    body {
                        background: rgb(195, 205, 250);
                    }
                    #container {
                        margin: 0 auto;
                        overflow: auto;
                        padding: 10px;
                        padding-top: 65px;
                        width: 900px;
                    }
                    .box {
                        background: white;
                        border-radius: 0.5em;
                        /*border:1px solid rgb(190, 200, 240);*/
                    }
                    .inner {
                        padding: 0.55em;
                    }
                "
            body -> @content_for "inner"
