---
page_type: reference
---

# Language Framework Matrix

| Files | Framework |
| --- | --- |
| `.ts`, `.tsx` | TSDoc / TypeDoc-compatible |
| `.js`, `.jsx`, `.mjs`, `.cjs` | JSDoc |
| `.py` | PEP 257 with Sphinx Napoleon |
| `.java` | Javadoc |
| `.kt`, `.kts` | KDoc |
| `.swift` | Swift Markup / DocC |
| `.cs` | XML documentation |
| `.go` | Go doc |
| `.rs` | rustdoc |
| `.c`, `.h`, `.cpp`, `.cc`, `.cxx`, `.hpp`, `.hh`, `.hxx` | Doxygen |
| `.rb` | YARD |
| `.php` | PHPDoc |
| `.scala`, `.sc` | Scaladoc |
| `.lua` | LuaLS / EmmyLua |
| `.sh`, `.bash`, `.zsh`, `.fish` | shdoc-style headers |
| `.env`, `.yaml`, `.yml`, `.toml`, `.ini`, `.json`, `.conf` | Plain inline comments |

Explicit repository configuration wins over extension; a shebang wins over an
extension. Unknown languages retain comments and record a framework gap.
