<?php

use Phalcon\Mvc\View;
use Phalcon\Mvc\Controller;


class ControllerBase extends Controller
{
    
    public function get_content($folder,$layout){
        $this->view->setRenderLevel(View::LEVEL_LAYOUT);
        $this->view->render($folder,$layout);
        return $this->view->getContent();
    }    
    
    public function PageRedirect($page){
        $response = new \Phalcon\Http\Response();
        return $response->redirect($page);
    }
}
