<?php

class OcMailChimp
{
    public static function getApiKey()
    {
        return eZINI::instance('ocmailchimp.ini')->variable('MailChimpSettings', 'ApiKey');
    }
}