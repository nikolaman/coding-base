<?php
// Версия приложения — подключить в config.php или bootstrap:
//   include dirname(__FILE__) . '/app_version.inc.php';
// Либо скопировать блок в существующий config.php.

if (!defined('APP_VERSION')) {
    $versionFile = dirname(__FILE__) . '/../VERSION';
    if (!is_readable($versionFile)) {
        $versionFile = dirname(__FILE__) . '/VERSION';
    }
    $appVersion = is_readable($versionFile) ? trim(file_get_contents($versionFile)) : 'dev';
    define('APP_VERSION', $appVersion);
}
