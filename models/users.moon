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
