import Model from require "lapis.db.model"

class Users extends Model
    @primary_key: {"id", "username"}
    @timestamp: true

    @constraints: {
        username: (value) =>
            if #value > 255
                "Username cannot be more than 255 characters"
            elseif Users\find username: value
                "That username is already taken"
        name: (value) =>
            if #value > 255
                "Name cannot be more than 255 characters"
        email: (value) =>
            if #value > 255
                "Email cannot be more than 255 characters"
        icon: (value) =>
            --TODO needs to verify the file exists on server
            return false --NOTE temporary until I come up with a verification / file upload system,
                        --      and by that, I mean learn how to use Lapis to do those things
    }
    @relations: {
        {"posts", has_many: "Posts"}
    }

    --@url_params: (req, ...) =>
    --    "/", {name: @name}, ...         --NOTE not 100% sure this is correct, TODO TEST THIS
    --    "/", {username: @username}, ... --NOTE !?!!?
