<!DOCTYPE HTML>
<html lang="ru">
<head>
	<title>Test</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
<!--[if IE]><meta http-equiv="x-ua-compatible" content="ie=edge"><![endif]-->
<style>
body{
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}	
.main {
	display: block;
	height: 100vh;
	margin: 0 auto;
	background: #e6e3e3;
	max-width: 500px;  
}
.top {
    	display: block;
	margin: 0 auto;
	width: 100%;
	float: left;
	max-height: 50%;
}
.inner {
	display: block;
	margin: 0 auto;
	width: 50%;
	float: left;
	max-height: 50%;
	
}
.block {
	display: block;
	padding: 1em;
}
.ce {
	background: #eaeade;
        min-height: 32vh;
}

.ce input:not(#add),textarea {
	margin-bottom: 2em;
}

.ce input,textarea {
	width: 100%;
}

.desc {
	width: 50%;
        position: relative;
        min-height: 32vh;
        background: #dedec4;
	overflow: hidden;
}

.footer {
	display: block;
	margin: 0 auto;
	background: #868684;
	max-width: 500px;
	height: 50px;
	margin-top: -50px;
}
.visbl {
	visibility: visible;
}

.unvisbl {
	display: none;
}
.cnt {
	clear: both;	
	display: block;
	margin: 0 auto;
	width: 100%;
}

#cnt li {
	display: block;
	cursor: pointer;
	margin: 0.5em;
	padding: 0.3em;
}
</style>		
</head>
<body>
	<div class="main">
            <div class="top">
		<div class="inner ce">
		    <div class="block">
			<form id="form1" name="form1" action="#">
				<label>Имя пункта</label><br/>
				<input id="name" name="name" type="text" placeholder="обязательно к заполению" required>
				<label>Описание пункта</label><br/>
				<textarea id="decription" name="decription" placeholder="обязательно к заполению" required></textarea>
				<input id="add" type='submit' value="+ Добавить">	
			</form>	
		    </div>		
		</div>
		<div class="inner desc">
                    <div class="block" id="desc"></div>    
		</div>
            </div>   
		<div class="cnt"><ul id="cnt"></ul></div>
	</div>
	<footer class="footer">
		<span class="badge badge-default badge-pill" rel="" title="Редактировать"><i class="material-icons">&#xE254;</i></span>
	</footer>
<script type="text/javascript">
    'use strict';
        let Ls = {
            setItem: function (key, value) {
                return Promise.resolve().then(function () {
                    localStorage.setItem(key, value);
                });
            },
            getItem: function (key) {
                return Promise.resolve().then(function () {
                    return localStorage.getItem(key);
                });
            }
        };
	Ls.getItem('items').then(function ($value) {
		if ('undefined'!=$value) {
		    var addData=JSON.parse($value);		
		    for (var i=0;i<addData.length;i++) {
		       addItem(addData[i]);
		    }
		}
        });
	
        var ul=document.getElementById('cnt');

	function Element(tag,attr) {
		var elem=document.createElement(tag);
		if (attr) {
			for (var key in attr) {
				elem.setAttribute(key,
				 (key!='style')?attr[key]:setStyle(attr[key])
				); 
			}
		}
		return elem;
		function setStyle(args) {
		  var style=[];
		  for (var css in args) {
		    style.push(css+':'+args[css])
		  }
		return style.join(';');
		}
	}
        
        function addItem(data) {		
            var li=new Element('li');
            for (var key in data) {
                if (key=='name') {
                    var $class={'class':'visbl'};
                } else {
                    var $class={'class':'unvisbl'};
                }
                var s=new Element('span',$class);
                s.innerHTML=data[key];
                li.appendChild(s);
                li.addEventListener('mouseover',OnMouseOver);
            }
	    ul.appendChild(li);
	    return getItems(ul);
        }
	
	function getItems(ul) {
		var addData=new Array();
		var ul=ul.querySelectorAll('li');
		for (var i=0;i<ul.length;i++) {
		    var itemData=new Object();
		    var spans=ul[i].childNodes;
		    itemData['name']=spans[0].innerHTML;
		    itemData['decription']=spans[1].innerHTML;
		    addData.push(itemData);
		}
		return addData;
	}
        
	document.addEventListener('submit',function(e){
		e.preventDefault();
		var input=e.target.parentNode.querySelectorAll('textarea,input:not([type=submit]');
		var itemData=new Object();
		for (var i=0;i<input.length;i++) {
			itemData[input[i].name]=input[i].value;
		}
                var addData=addItem(itemData);
                Ls.setItem('items', JSON.stringify(addData)).then(function () {
                    console.log(Ls.getItem('items'))                 
		});
        });
	
	function OnMouseOver(e) {
		var dsc=e.target.querySelector('span.unvisbl');
		if (null!=dsc) {
		   document.getElementById('desc').innerHTML=dsc.innerHTML;
		}
	}
	        
</script>
</body>
</html>