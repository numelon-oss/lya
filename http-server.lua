-- a majority of this http server logic was borrowed from other numelon projects

local http = require("coro-http")
local fs = require("coro-fs").chroot("./ui") -- ui directory is purely for testing - will be something else later
local url = require("url")
local querystring = require("querystring")

local urldecode = querystring.urldecode

local function output(code, reason, mimetype, content)
    return {
        { "content-length", tostring(#content) },
        { "content-type",   mimetype },

        code = code,
        reason = reason
    }, content
end

local mimes = {
    ["htm"] = "text/html",
    ["html"] = "text/html",
    ["css"] = "text/css",
    ["js"] = "text/javascript",
    ["mjs"]  = "text/javascript",
    ["json"] = "application/json",
    ["xml"]  = "application/xml",
    ["txt"]  = "text/plain",
    ["csv"]  = "text/csv",

    -- images
    ["png"]  = "image/png",
    ["jpg"]  = "image/jpeg",
    ["jpeg"] = "image/jpeg",
    ["gif"]  = "image/gif",
    ["svg"]  = "image/svg+xml",
    ["webp"] = "image/webp",
    ["ico"]  = "image/vnd.microsoft.icon",
    ["bmp"]  = "image/bmp",
    ["avif"] = "image/avif",

    -- fonts
    ["woff"]  = "font/woff",
    ["woff2"] = "font/woff2",
    ["ttf"]   = "font/ttf",
    ["otf"]   = "font/otf",

    -- audio / video
    ["mp3"]  = "audio/mpeg",
    ["wav"]  = "audio/wav",
    ["ogg"]  = "audio/ogg",
    ["mp4"]  = "video/mp4",
    ["webm"] = "video/webm",
    ["ogv"]  = "video/ogg",

    -- compressed archivws
    ["zip"]  = "application/zip",
    ["gz"]   = "application/gzip",
    ["tar"]  = "application/x-tar",
    ["rar"]  = "application/vnd.rar",
    ["7z"]   = "application/x-7z-compressed",
}

-- TODO: generate random port and check if occupied
-- then make function return port so it can be used in lya.main()
return function()
    http.createServer("127.0.0.1", 8392, function(request)
        local parsed = url.parse(request.path) ---@diagnostic disable-line undefined-field
        local path = "./" .. parsed.pathname:gsub("^/", ""):gsub("/$", "")

        local content, err = fs.readFile(path)
        if not content then content, err = fs.readFile(path .. "/index.html") end

        if not content then
            return output(404, "Not Found", "text/plain", err)
        end

        local ext = (path:match("^.+%.([^%.]+)$") or ""):lower()
        ext = mimes[ext] or "application/octet-stream"

        return output(200, "OK", ext, content)
    end)

    return 8392
end

-- TODO:
-- / --> index.html
