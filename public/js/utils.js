var d=document;
var arrMsg={'error_update':'Во время сохранения произошла ошибка!',
	'delOk':'Запись успешно удалена!',				
	'saveOK':'Запись сохранена!',
	'error_save':'Во время сохранения произошла ошибка!',
	'notFound':'По Вашему запросу ничего не найдено, попробуйте ввести другой запрос!',
	'errorRequest':'Ошибка запроса. Статус ',
	'TaskNumber':'Задача № ',
	'Prioritet':' Приоритет: <b>',
	'Status':' Статус: <b>',
	'cDate':' Дата создания: ',
	'btnSave':'Сохранить',
	'btnDel':'Удалить',
								};
function JsonRequest(url,objdata,callback) {   
        var xhr = new XMLHttpRequest();
        xhr.open('POST', url);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.onload = callback;
        xhr.send(JSON.stringify(objdata));  
}

function getListSearch(e) {
    e.preventDefault();
    if (e.target.status === 200) {
        var result=JSON.parse(e.target.responseText);      
        if (result.length>0) {
            removeLoadSearch();				
            var select=d.getElementById('load_search');
            if (null==select) {
                var attrs = {'id':'load_search','size': 6,'name':'load_search','class':'search'};
                select=new Element('select',attrs);
                select.addEventListener('keyup',is_selected);
            }
            for(var i=0;i<result.length;i++){
                var option=new Element('option');
                option.textContent=result[i].name;
                option.addEventListener('click',is_selected);
                select.appendChild(option);
            }
            var search=d.getElementById('search');
            var cor=search.getBoundingClientRect();
            select.style.top=cor.top+cor.height+'px' ;
            select.style.left=cor.left+'px';
            select.style.width=cor.width+'px';
            d.body.appendChild(select);
            select.querySelector('option:first-child').selected=true;
            select.focus();
        }
    }
    else if (e.target.status !== 200) {
        console.log(arrMsg.errorRequest + e.target.status);
    }
}

function getListResult(e) {
    e.preventDefault();
    if (e.target.status === 200) {
	var result=JSON.parse(e.target.responseText);
	if (result.success) {
            console.log()
            //window.location.assign(active.href);
	}	
    }
    else if (e.target.status !== 200) {
        console.log(arrMsg.errorRequest + e.target.status);
    }	
}

function getListResultSearch(e) {
    e.preventDefault();
    if (e.target.status === 200) {
        removeLoadSearch();
        var result=JSON.parse(e.target.responseText);
        var elemParent=d.getElementById('result').querySelector('.list-group');
        elemParent.innerHTML='';
        if (result.length>0) {
            renderResult(result,elemParent);    
        } else {
            var p=new Element('p',{'class':'mb-1'});
            p.textContent=arrMsg.notFound;
            elemParent.appendChild(p);
        }
    }
    else if (e.target.status !== 200) {
        console.log(arrMsg.errorRequest + e.target.status);
    }   
}

function sendReq(obj) {
    if (obj.search!='') {				
        JsonRequest('Index/getSearchList',obj,getListResultSearch);
    }
}

function is_selected(e) {
    var search=d.getElementById('search');
    var oldValue=search.value;
        search.value=e.target.value;
    var obj={'search':''};
        obj={'search':search.value};
    if (e.type=='keyup' && e.keyCode==13) {
        sendReq(obj);
        return true;
    } else if (e.type=='keyup' && e.keyCode==8) {
        search.value=oldValue.substring(0, str.length - 1);
	search.focus();
    } else if (e.type=='click') {
	sendReq(obj);
	return true;
    }
    if (search.value=='') {
        removeLoadSearch();
        return true;
    }
}

function Element(tag,attr) {
    var elem=document.createElement(tag);
    if (attr) {
        for (var key in attr) {
            elem.setAttribute(key,
             (key!='style')?attr[key]:setStyle(attr[key])
            ); 
        }
    }
     function setStyle(args) {
	var style=[];
	for (var css in args) {
            style.push(css+':'+args[css])
	}
	return style.join(';');
    }
    return elem;
}

function renderResult(result,elemParent) {
    for(var i=0;i<result.length;i++){
        var a=new Element('a',{'id':'a'+i,'href':'Task/Index/'+result[i].id,
                          'class':'list-group-item list-group-item-action flex-column align-items-start',});
        var div=new Element('div',{'class':'d-flex w-100 justify-content-between'});
        var h5=new Element('h5',{'class':'mb-1'});
        h5.textContent=arrMsg.TaskNumber+result[i].id;
        div.appendChild(h5);
        a.appendChild(div);
        var p=new Element('p',{'class':'mb-1'});
        p.textContent=result[i].name;
        a.appendChild(p);
        var small=new Element('small');
        small.innerHTML=arrMsg.Prioritet+result[i].priority+'</b>&nbsp;&bull;&nbsp;'+arrMsg.Status+result[i].status+'</b>&nbsp;&bull;&nbsp;'+arrMsg.cDate+result[i].dt;
        a.appendChild(small);
        elemParent.appendChild(a);
    }
}

