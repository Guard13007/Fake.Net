import Model from require "lapis.db.model"

--TODO add email key, change name key to username, add name key
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

import respond_to from require "lapis.application"
import autoload from require "lapis.util"
views = autoload("views")

class Tweaker extends lapis.Application
    @enable "etlua"
    @before_filter =>
        if @session.logged_in
            @app.layout = views.logged_in
        else
            @app.layout = views.homepage

    [index: "/"]: respond_to {
        GET: =>
            --TODO if logged_in, get user data
            render: true

        POST: =>
            if @session.logged_in
                @write redirect_to: @url_for "index" --TODO test that view is fixed appropriately

            if @params.username == ""
                @error = "YOU NEED ENTER A USERNAME DAMMIT )" .. @params.username .. "("
                return render: views.user_does_not_exist
                --<h3>User <%= params.username %> does not exist.</h3>

            @user = Users\find name: @params.username
            if user
                if @params.email
                    --if passing email and user exists, fail to register
                    @write status: 403, "User #{@params.username} already exists."
                else
                    --if user exists and we didn't pass email, this is a log in
                    @session.logged_in = true
                    @session.username = @params.username
                    @write redirect_to: @url_for "index" --TODO check this works!
            else
                if @params.email
                    print "fuck me"
                    --if user does not exist and passing email, register
                    --TODO register new user!
                    @write "TEST CONFIRMED"
                else
                    --user doesn't exist, failed log in
                    --status: 404, "User #{@params.username} does not exist."
                    @error = "BLAH"
                    render: views.user_does_not_exist
                --redirect_to: @url_for "index" --TODO test view is fixed!
            --unless user
            --if user and not
            --    @write ""
            --    --TODO display error, then redirect? (fall through?)
            --elseif @session.logged_in
            --    --TODO display error, then redirect? (fall through?)
            --else
            --    --TODO handle logging in or account creation

            --redirect_to: @url_for "index"
            --NOTE Will this pull the correct view if they are logging in? Or do I need to set it as well?
    }
    -- =>
    --    render: true

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
