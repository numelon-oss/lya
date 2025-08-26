local lya = {}

local ffi = require("ffi")
local uv = require("uv")

local httpServer = require("./http-server")

ffi.cdef [[
    void lux_create(const bool debug);
    void lux_navigate(const char* url);
    // we dont actually use dispatch from the main thread
    //void lux_dispatch(const int type, const char* payload);
    void lux_set_title(const char* title);
    void lux_run();
]]

local lib = ffi.load("/Users/richyz/Documents/GitHub/numelon-oss/lya-core/cmake-build-debug/liblya_core.dylib")

function lya.init(config)
    -- setting up the http server for webview
    --local port = httpServer() -- forgot we cant run this on main thread

    -- UI
    config = config or {}

    local title = config.title or ""

    lib.lux_create(true) -- debug on for now
    --lib.lux_navigate("http://127.0.0.1:" .. port)
    --lib.lux_navigate("https://numelon.com")
    lib.lux_set_title(title)
end

function lya.main(main_fn)
    assert(main_fn, "UI logic must be supplied as a function to lya.main!")

    uv.new_thread(function(fn)
        ---@diagnostic disable-next-line: redefined-local
        local ffi = require("ffi")
        ffi.cdef [[
            void lux_dispatch(const int type, const char* payload);
        ]]

        ---@diagnostic disable-next-line: redefined-local
        local lib = ffi.load(
            "/Users/richyz/Documents/GitHub/numelon-oss/lya-core/cmake-build-debug/liblya_core.dylib")

        -- print(require("luvit/init"))

        -- load(fn)()

        -- add support for ./libs later
        --[[package.path = "./deps/?.lua;" ..
            "./deps/?;" .. "./?/init.lua;" .. "./luvit/deps/?.lua;" .. "./luvit/deps/?/init.lua;" .. package.path
]]

        local luvi = require("luvi")
        _G.luvi = luvi

        --require("luvi/luvipath")

        local uv = require("uv")
        --local require, module = require("luvit/deps/require")(uv.cwd() .. "../")
        --_G.require, _G.module = require, module

        --print(require("http-server"))

        --local luvit = require("luvit")
        --luvit(fn)

        --print(require("http-server")())
        --luvit(load(fn))

        print(require("http-server"))
    end, string.dump(main_fn)) -- i know this isnt necessarily the best solution..
    -- string.dump(...) -- oof...

    lib.lux_run()
end

return lya
