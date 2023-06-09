import Foundation

@attached(peer, names: named(_register))
public macro LuaFunction() = #externalMacro(module: "LuaSwiftMacros", type: "LuaFunctionMacro")
