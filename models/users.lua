local Model
Model = require("lapis.db.model").Model
local Users
do
  local _parent_0 = Model
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "Users",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.primary_key = {
    "id",
    "username"
  }
  self.timestamp = true
  self.constraints = {
    username = function(self, value)
      if #value > 255 then
        return "Username cannot be more than 255 characters"
      elseif Users:find({
        username = value
      }) then
        return "That username is already taken"
      end
    end,
    name = function(self, value)
      if #value > 255 then
        return "Name cannot be more than 255 characters"
      end
    end,
    email = function(self, value)
      if #value > 255 then
        return "Email cannot be more than 255 characters"
      end
    end,
    icon = function(self, value)
      return false
    end
  }
  self.relations = {
    {
      "posts",
      has_many = "Posts"
    }
  }
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Users = _class_0
  return _class_0
end
