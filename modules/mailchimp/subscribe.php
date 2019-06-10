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
    $data['message'] = '';

    $mailChimp = new MailChimp(OcMailChimp::getApiKey());
    $result = $mailChimp->post("lists/$listId/members", [
        'email_address' => $emailAddress,
        'status' => OcMailChimp::getSubscribeStatus(),
        'language' => 'it'
    ]);

    $data['result'] = $result['status'];
    if ($http->hasVariable('debug')) {
        $data['response'] = $result;
    }

    if (isset($result['title'])){
        $data['error'] = $result['title'];
    }

    if ($result['status'] == 'pending') {
        $data['message'] = "Controlla la tua casella di posta per confermare l'iscrizione";        
    }

} catch (Exception $e) {
    $data['error'] = $e->getMessage();
}

header('Content-Type: application/json');
echo json_encode($data);
eZExecution::cleanExit();