local html = require("lapis.html")
local DefaultLayout
do
  local _parent_0 = html.Widget
  local _base_0 = {
    content = function(self)
      return html_5(function()
        head(function()
          element("meta", {
            charset = "UTF-8"
          })
          title(self.title or "Lapis Rage")
          element("link", {
            rel = "stylesheet",
            href = "static/pure-min-0.6.0.css"
          })
          return style("\n                    body {\n                        margin: 0;\n                        padding: 0;\n                        background: #eee;\n                        font-size: 1.4em;\n                        font-family: Helvetica, Arial, sans-serif;\n                    }\n                    #sticky_header {\n                        background: white;\n                        border-bottom: 1px solid #ccc;\n                        padding: 5px;\n                        position: fixed;\n                        left: 0;\n                        top: 0;\n                        width: 100%;\n                    }\n                    #container {\n                        margin: 0 auto;\n                        overflow: auto;\n                        padding: 10px;\n                        padding-top: 65px;\n                        width: 900px;\n                    }\n                ")
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
    __name = "DefaultLayout",
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
  DefaultLayout = _class_0
  return _class_0
end
