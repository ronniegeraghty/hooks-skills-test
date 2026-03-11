"""A sample Python file with some TODO comments for testing."""


def add(a, b):
    # TODO: Add input validation
    return a + b


def subtract(a, b):
    return a - b


def multiply(a, b):
    # FIXME: Handle overflow for very large numbers
    return a * b


def divide(a, b):
    # TODO: Return a proper error type instead of None
    if b == 0:
        return None
    return a / b


# HACK: Temporary workaround until we refactor the math module
MAGIC_NUMBER = 42

if __name__ == "__main__":
    print(f"add(2, 3) = {add(2, 3)}")
    print(f"subtract(5, 2) = {subtract(5, 2)}")
    print(f"multiply(3, 4) = {multiply(3, 4)}")
    print(f"divide(10, 3) = {divide(10, 3)}")
