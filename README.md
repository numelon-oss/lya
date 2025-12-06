# lya
Minimal WebView UI controller powered by native dispatch & FFI

> [!CAUTION]
> This repository, along with the accompanying [numelon-oss/lya-core](https://github.com/numelon-oss/lya-core), are fundamentally flawed and require a big re-thinking of the entire model in order for such a product to be viable.
>
> In its current state, Lya is entirely Lua-centric - and whilst this may seem ideal, it is absolutely not. The main window thread is started from within Lua using LuaJIT's FFI and it therefore blocks the entire main Lua thread, not allowing anything else to happen. This is why if you look at the source code, you will find us making a new Lua thread using `uv.new_thread`. However, Luvit's require doesnt automatically get injected into that new thread, nor is it aware of a Luvi package being present. Theoretically the require issue may be fixed, but overall if you look at Lya, it is just entirely messy.
>
> If this were to be re-done, Lya would likely be rewritten in C++ and simply integrate Luvit (as opposed to the current model of Luvit integrating a C++ shared library and then just blocking itself in its entirety).
> **But for now, lya and lya-core will be archived as Numelon is slowly shifting away from Lua towards other languages, mainly Go.** Thank you for your interest.
