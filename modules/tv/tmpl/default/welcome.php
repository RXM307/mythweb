<?php
/**
 * Welcome page description of the TV module.
 *
 * @url         $URL$
 * @date        $Date$
 * @version     $Revision$
 * @author      $Author$
 * @license     GPL
 *
 * @package     MythWeb
 * @subpackage  TV
 *
/**/

// Open with a div and an image
    echo '<div id="info_tv">',
         '<img src="', skin_url, '/img/tv.png" class="module_icon" />',

// Print a basic overview of what this module does
         t('welcome: tv'),

// Next, print a list of possible subsectons
         '<ul>';
    foreach ($Modules['tv']['links'] as $link => $name) {
        echo '    <li><a href="', root, 'tv/', $link, '">', html_entities($name), "</a></li>\n";
    }
    echo '</ul>',

// Close the div
         "</div>\n";