import Testing
@testable import SimpleSFSymbols

@Test func builderMatchesResult() async throws {
    var symbol: Symbol =  .symbol.circle.fill
    #expect(symbol.result == "circle.fill")
    
    symbol = .symbol.plus.down.fill
    #expect(symbol.result == "plus.down.fill")
    
    symbol = .symbol.num0.circle.fill
    #expect(symbol.result == "0.circle.fill")
}
