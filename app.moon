import Model from require "lapis.db.model"

class Users extends Model
    @primary_key: {"id", "name"}
    @timestamp: true

    @constraints: {
        name: (value) =>
            if value.len! > 255
                "Username cannot be more than 255 characters"
            if Users\find name: value
                "That username is already taken"
        icon: (value) =>
            --TODO needs to verify the file exists on server
    }
    @relations: {
        {"posts", has_many: "Posts"}
    }

    --@url_params: (req, ...) =>
    --    "/", {name: @name}, ... --NOTE not 100% sure this is correct, TODO TEST THIS

class Posts extends Model
    @timestamp: true

    @constraints: {
        text: (value) =>
            if value.len! > 255
                "Tweaks cannot be more than 255 characters"
    }
    @relations: {
        {"user", belongs_to: "Users"}
    }

    --@url_params: (req, ...) =>
    --    @url_for user, { id: @id }, ...

lapis = require "lapis"

import autoload from require "lapis.util"
views = autoload("views")

class App extends lapis.Application
    @enable "etlua"
    @before_filter =>
        if @session.logged_in
            @app.layout = views.logged_in --require "views.logged_in"
        else
            @app.layout = views.homepage --require "views.homepage"

    [index: "/"]: =>
        render: true

    [user: "/:user"]: =>
        user = Users\find name: @params.user
        unless user
            return redirect_to: @url_for "index"
            --TODO make this generate a new user and populate it then

        print user.name
        print user.id
        print user.icon
        print user.created_at
        print user.updated_at
        render: true
