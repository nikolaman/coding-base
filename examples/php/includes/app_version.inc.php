<?php

declare(strict_types=1);

// VERSION: локально из корня monorepo, в Docker — из examples/php/VERSION
if (!defined('APP_VERSION')) {
    $candidates = [
        dirname(__DIR__) . '/VERSION',
        dirname(__DIR__, 3) . '/VERSION',
    ];
    $appVersion = 'dev';
    foreach ($candidates as $versionFile) {
        if (is_readable($versionFile)) {
            $appVersion = trim((string) file_get_contents($versionFile));
            break;
        }
    }
    define('APP_VERSION', $appVersion);
}
