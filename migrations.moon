import create_table, drop_table, types from require "lapis.db.schema"

{
    [1]: =>
        create_table "test_users", {
            {"id", types.serial} --use types.id for MySQL
            {"name", types.varchar}

            "PRIMARY KEY (id)" --do not use for MySQL
        }

    [2]: =>
        drop_table "test_users"

        create_table "users", {
            {"id", types.serial} --all users have unique IDs
            {"name", types.varchar} --255 max length user
            {"icon", types.integer}

            {"created_at", types.time}
            {"updated_at", types.time}
        }

        create_table "posts", {
            {"id", types.serial} --all posts have unique IDs
            {"text", types.varchar} --all posts are limited to 255 characters
            {"user_id", types.foreign_key} --links to a user

            {"created_at", types.time}
            {"updated_at", types.time}
        }
}
