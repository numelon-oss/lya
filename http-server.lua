-- a VERY large majority of this http server logic was borrowed from Numelon Passport Backend and Rubiš

local http = require("coro-http")
local fs = require("coro-fs").chroot("./ui") -- chroot not really needed
local url = require("url")
local querystring = require("querystring")

local urldecode = querystring.urldecode

local function formatHeaders(code, reason, len, mimetype)
    return {
        { "content-length", tostring(len) },
        { "content-type",   mimetype },

        code = code,
        reason = reason
    }
end

local mimes = {
    ["html"] = "text/html",
    ["css"] = "",
    ["js"] = "",
    ["ts"] = "",
    ["json"] = "application/json"
}

-- TODO: generate random port and check if occupied
-- then make function return port so it can be used in lya.main()
return function()
    p(fs)
    http.createServer("127.0.0.1", 8392, function(request)
        local parsed = url.parse(request.path) ---@diagnostic disable-line undefined-field
        local path = "./" .. parsed.pathname:gsub("^/", ""):gsub("/$", "")

        p(path)
        local content, err = fs.readFile(path) or fs.readFile(path .. "/index.html")
        if not content then
            return formatHeaders(404, "Not Found", #err, "text/plain"), err
        end

        return formatHeaders(200, "OK", #content, "text/plain"), content
    end)

    return 8392
end

-- TODO:
-- / --> index.html
