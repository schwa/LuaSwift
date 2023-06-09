import Foundation
import lua
import LuaSwift


@LuaFunction
func helloWorld() {
    print("Hello world (from swift)")
}

do {
    let lua = Lua()
    try lua.withUnchangedStack {
        try _register(lua: lua) // DO NOT LOOK BEHIND CURTAIN
        let source = #"""
        print("Hello world (from lua)")
        helloWorld()
        """#
        lua.execute(source: source)
    }
}
