//
//  File.swift
//  File
//
//  Created by Jonathan Wight on 9/6/21.
//

import Foundation
import lua

public func lua_pop(_ L: OpaquePointer, _ n: Int32) {
    lua_settop(L, -(n) - 1)
}

public func lua_call(_ L: OpaquePointer, _ n: Int32, _ r: Int32) {
    lua_callk(L, n, r, 0, nil)
}

public func lua_upvalueindex(_ i: Int32) -> Int32 {
    (LUA_REGISTRYINDEX - (i))
}

public let LUA_REGISTRYINDEX = (-LUAI_MAXSTACK - 1_000)
