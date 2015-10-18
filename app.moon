lapis = require "lapis"

import respond_to from require "lapis.application"
import autoload from require "lapis.util"
views = autoload("views")

--import Users, Posts from require "models" --no idea if this is valid, might break everything!
Users = require "models.users"
Posts = require "models.posts"

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
                @error = "You need to enter a username."
                return render: views.error_message

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
                    @error = "User #{@params.username} does not exist."
                    render: views.error_message
    }

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
