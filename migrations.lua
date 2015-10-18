local create_table, drop_table, types, rename_column, add_column
do
  local _obj_0 = require("lapis.db.schema")
  create_table, drop_table, types, rename_column, add_column = _obj_0.create_table, _obj_0.drop_table, _obj_0.types, _obj_0.rename_column, _obj_0.add_column
end
return {
  [1] = function(self)
    return create_table("test_users", {
      {
        "id",
        types.serial
      },
      {
        "name",
        types.varchar
      },
      "PRIMARY KEY (id)"
    })
  end,
  [2] = function(self)
    drop_table("test_users")
    create_table("users", {
      {
        "id",
        types.serial
      },
      {
        "name",
        types.varchar
      },
      {
        "icon",
        types.integer
      },
      {
        "created_at",
        types.time
      },
      {
        "updated_at",
        types.time
      }
    })
    return create_table("posts", {
      {
        "id",
        types.serial
      },
      {
        "text",
        types.varchar
      },
      {
        "user_id",
        types.foreign_key
      },
      {
        "created_at",
        types.time
      },
      {
        "updated_at",
        types.time
      }
    })
  end,
  [3] = function(self)
    rename_column("users", "name", "username")
    add_column("users", "name", types.varchar)
    return add_column("users", "email", types.varchar)
  end
}
