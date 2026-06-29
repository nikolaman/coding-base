<?php

declare(strict_types=1);

require_once dirname(__DIR__) . '/vendor/autoload.php';
require_once dirname(__DIR__) . '/includes/app_version.inc.php';

use App\Calculator;

header('Content-Type: application/json');

$path = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH);

if ($path === '/health') {
    echo json_encode(['status' => 'ok', 'version' => APP_VERSION]);
    exit;
}

$calculator = new Calculator();
echo json_encode([
    'service' => 'php-example',
    'version' => APP_VERSION,
    'add' => $calculator->add(2, 3),
    'divide' => $calculator->divide(5, 2),
]);
