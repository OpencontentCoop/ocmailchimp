<?php

use \DrewM\MailChimp\MailChimp;

$http = eZHTTPTool::instance();
$data = array();

try {

    $listId = $http->hasVariable('list_id') ? $http->variable('list_id') : null;
    if (!$listId) {
        throw new Exception("Errore di configurazione: contattare l'amministratore di sistema");
    }

    $emailAddress = $http->hasVariable('email_address') ? $http->variable('email_address') : null;
    if (!$emailAddress) {
        throw new Exception("Inserire un indirizzo email valido");
    }
    if (!eZMail::validate($emailAddress)) {
        throw new Exception("Inserire un indirizzo email valido");
    }

    $data['email'] = $emailAddress;

    $mailChimp = new MailChimp(OcMailChimp::getApiKey());
    $result = $mailChimp->post("lists/$listId/members", [
        'email_address' => $emailAddress,
        'status' => 'subscribed',
    ]);

    if ($result['status'] == 400) {
        $data['error'] = "Indirizzo già presente in lista";
    } elseif ($result['status'] != 'subscribed') {
        $data['error'] = $result['title'];
        if ($http->hasVariable('debug')) {
            $data['response'] = $result;
        }
    }

    $data['result'] = $result['status'];

} catch (Exception $e) {
    $data['error'] = $e->getMessage();
}

header('Content-Type: application/json');
echo json_encode($data);
eZExecution::cleanExit();