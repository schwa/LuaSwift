import Metal
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

@main
struct MetalSupportMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        LuaFunctionMacro.self,
    ]
}

public struct LuaFunctionMacro {
}

extension LuaFunctionMacro: PeerMacro {
    public static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {

        print("#####", Self.self, #function)
        guard let funcDecl = declaration.as(FunctionDeclSyntax.self) else {
            return []
        }

        let functionName = funcDecl.identifier.trimmedDescription

        return [
            """
            func _register(lua: Lua) throws {
                try lua.register(function: "\(raw: functionName)") { lua in
                    \(raw: functionName)()
                    return 1
                }
            }
            """
        ]
    }

}
