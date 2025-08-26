local uv = require("uv")

uv.new_thread(function(bundle)
    local uv = require("uv")
    local luvi = require("luvi")
    luvi.bundle = load(bundle)
    --local bundle = luvi.bundle

    bundle.register("deps/require.lua")
    local req = require("require")(uv.cwd())

    -- print("Hi")

    -- for i, v in pairs(package.preload) do
    --     print(i, v)
    --     --v()
    -- end

    -- local uv = require("uv")
    -- local req, mod = require("deps/require")(uv.cwd())
    -- _G.require = req
    -- _G.module = mod

    -- --local luvi = require("luvi")
    -- local process = req("process")
    -- print(process)
end)

uv.run()
