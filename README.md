#  SimpleSFSymbols

 ### Compose SF Symbols using simple syntax!

```
// Use the `Image` extension to compose and display a symbol
Image(.symbol.plus.circle.fill)

// Symbols that begin with a number are prefixed with "num"
Image(.symbol.battery.num100percent
```
_Note: This does not yet handle symbol validation, but I plan to add it soon._

### Installation

1) Add the Swift Package Dependency
`.package(url: "https://github.com/cwalo/SimpleSFSymbols.git")`

2) Ensure the SF Symbols app is installed
Download: https://developer.apple.com/sf-symbols/

3) Run the `SymbolGeneratorPlugin` to generate the symbol components. When prompted, just click "Run". This will collect and parse all available symbols, then generate `Symbols.generated.swift`, containing accessors for each symbol component.
`File > Packages > SymbolGeneratorPlugin`
