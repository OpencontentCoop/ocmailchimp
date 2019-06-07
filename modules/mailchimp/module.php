<?php
$Module = array( 'name' => 'OpenContent MailChimp' );

$ViewList = array();
$ViewList['subscribe'] = array(
    'script' => 'subscribe.php',
    'functions' => array('subscribe'),
);

$FunctionList['subscribe'] = array();
