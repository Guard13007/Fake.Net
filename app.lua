local lapis = require("lapis")
local console = require("lapis.console")
local respond_to
respond_to = require("lapis.application").respond_to
local autoload
autoload = require("lapis.util").autoload
local views = autoload("views")
local Users = require("models.users")
local Posts = require("models.posts")
local Tweaker
do
  local _parent_0 = lapis.Application
  local _base_0 = {
    ["/console"] = console.make(),
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
          self.error = "You need to enter a username."
          return {
            render = views.error_message
          }
        end
        if self.params.email == "" then
          self.error = "You need to enter an email address."
          return {
            render = views.error_message
          }
        end
        self.user = Users:find({
          username = self.params.username
        })
        if self.user then
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
            self.user = Users:create({
              username = self.params.username,
              name = "",
              email = self.params.email,
              icon = 1
            })
            if not self.user then
              self.error = "Something went wrong while creating your account.<br><span style='font-weight:normal;'>Yell at the administrator.</span>"
              return {
                render = views.error_message
              }
            end
            self.session.logged_in = true
            self.session.username = self.params.username
            return self:write({
              redirect_to = self:url_for("index")
            })
          else
            self.error = "User " .. tostring(self.params.username) .. " does not exist."
            return {
              render = views.error_message
            }
          end
        end
      end
    }),
    [{
      user = "/:user"
    }] = function(self)
      self.user = Users:find({
        username = self.params.user
      })
      if not (self.user) then
        return {
          redirect_to = self:url_for("index")
        }
      end
      print(self.user.name)
      print(self.user.id)
      print(self.user.icon)
      print(self.user.created_at)
      print(self.user.updated_at)
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
