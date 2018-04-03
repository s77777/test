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
                <div class="col-lg-12">
                    <div class="input-group">
                         <input id='search' type="text" class="form-control" placeholder="Поиск ...">
                         <span class="input-group-btn">
                           <button id="search_button" class="btn btn-info" type="button">ОК</button>
                         </span>
                    </div>
                </div>
                <div class="col-lg-12">
                    <br/>
                </div>
                <div id="result" class="col-lg-12">
                    <div class="list-group">
                        <?php foreach($TasksList as $key=>$value) {?>
                        <a id="a<?php echo $key;?>" href="<?php echo '/Task/Index/'.$value->id;?>" class="list-group-item list-group-item-action flex-column align-items-start">
                            <div class="d-flex w-100 justify-content-between">
                                <h5 class="mb-1">Задача № <?php echo $value->id;?></h5>
                            </div>
                            <p class="mb-1"><?php echo $value->name;?></p>
                                <small><?php echo "Приоритет: <b>{$value->priority}</b>&nbsp;&bull;&nbsp;Статус: <b>{$value->status}</b>&nbsp;&bull;&nbsp;Дата создания: {$value->dt}";?></small>
                        </a>
                        <?php }?>
                    </div>
                </div>
        </div>
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="js/vanilla.js"></script>
        <script src="js/utils.js"></script>
        <script type="text/javascript">
            window.addEventListener('DOMContentLoaded', function() {
                var search=d.getElementById('search');
                search.addEventListener('keyup',function(e){
                    e.preventDefault();
                    if (e.target.value.length>=3) {
                        var obj={'search':e.target.value};
                        JsonRequest('Index/getSearchList',obj,getListSearch);
                    } else if (e.keyCode==13 && e.target.value!='') {
                        var obj={'search':e.target.value};
                        JsonRequest('Index/getSearchList',obj,getListResult);
                    } else if (e.keyCode==8) {
                        removeLoadSearch();
                    }
                });
                d.getElementById('search_button').addEventListener('click',function(e){
                    if (search.value!='') {
                        JsonRequest('Index/getSearchList',obj,getListResult);
                    }   
                });
            });
        </script>
    </body>
</html>