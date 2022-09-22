//
//  File.swift
//  File
//
//  Created by Jonathan Wight on 9/6/21.
//

import Foundation
import lua

public extension Lua {
    func dumpStack(note: String? = nil) {
        Lua.dumpStack(state: state, note: note)
    }

    // swiftlint:disable:next cyclomatic_complexity
    static func dumpStack(state: OpaquePointer, note: String? = nil) {
        guard lua_gettop(state) != 0 else {
            if let note {
                print("\(note): Empty stack")
            }
            else {
                print("Empty stack")
            }
            return
        }
        if let note {
            print(note, String(repeating: ">", count: 8))
        }
        let top = lua_gettop(state)
        for index in 1 ... top {
            let type = lua_type(state, index)
            var value: Any
            switch type {
            case LUA_TNIL:
                value = "<nil>"
            case LUA_TBOOLEAN:
                value = lua_toboolean(state, index) != 0
            case LUA_TNUMBER:
                var isnum: Int32 = 0
                value = lua_tonumberx(state, index, &isnum)
            case LUA_TSTRING:
                value = "\"" + String(cString: lua_tolstring(state, index, nil)) + "\""
            case LUA_TTABLE:
                value = "<table>"
            case LUA_TFUNCTION:
                let pointer = lua_topointer(state, index)
                value = pointer as Any
            case LUA_TUSERDATA:
                value = "<user data>"
            case LUA_TTHREAD:
                value = "<thread>"
            case LUA_TLIGHTUSERDATA:
                value = "<light user data>"
            default:
                fatalError("Unexpected lua type")
            }
            print("#\(index), \(String(cString: lua_typename(state, lua_type(state, index)))), \(value as Any)")
        }
        if let note {
            print(note, String(repeating: "<", count: 8))
        }
    }
}
