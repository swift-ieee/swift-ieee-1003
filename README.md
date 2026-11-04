# swift-ieee-1003

Use this package when you need to split a command line's arguments into POSIX short options, option values and operands, following the Utility Syntax Guidelines of IEEE Std 1003.1 chapter 12. Start from `IEEE_1003.UtilitySyntax.Tokenizer`. It doesn't know which options your utility takes, so it doesn't bind values to options or support GNU long options. For a full argument parser built on it, use swift-arguments. For the POSIX system interfaces, use swift-iso-9945.

## Laws

- Tokenizing consumes the whole input array, and tokens come out in argument order.
- The first `--` ends the options. Every later argument is an operand, including `-f` and another `--`.
- A lone `-` and the empty string are operands.
- An argument that starts with `-` and has more after it is a short flag. The character after the dash must be an ASCII letter or digit, or the argument is refused. A dash is neither, so a GNU long option such as `--foo` is refused.
- Whatever follows the first option character in the same argument becomes one value token, never more flags. `-abc` gives flag `a` with value `bc`. Whether that value is an option-argument or a group of flags is for the caller to decide.
- An argument after a flag in its own position is an operand. The tokenizer never pairs it with the flag.
- Options after operands are still read as options. The tokenizer does not enforce that options come first.
- Token ranges count UTF-8 bytes across the arguments laid end to end, with no separator. A flag's range covers the option character, not the dash.
- `IEEE_1003.UtilitySyntax.Guideline.G3.isValid(_:)` accepts only ASCII letters and digits, so `ø` is refused.