function addTask(e) {
   e.preventDefault();
   var input = e.target.parentNode.querySelectorAll('input, select');
   var textArea=e.target.parentNode.querySelectorAll('textarea');
   var Data = new Object();
   Data['tasks'] = {};
   Data['tasks_tag'] = [];
   for (var i=0;i<input.length;i++) {
      var name=input[i].id.split('-');
      Data['tasks'][name[1]]=input[i].value;
   }
   for (var i=0;i<textArea.length;i++) {
      var name=textArea[i].id.split('-');
      var obj=new Object();
      obj[name[1]]=textArea[i].value;
      Data['tasks_tag'].push(obj);
   }
   Data['mode']='ins';
			console.log(Data);
   JsonRequest("/Task/saveTask",Data,getListResult);	
}

function addTag(e) {
   e.preventDefault();
    var f = d.forms[0];
    var divBlock=f.querySelector('div.form-group:last-of-type').cloneNode(true);
    var arrId=divBlock.querySelectorAll('[id],[data]');
    var label=divBlock.querySelector('label');
        afor=label.getAttribute('for');
    var oi=afor.split('-');
        i=Number(oi[1])+1;
	label.setAttribute('for',oi[0]+'-'+i);
    arrId.forEach(function (item,n,arrId){
        var arr=arrId[n].id.split('-');
        var c=arr.length;
        arr[c-1]=(oi[1]===arr[c-1])?i:0;
	arrId[n].id=arr.join('-');
	if (arr[1]=='none') {
            divBlock.querySelector('[id="'+arrId[n].id+'"]').style.display='';				
        } else if (arr[1]=='visible') {
            divBlock.querySelector('[id="'+arrId[n].id+'"]').style.display='none';
	} else if (undefined!=arrId[n].value) {
            arrId[n].value='';
	}
    });
    var btn=divBlock.querySelectorAll('[role="button"]');
    for (var i=0;i<btn.length;i++) {
        btn[i].addEventListener('click',Action);
    }
    f.insertBefore(divBlock, f.querySelector('.btn-success'));
}

function deleting(e) {
    e.preventDefault();
    var a=e.target.getAttribute('data')
    d.getElementById(a).remove();
}

function removeLoadSearch() {
    var ls=d.getElementById('load_search');
    if (null!=ls) ls.remove();
    return true;
}

function Action(e) {
    e.preventDefault();
    var Data=new Object();
    var a = e.target.id.split('-');
    if (a[1]=='picklist') {
	window.location.assign("/");
    } else if (a[1]=='delTask' || a[1]=='delTaskTag') {
	Data['id']=(a[3])?a[3]:taskid;
	Data['table']=a[0];
	JsonRequest("/Task/deleteTask",Data,function(e){	
            if (e.target.status === 200) {
                var result=JSON.parse(e.target.responseText);
		if (result.success) {
                    alert(arrMsg.delOk);
                    window.location.assign('/');
		} else {
                    alert(arrMsg.error_update);				
		}
            }
        });
    } else if (a[1]=='edit') {
	a[1]='none';
	setStyleDisplay(a.join('-'),'');
	a[1]='visible'
	setStyleDisplay(a.join('-'),'none');
    } else if (a[1]=='save' || a[1]=='update')  {
	Data={'id':taskid};
	var id=a[0]+'-'+a[2]+((a[3])?('-'+a[3]):'');
	var value=d.getElementById(id).value;
	Data['field']=new Object;
	Data['field'][a[2]]=value;
	Data['id']=(a[3])?a[3]:taskid;
	Data['table']=a[0];												
	Data['mode']=a[1];
        JsonRequest("/Task/saveTask",Data,function(e){	
            if (e.target.status === 200) {
		var result=JSON.parse(e.target.responseText);
		if (result.success) {
                    a[1]='visible';
                    id=a.join('-');
                    setStyleDisplay(id,'');
                    a[1]='show';
                    id=a.join('-');
                    d.getElementById(id).textContent=value;
                    a[1]='none';
                    id=a.join('-');
                    setStyleDisplay(id,'none');																								
                } else {
                    alert(arrMsg.error_save);				
		}
            }
	});												
    }
}

function setStyleDisplay(id,style) {
    d.getElementById(id).style.display=style;
}