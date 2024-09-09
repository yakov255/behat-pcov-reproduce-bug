<?php

use Behat\Behat\Context\Context;

class FeatureContext implements Context
{

    /**
     * @When test
     */
    public function test()
    {
        xdebug_connect_to_client();
        throw new \Behat\Behat\Tester\Exception\PendingException();
    }
}
