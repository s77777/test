<?php

use Phalcon\Mvc\View;
use Phalcon\Mvc\Controller;

class TaskController extends Controller
{
    protected  $Id;
    public $taskTitle;
    
    public function indexAction()
    {
        $this->view->setRenderLevel(
            View::LEVEL_LAYOUT
        );
								$params=$this->dispatcher->getParams('params');
								$this->Id=$params[0];
								$this->taskTitle='Задача № '.$this->Id;
								$this->tag->setTitle($this->taskTitle);
								$this->view->setVar('taskTitle',$this->taskTitle);
								$TasksList=(new Tasks())->findFirst($this->Id);
								$TaskTag = (new TasksTag())->find("taskid={$this->Id}");
								$priority = (new Priority())->find();
								$status=(new Status())->find();
								if (empty($TasksList->id)){
												$this->notaskAction();
								}
								else {
												$this->view->render('task', 'index');    
								}
    }
    
    public function addTaskAction()
    {
        $this->view->setRenderLevel(
            View::LEVEL_LAYOUT
        );
        $this->taskTitle='Новая задача';
								$this->tag->setTitle($this->taskTitle);
								$this->view->setVar('taskTitle',$this->taskTitle);
        $tasks=new Tasks();
								$taskTag=new TasksTag();
								$priority=(new Priority())->find();
								$status=(new Status())->find();
        $this->view->render('task', 'addTask');    
    }
    
    public function saveTaskAction()
    {
								$this->view->disable();
								$data = $this->request->getJsonRawBody(true);	
								if ($data['mode']=='ins') {
												$res=$this->db->insert(
													'tasks',
													array_values($data['tasks']),
													array_keys($data['tasks'])
													);
												$taskid=$this->db->lastInsertId();
												$data['taskid']=$taskid;
												if (!empty($taskid)) {
												foreach($data['tasks_tag'] as $key=>$value) {
																$value['taskid']=$taskid;
																$res=$this->db->insert(
																											'tasks_tag',
																											array_values($value),
																											array_keys($value)
																								);
																}
												}
								}
								elseif ($data['mode']=='update'){
												$set=array();
												foreach($data['field'] as $key=>$value) {
																$set[]=$key.'='.(is_string($value)?'"'.addslashes($value).'"':$value);				
												}
												$sql="UPDATE {$data['table']} SET ".implode(',',$set)." WHERE id=:id:";
												$query=$this->modelsManager->createQuery($sql);
												$res=$query->execute(array('id'=>$data['id']));
								}
								if ($res) {
												$data['success']=true;
												echo json_encode($data);
								}
								else {
												$data['success']=false; echo json_encode($data);
								}
				}
				
				public function deleteTaskAction()
				{
								$this->view->disable();
								$data = $this->request->getJsonRawBody(true);
								$sql="DELETE FROM {$data['table']} WHERE id=:id:";
								$query=$this->modelsManager->createQuery($sql);
								$res=$query->execute(array('id'=>$data['id']));
								if ($res) {
												$data['success']=true;
												echo json_encode($data);
								} else {
												$data['success']=false;
												echo json_encode($data);
								}
				}
				public function notaskAction(){
    			 //$this->view->disable();
					   $this->view->setRenderLevel(
            View::LEVEL_BEFORE_TEMPLATE
        );
								$params=$this->dispatcher->getParams('params');
								$this->Id=$params[0];
								$this->view->render('task', 'notask');
				}
}
