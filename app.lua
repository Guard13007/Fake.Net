local lapis = require("lapis")
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
    "name"
  }
  self.timestamp = true
  self.constraints = {
    name = function(self, value)
      if value.len() > 255 then
        local _ = "Username cannot be more than 255 characters"
      end
      if Users:find({
        name = value
      }) then
        return "That username is already taken"
      end
    end,
    icon = function(self, value) end
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
end
local Posts
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
    __name = "Posts",
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
  self.timestamp = true
  self.constraints = {
    text = function(self, value)
      if value.len() > 255 then
        return "Tweaks cannot be more than 255 characters"
      end
    end
  }
  self.relations = {
    {
      "user",
      belongs_to = "Users"
    }
  }
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Posts = _class_0
end
local App
do
  local _parent_0 = lapis.Application
  local _base_0 = {
    layout = require("views.layout"),
    [{
      index = "/"
    }] = function(self)
      return {
        render = true
      }
    end,
    [{
      user = "/:user"
    }] = function(self)
      local user = Users:find({
        name = self.params.user
      })
      if not (user) then
        return {
          render = "index"
        }
      end
      print(user.name)
      print(user.id)
      print(user.icon)
      print(user.created_at)
      print(user.updated_at)
      return {
        render = "index"
      }
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "App",
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
  self:enable("etlua")
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  App = _class_0
  return _class_0
end
