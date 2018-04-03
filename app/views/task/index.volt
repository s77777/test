<!DOCTYPE html>
<html lang=ru>
<head>
    {% include "layouts/head.volt" %}
    <link rel="stylesheet" href="/css/style.css" />   
</head>
<body style="margin-top: 2em;">
<div class="container">
    <header>
        <div class="page-header">
            <h1>{{taskTitle}}&nbsp;&nbsp;<small>Дата создания:&nbsp;<?php echo date("d-m-Y H:m",strtotime($TasksList->timecreate));?></small></h1>
            <input id="taskid" type="hidden" value="<?php echo $TasksList->id;?>">
        </div>
    </header>
    <div class="col-lg-12 text-right">
        <span class="badge badge-default badge-pill">
            <span id="task-picklist" role="button" class="glyphicon glyphicon-list" id="picklist" title="К списку задач"></span> 
        </span>
        <span class="badge badge-default badge-pill">        
            <span  id="task-delTask"  role="button" title="Удалить" class="glyphicon glyphicon-remove-sign"></span> 
        </span>
    </div>
    <form method="post" action="#">
        <div class="form-group">
            <label for="name">Название задачи</label>
           <div id="Tasks-visible-name" class="list-group">
                <div class="list-group-item list-group-item-action flex-column align-items-start">
                    <span class="badge badge-primary badge-pill">
                        <span id="Tasks-edit-name" role="button" class="glyphicon glyphicon-pencil"></span> 
                    </span>
                    <div id="Tasks-show-name" class="d-flex w-100 justify-content-between">
                        <?php echo $TasksList->name;?>
                    </div>
                    
                </div>
           </div> 
           <div class="input-group" id="Tasks-none-name" style="display: none;">
                  <input type="text" class="form-control" id="Tasks-name" placeholder="" value="<?php echo stripslashes($TasksList->name);?>" required >
                  <div class="input-group-addon">
                        <span id="Tasks-update-name" role="button" class="glyphicon glyphicon-save"></span> 
                 </div>
            </div>   
        </div>
        <div class="form-group">
          <label for="priorityid">Приоритет</label>
           <div class="list-group" id="Tasks-visible-priorityid">
                <div class="list-group-item list-group-item-action flex-column align-items-start">
                    <span class="badge badge-primary badge-pill">
                        <span id="Tasks-edit-priorityid" role="button" class="glyphicon glyphicon-pencil"></span> 
                    </span>
                    <div id="Tasks-show-priorityid" class="d-flex w-100 justify-content-between">
                        <?php foreach($priority as $key=>$value) { 
                            if ($value->id==$TasksList->priorityid) {echo $value->text;break;}
                        }?>    
                    </div>
                    
                </div>
           </div>          
          <div class="input-group" style="display: none;" id="Tasks-none-priorityid">
                <select class="form-control" id="Tasks-priorityid">
                  <?php foreach($priority as $key=>$value) { ;?>
                      <option value="<?php echo $value->id;?>" <?php echo ($value->id==$TasksList->priorityid)?'selected':'';?>>
                          <?php echo $value->text;?>
                      </option>
                  <?php }?>    
                </select>
                <div class="input-group-addon">
                        <span id="Tasks-update-priorityid" role="button" class="glyphicon glyphicon-save"></span> 
                </div>
          </div>
        </div>
        <div class="form-group">
          <label for="statusid">Статус</label>
           <div class="list-group" id="Tasks-visible-statusid">
                <div class="list-group-item list-group-item-action flex-column align-items-start">
                    <span class="badge badge-primary badge-pill">
                        <span id="Tasks-edit-statusid" role="button" class="glyphicon glyphicon-pencil"></span> 
                    </span>
                    <div id="Tasks-show-statusid" class="d-flex w-100 justify-content-between">
                        <?php foreach($status as $key=>$value) { 
                            if ($value->id==$TasksList->statusid) {echo $value->text;break;}
                        }?>    
                    </div>
                    
                </div>
           </div>          
            <div class="input-group" style="display: none;" id="Tasks-none-statusid">
                <select class="form-control" id="Tasks-statusid">
                  <?php foreach($status as $key=>$value) { ;?>
                      <option value="<?php echo $value->id;?>" <?php echo ($value->id==$TasksList->statusid)?'selected':'';?>>
                          <?php echo $value->text;?>
                      </option>
                  <?php }?>    
                </select>
                  <div class="input-group-addon">
                      <span id="Tasks-update-statusid" role="button" class="glyphicon glyphicon-save"></span>  
                  </div>
            </div>
        </div>
        <?php foreach($TaskTag as $key=>$value) { ;?>
        <div class="form-group">
                <label for="task_tag-<?php echo $key;?>">Тег</label>
                <?php if ($key>0) {?>
                    <div class="text-right" style="float:right;">
                        <span  id="TasksTag-delTaskTag-<?php echo $value->id;?>" role="button" title="Удалить" class="glyphicon glyphicon-remove-circle"></span>
                    </div>
                <?php } ?>
                <div class="list-group" id="TasksTag-visible-text-<?php echo $value->id;?>">
                     <div class="list-group-item list-group-item-action flex-column align-items-start">
                         <span class="badge badge-primary badge-pill">
                             <span id="TasksTag-edit-text-<?php echo $value->id;?>" role="button" class="glyphicon glyphicon-pencil"></span> 
                         </span>
                         <div id="TasksTag-show-text-<?php echo $value->id;?>" class="d-flex w-100 justify-content-between">
                            <?php echo $value->text;?>
                         </div>
                         
                     </div>
                </div>                
               <div class="input-group" style="display: none;" id="TasksTag-none-text-<?php echo $value->id;?>"> 
                    <textarea  class="form-control" id="TasksTag-text-<?php echo $value->id;?>" rows="3" data="<?php echo $value->id.':'.$value->taskid;?>">
                        <?php echo stripslashes($value->text);?>
                    </textarea>
                    <div class="input-group-addon">
                      <span id="TasksTag-update-text-<?php echo $value->id;?>" role="button" title="Сохранить" class="glyphicon glyphicon-save"></span>
                    </div>
               </div>
        </div>
        <?php }?>    
         <button type="button" class="btn btn-success">Добавить Тег</button>
    </form>
</div>
{% include "layouts/js.volt" %}
    <script src="/js/utils.js"></script>
    <script type="text/javascript">
        var taskid=d.getElementById('taskid').value;
        window.addEventListener('DOMContentLoaded', function() {
            var btn_success=d.forms[0].querySelector('.btn-success');
            btn_success.addEventListener('click',addTag);
            var buttons_all=d.querySelectorAll('[role="button"]');
            for (var i=0;i<buttons_all.length;i++) {
                buttons_all[i].addEventListener('click',Action);
            }
        });
    </script>
</body>
</html>