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
            <h1>{{taskTitle}}<small></small></h1>
        </div>
    </header>
    <div class="col-lg-12"><br/></div>
    <form method="post" action="#">
        <div class="form-group">
          <label for="name">Название задачи</label>
          <input type="text" class="form-control" id="tasks-name" placeholder="" required>
        </div>
        <div class="form-group">
          <label for="priorityid">Приоритет</label>
          <select class="form-control" id="tasks-priorityid">
            <?php foreach($priority as $key=>$value) { ;?>
                <option value="<?php echo $value->id;?>"><?php echo $value->text;?></option>
            <?php }?>    
          </select>
        </div>
        <div class="form-group">
          <label for="statusid">Статус</label>
          <select class="form-control" id="tasks-statusid">
            <?php foreach($status as $key=>$value) { ;?>
                <option value="<?php echo $value->id;?>"><?php echo $value->text;?></option>
            <?php }?>    
          </select>
        </div>
        <div class="form-group">   
                <label for="tasks_tag-text-0">Тег</label>
<!--                <div class="text-right" style="float:right;">
                    <span class="badge badge-default badge-pill" rel="">X</span>
                </div>--> 
               <textarea class="form-control" id="tasks_tag-text-0" rows="3"></textarea>
                
        </div>
         <button type="submit" class="btn btn-primary">Создать</button>
         <button type="button" class="btn btn-success">Добавить Тег</button>
    </form>
</div>
{% include "layouts/js.volt" %}
    <script src="/js/utils.js"></script>
    <script type="text/javascript">
        window.addEventListener('DOMContentLoaded', function(e) {
            var btn_prim=d.forms[0].querySelector('.btn-primary');
            btn_prim.addEventListener('click',addTask);
            var btn_success=d.forms[0].querySelector('.btn-success');
            btn_success.addEventListener('click',addTag);
        });
    </script>
</body>
</html>