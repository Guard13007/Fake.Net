html = require "lapis.html"

class HomepageLayout extends html.Widget
    content: =>
        html_5 ->
            head ->
                element "meta", charset: "UTF-8"
                title @title or "Lapis Rage"
                element "link", rel: "stylesheet", href: "static/pure-min-0.6.0.css"
            body -> @content_for "inner"
