<?php
/**
 * Zend Framework
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://framework.zend.com/license/new-bsd
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@zend.com so we can send you a copy immediately.
 *
 * @category   Zend
 * @package    Zend_Form
 * @subpackage Decorator
 * @copyright  Copyright (c) 2005-2012 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */

/** @see Zend_Form_Decorator_Abstract */
// require_once 'Zend/Form/Decorator/Abstract.php';

/**
 * ReCaptcha-based captcha decorator
 *
 * Adds hidden fields for challenge and response input, and JS for populating 
 * from known recaptcha IDs
 *
 * @category   Zend
 * @package    Zend_Form
 * @subpackage Element
 * @copyright  Copyright (c) 2005-2012 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */
class Zend_Form_Decorator_Captcha_ReCaptcha extends Zend_Form_Decorator_Abstract
{
    /**
     * Render captcha
     *
     * @param  string $content
     * @return string
     */
    public function render($content)
    {
        $element = $this->getElement();
        if (!$element instanceof Zend_Form_Element_Captcha) {
            return $content;
        }

        $view    = $element->getView();
        if (null === $view) {
            return $content;
        }

        $id            = $element->getId();
        $name          = $element->getBelongsTo();
        $placement     = $this->getPlacement();
        $separator     = $this->getSeparator();
        $challengeName = empty($name) ? 'recaptcha_challenge_field' : $name . '[recaptcha_challenge_field]';
        $responseName  = empty($name) ? 'recaptcha_response_field'  : $name . '[recaptcha_response_field]';
        $challengeId   = $id . '-challenge';
        $responseId    = $id . '-response';
        $captcha       = $element->getCaptcha();
        $markup        = $captcha->render($view, $element);

        // Create hidden fields for holding the final recaptcha values
        // Placing "id" in "attribs" to ensure it is not overwritten with the name
        $hidden = $view->formHidden(array(
            'name'    => $challengeName,
            'attribs' => array('id' => $challengeId),
        ));
        $hidden .= $view->formHidden(array(
            'name'    => $responseName,
            'attribs' => array('id'   => $responseId),
        ));

        // Create a window.onload event so that we can bind to the form.
        // Once bound, add an onsubmit event that will replace the hidden field 
        // values with those produced by ReCaptcha
        // zendBindEvent mediates between Mozilla's addEventListener and
        // IE's sole support for addEvent.
        $js ="";
        $markup = <<<EOJ
<script src='https://www.google.com/recaptcha/api.js'></script>
<div class="g-recaptcha" data-sitekey="6Lca5w0TAAAAAG9nlXhv_l0Ingf12nVBXk_KvVb0"></div>
</script>
EOJ;

        // Always place the hidden fields before the captcha markup, and follow 
        // with the JS from above
        switch ($placement) {
            case 'PREPEND':
                $content = $hidden . $markup . $js . $separator . $content;
                break;
            case 'APPEND':
            default:
                $content = $content . $separator . $hidden . $markup . $js;
        }
        return $content;
    }
}

