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
            <h1>Задачи с номером <?php echo $params[0];?> не существует!<small></small></h1>
        </div>
    </header>
    <div class="col-lg-12 text-right">
        <span class="badge badge-default badge-pill">
            <span id="task-picklist" role="button" class="glyphicon glyphicon-list" id="picklist" title="К списку задач"></span> 
        </span>
    </div>
</div>
{% include "layouts/js.volt" %}
    <script src="/js/utils.js"></script>
    <script type="text/javascript">
        window.addEventListener('DOMContentLoaded', function() {
            var buttons_all=d.querySelectorAll('[role="button"]');
            for (var i=0;i<buttons_all.length;i++) {
                buttons_all[i].addEventListener('click',Action);
            }
        });
    </script>
</body>
</html>