import Foundation
import lua
import LuaSwift

// let source = #"""
// my_add = function(a, b)
//    return a + b
// end
// """#
// let lua = Lua()
// lua.execute(source: source)
// print(try lua.call(function: "my_add", parameters: [40.0, 2.0]))

let source = #"""
my_lua_function = function()
    print("Result:", my_c_function(40, 2))
end
"""#

do {
    let lua = Lua()
    try lua.withUnchangedStack {
        try lua.register(function: "my_c_function") { lua in
            let parameters = lua.pop(count: 2)
            guard let x = parameters[0] as? Double, let y = parameters[1] as? Double else {
                fatalError("No parameters")
            }
            lua_pushnumber(lua.state, x + y)
            return 1
        }
        lua.execute(source: source)
        print(try lua.call(function: "my_lua_function"))
        print(try lua.call(function: "my_c_function", parameters: [40, 2]))
    }
}
