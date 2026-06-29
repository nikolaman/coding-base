import pytest

from app.calculator import add, divide


def test_add() -> None:
    assert add(2, 3) == 5


def test_divide() -> None:
    assert divide(5, 2) == 2.5


def test_divide_by_zero() -> None:
    with pytest.raises(ValueError, match="Division by zero"):
        divide(1, 0)
