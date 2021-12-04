from tokenizer import tokenize, TokenType

class ParseException(Exception):
    def __init__(self, token, message):
        self.message = f"{token.position}, {token.line}: {message}"

def calculatestatus():
    position = 0
    aim = 0
    depth = 0

    with open('input.txt', 'r') as f:
        tokens = tokenize(f)

        i = 0
        while i < len(tokens):
            command = tokens[i]
            if command.type != TokenType.STRING:
                raise ParseException(command, f"Expected {TokenType.STRING}, Got {command.type}")
            
            if i+1 >= len(tokens):
                raise ParseException(command, "Unexpected EOF")
            space = tokens[i+1]
            if space.type != TokenType.SPACE:
                raise ParseException(space, f"Expected {TokenType.SPACE}, Got {space.type}")

            if i+2 >= len(tokens):
                raise ParseException(space, "Unexpected EOF")
            param = tokens[i+2]
            if param.type != TokenType.NUMBER:
                raise ParseException(param, f"Expected {TokenType.NUMBER}, Got {param.type}")

            if i+3 >= len(tokens):
                raise ParseException(param, "Unexpected EOF")
            newline = tokens[i+3]
            if newline.type != TokenType.NEWLINE:
                raise ParseException(value, f"Expected {TokenType.NEWLINE}, Got {newline.type}")

            if command.value == 'forward':
                position += param.value
                depth += aim * param.value
            elif command.value == 'down':
                aim += param.value
            elif command.value == 'up':
                aim -= param.value
            else:
                raise ParseExeption(command, f"Unexpected {command.value}")
            
            i += 4

        print(f"Position: {position}, Depth: {depth}")

if __name__ == '__main__':
    calculatestatus()
