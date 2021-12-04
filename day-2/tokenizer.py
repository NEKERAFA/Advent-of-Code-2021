from enum import Enum
from abc import ABC

class TokenType(Enum):
    STRING = 1
    NUMBER = 2
    SPACE = 3
    NEWLINE = 4

class Token(ABC):
    def __init__(self, position, line, token_type):
        self.position = position
        self.line = line
        self.type = token_type

class StringToken(Token):
    def __init__(self, position, line, char):
        super().__init__(position, line, TokenType.STRING)
        self.value = char

    def appendChar(self, c):
        self.value += c

class NumberToken(Token):
    def __init__(self, position, line, digit):
        super().__init__(position, line, TokenType.NUMBER)
        self.value = digit

    def appendDigit(self, d):
        self.value = self.value * 10 + d

class SpaceToken(Token):
    def __init__(self, position, line):
        super().__init__(position, line, TokenType.SPACE)

class NewLineToken(Token):
    def __init__(self, position, line):
        super().__init__(position, line, TokenType.NEWLINE)

class TokenException(Exception):
    def __init__(self, char):
        self.symbol = char

def tokenize(f):
    tokens = []
    pos = 1
    line = 1

    char = f.read(1)
    while char != '':
        if char.isdigit():
            adddigit(tokens, char, pos, line)
            pos += 1
        elif char.isalpha():
            addletter(tokens, char, pos, line)
            pos += 1
        elif char == '\n':
            tokens.append(NewLineToken(pos, line))
            pos = 1
            line += 1
        elif char == '\r':
            next_char = f.read(1)
            if next_char == '\n':
                tokens.append(NewLineToken(pos, line))
                pos = 1
                line += 1
            else:
                addletter(tokens, char, pos, line)
                pos += 1
        elif char.isspace():
            tokens.append(SpaceToken(pos, line))
            pos += 1
        else:
            raise TokenException(char)

        char = f.read(1)

    return tokens

def adddigit(tokens, character, pos, line):
    if (len(tokens) == 0) or (tokens[-1].type != TokenType.NUMBER):
        tokens.append(NumberToken(pos, line, int(character)))
    else:
        tokens[-1].appendDigit(int(character))

def addletter(tokens, character, pos, line):
    if (len(tokens) == 0) or (tokens[-1].type != TokenType.STRING):
        tokens.append(StringToken(pos, line, character))
    else:
        tokens[-1].appendChar(character)
