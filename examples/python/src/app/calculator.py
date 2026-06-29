"""Простая бизнес-логика для демонстрации тестов и покрытия."""


def add(a: int, b: int) -> int:
    return a + b


def divide(a: int, b: int) -> float:
    if b == 0:
        raise ValueError("Division by zero")
    return a / b
