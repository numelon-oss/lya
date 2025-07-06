local ffi = require("ffi")
local lib = ffi.load("./liblux_webview.dylib")

ffi.cdef [[
  typedef void* lux_webview;

  lux_webview lux_create(int debug);
  void lux_set_title(lux_webview w, const char* title);
  void lux_navigate(lux_webview w, const char* url);
  void lux_set_html(lux_webview w, const char* html);
  void lux_eval_js(lux_webview w, const char* js);
  void lux_run(lux_webview w);
  void lux_terminate(lux_webview w);
  void lux_destroy(lux_webview w);
]]

local w = lib.lux_create(1)
lib.lux_set_title(w, "Numelon")
--lib.lux_set_html(w, "<h1>Hi test</h1>")
lib.lux_navigate(w, "https://numelon.com")
lib.lux_run(w)
-- lux_run is just webview_run() wrapped
-- webview_run is a synchronous, blocking thing from C
-- it entirely blocks the main lua thread and doesnt allow anything else to happen
print("a")
