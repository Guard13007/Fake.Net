html = require "lapis.html"

class extends html.Widget
    content: =>
        html_5 ->
            head ->
                element "meta", charset: "UTF-8"
                --title @title or "Lapis Rage"
                element "link", rel: "stylesheet", href: "static/pure-min-0.6.0.css"
                style "
                    body {
                        margin: 0;
                        padding: 0;
                        background: #eee;
                        font-size: 1.4em;
                        font-family: Helvetica, Arial, sans-serif;
                    }
                    #sticky_header {
                        background: white;
                        border-bottom: 1px solid #ccc;
                        padding: 5px;
                        position: fixed;
                        left: 0;
                        top: 0;
                        width: 100%;
                    }
                    #container {
                        margin: 0 auto;
                        overflow: auto;
                        padding: 10px;
                        padding-top: 65px;
                        width: 900px;
                    }
                "
            body -> @content_for "inner"
