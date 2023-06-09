import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import LuaSwiftMacros

let testMacros: [String: Macro.Type] = [
    "LuaFunction": LuaFunctionMacro.self,
]

final class LuaFunctionMacroTests: XCTestCase {
    
    func testMacroNoAttributes() {
        assertMacroExpansion(
            """
            @LuaFunction
            func helloWorld() {
            }
            """,
            expandedSource: """

            func helloWorld() {
            }
            """,
            macros: testMacros
        )
    }
}
