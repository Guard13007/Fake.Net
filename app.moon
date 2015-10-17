lapis = require "lapis"

class extends lapis.Application
    @enable "etlua"
    layout: require "views.layout"

    [index: "/"]: =>
        render: true
