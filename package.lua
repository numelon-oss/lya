return {
    name = "numelon-oss/lya",
    version = "1.0.1",
    description = "Cross-platform UI framework for Lua using WebView",
    tags = { "lua", "luajit", "ffi", "webview", "ui", "framework" },
    license = "Apache 2.0",
    author = { name = "Richy Z.", email = "64844585+Richy-Z@users.noreply.github.com" },
    homepage = "https://github.com/numelon-oss/lya",
    dependencies = {
        "luvit/require",

        "creationix/coro-http",
        "creationix/coro-fs",
        "luvit/url",
        "luvit/querystring",

        --"creationix/secure-socket"
        --"luvit/luvit"
    },
    files = {
        "**.lua",
        "!tests*",
        "!deps*"
    }
}
