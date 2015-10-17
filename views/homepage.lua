local html = require("lapis.html")
local HomepageLayout
do
  local _parent_0 = html.Widget
  local _base_0 = {
    content = function(self)
      return html_5(function()
        head(function()
          element("meta", {
            charset = "UTF-8"
          })
          title(self.title or "Tweaker")
          element("link", {
            rel = "stylesheet",
            href = "static/pure-min-0.6.0.css"
          })
          return style("\n                    body {\n                        background: rgb(195, 205, 250);\n                    }\n                    #container {\n                        margin: 0 auto;\n                        overflow: auto;\n                        padding: 10px;\n                        padding-top: 65px;\n                        width: 900px;\n                    }\n                    .box {\n                        background: white;\n                        border-radius: 0.5em;\n                        /*border:1px solid rgb(190, 200, 240);*/\n                    }\n                    .inner {\n                        padding: 0.55em;\n                    }\n                ")
        end)
        return body(function()
          return self:content_for("inner")
        end)
      end)
    end
  }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "HomepageLayout",
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
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  HomepageLayout = _class_0
  return _class_0
end
