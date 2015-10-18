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
local lapis = require("lapis")
local respond_to
respond_to = require("lapis.application").respond_to
local autoload
autoload = require("lapis.util").autoload
local views = autoload("views")
local Tweaker
do
  local _parent_0 = lapis.Application
  local _base_0 = {
    [{
      index = "/"
    }] = respond_to({
      GET = function(self)
        return {
          render = true
        }
      end,
      POST = function(self)
        if self.session.logged_in then
          self:write({
            redirect_to = self:url_for("index")
          })
        end
        if self.params.username == "" then
          self.error = "YOU NEED ENTER A USERNAME DAMMIT )" .. self.params.username .. "("
          return {
            render = views.user_does_not_exist
          }
        end
        self.user = Users:find({
          name = self.params.username
        })
        if user then
          if self.params.email then
            return self:write({
              status = 403
            }, "User " .. tostring(self.params.username) .. " already exists.")
          else
            self.session.logged_in = true
            self.session.username = self.params.username
            return self:write({
              redirect_to = self:url_for("index")
            })
          end
        else
          if self.params.email then
            print("fuck me")
            return self:write("TEST CONFIRMED")
          else
            self.error = "BLAH"
            return {
              render = views.user_does_not_exist
            }
          end
        end
      end
    }),
    [{
      user = "/:user"
    }] = function(self)
      local user = Users:find({
        name = self.params.user
      })
      if not (user) then
        return {
          redirect_to = self:url_for("index")
        }
      end
      print(user.name)
      print(user.id)
      print(user.icon)
      print(user.created_at)
      print(user.updated_at)
      return {
        render = true
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
    __name = "Tweaker",
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
  self:before_filter(function(self)
    if self.session.logged_in then
      self.app.layout = views.logged_in
    else
      self.app.layout = views.homepage
    end
  end)
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  Tweaker = _class_0
  return _class_0
end
