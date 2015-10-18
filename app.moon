lapis = require "lapis"
console = require "lapis.console"

import respond_to from require "lapis.application"
import autoload from require "lapis.util"
views = autoload("views")

Users = require "models.users"
Posts = require "models.posts"

class Tweaker extends lapis.Application
    @enable "etlua"
    @before_filter =>
        if @session.logged_in
            @app.layout = views.logged_in
        else
            @app.layout = views.homepage

    "/console": console.make!

    [index: "/"]: respond_to {
        GET: =>
            --TODO if logged_in, get user data
            render: true

        POST: =>
            -- switch to GET if logged_in
            if @session.logged_in
                @write redirect_to: @url_for "index" --TODO test that view is fixed appropriately

            -- make sure we're passed non-empty data
            if @params.username == ""
                @error = "You need to enter a username."
                return render: views.error_message
            if @params.email == ""
                @error = "You need to enter an email address."
                return render: views.error_message

            -- figure out what to do
            @user = Users\find username: @params.username
            if @user
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
                    --if user does not exist and passing email, register
                    @user = Users\create {
                        username: @params.username
                        name: "" --NOTE temporary default
                        email: @params.email
                        icon: 1 --NOTE temporary default
                    }
                    if not @user
                        @error = "Something went wrong while creating your account.<br><span style='font-weight:normal;'>Yell at the administrator.</span>"
                        return render: views.error_message

                    --now you're logged in too!
                    @session.logged_in = true
                    @session.username = @params.username
                    @write redirect_to: @url_for "index" --TODO make sure this works!
                else
                    --user doesn't exist, failed log in
                    @error = "User #{@params.username} does not exist."
                    render: views.error_message
    }

    [user: "/:user"]: =>
        @user = Users\find username: @params.user
        unless @user
            return redirect_to: @url_for "index"
            --TODO make this generate a new user and populate it then

        print @user.name
        print @user.id
        print @user.icon
        print @user.created_at
        print @user.updated_at
        render: true
