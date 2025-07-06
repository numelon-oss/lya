local ffi = require("ffi")
local uv = require("uv")

ffi.cdef [[
    void lux_create(bool debug);
    void lux_navigate(const char* url);
    void lux_dispatch(int type, const char* payload);
    void lux_run();
]]

local lib = ffi.load("./liblux_webview.dylib")

lib.lux_create(true)
lib.lux_navigate("https://numelon.com")

uv.new_thread(function()
    local ffi = require("ffi")

    ffi.cdef [[
        void lux_dispatch(int type, const char* payload)
    ]]

    local lib = ffi.load("./liblux_webview.dylib")

    --require = require("require") -- luvit's custom require
    -- thi didnt actually work oof

    local luvi = require("luvi")

    for i, v in pairs(luvi) do
        print(i, v)
    end

    local c = os.time()
    repeat until os.time() >= c + 3

    --timer.sleep(10000)

    print("hi")

    lib.lux_dispatch(1, "Updated Title from Thread")

    -- local process = require("process").globalProcess()

    -- process:on("sigint", function()
    --     print("Hi exiting")
    -- end)

    -- process:on("sigterm", function()
    --     print("Hi exiting")
    -- end)
end)

lib.lux_run()
