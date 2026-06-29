<?php

declare(strict_types=1);

namespace App\Tests;

use App\Calculator;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\TestCase;

final class CalculatorTest extends TestCase
{
    private Calculator $calculator;

    protected function setUp(): void
    {
        $this->calculator = new Calculator();
    }

    #[Test]
    public function testAddsNumbers(): void
    {
        self::assertSame(5, $this->calculator->add(2, 3));
    }

    #[Test]
    public function testDividesNumbers(): void
    {
        self::assertSame(2.5, $this->calculator->divide(5, 2));
    }

    #[Test]
    public function testRejectsDivisionByZero(): void
    {
        $this->expectException(\InvalidArgumentException::class);
        $this->calculator->divide(1, 0);
    }
}
