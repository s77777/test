<?php

use Phalcon\Mvc\View;

class IndexController extends ControllerBase
{

    public function indexAction()
    {
        $this->view->setRenderLevel(
            View::LEVEL_LAYOUT
        );
	$this->taskTitle='Список задач ';
	$this->tag->setTitle($this->taskTitle);
	$this->view->setVar('taskTitle',$this->taskTitle);
	$sql='SELECT t.id,t.name,t.priorityid,p.text as priority,t.statusid,s.text as status,DATE_FORMAT(t.timecreate,"%d-%m-%Y %H:%i") as dt
                FROM Tasks t 
		INNER JOIN Status s ON t.statusid=s.id
		INNER JOIN Priority p ON t.priorityid=p.id';
	$query=$this->modelsManager->createQuery($sql);
	$TasksList=$query->execute();
        $this->view->render('index', 'index');
    }
    
    public function getSearchListAction()
    {
        $this->view->disable();
	$data = $this->request->getJsonRawBody();        
        if (!empty($data->search)){
            $sql='SELECT t.id,t.name,p.text as priority,s.text as status,DATE_FORMAT(t.timecreate,"%d-%m-%Y %H:%i") as dt FROM Tasks t 
		LEFT JOIN TasksTag tt ON t.id=tt.taskid 
		INNER JOIN Status s ON t.statusid=s.id
		INNER JOIN Priority p ON t.priorityid=p.id
		WHERE t.name like :search: or tt.text like :search: GROUP BY t.id';
		$query=$this->modelsManager->createQuery($sql);
            $TasksList=$query->execute(['search'=>'%'.$data->search.'%']);
        } else {
            $TasksList="";
        }
        echo json_encode($TasksList);
    }
    
}