import Model from require "lapis.db.model"

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
