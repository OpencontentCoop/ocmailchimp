<?php

class OcMailChimp
{
    public static function getApiKey()
    {
        return eZINI::instance('ocmailchimp.ini')->variable('MailChimpSettings', 'ApiKey');
    }

    public static function getSubscribeStatus()
    {
    	return eZINI::instance('ocmailchimp.ini')->variable('MailChimpSettings', 'SubscribeStatus');	
    }
}