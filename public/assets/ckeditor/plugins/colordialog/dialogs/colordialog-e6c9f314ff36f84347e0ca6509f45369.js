CKEDITOR.dialog.add("colordialog",function(e){function t(){p.getById(v).removeStyle("background-color"),i.getContentElement("picker","selectedColor").setValue(""),s&&s.removeAttribute("aria-selected"),s=null}function o(e){var t,e=e.data.getTarget();"td"==e.getName()&&(t=e.getChild(0).getHtml())&&(s=e,s.setAttribute("aria-selected",!0),i.getContentElement("picker","selectedColor").setValue(t))}function l(e){for(var e=e.replace(/^#/,""),t=0,o=[];2>=t;t++)o[t]=parseInt(e.substr(2*t,2),16);return"#"+(165<=.2126*o[0]+.7152*o[1]+.0722*o[2]?"000":"fff")}function r(e){!e.name&&(e=new CKEDITOR.event(e));var t,o=!/mouse/.test(e.name),r=e.data.getTarget();"td"==r.getName()&&(t=r.getChild(0).getHtml())&&(n(e),o?d=r:c=r,o&&(r.setStyle("border-color",l(t)),r.setStyle("border-style","dotted")),p.getById(f).setStyle("background-color",t),p.getById(h).setHtml(t))}function n(e){if(e=!/mouse/.test(e.name)&&d){var t=e.getChild(0).getHtml();e.setStyle("border-color",t),e.setStyle("border-style","solid")}!d&&!c&&(p.getById(f).removeStyle("background-color"),p.getById(h).setHtml("&nbsp;"))}function a(t){var l=t.data,r=l.getTarget(),n=l.getKeystroke(),a="rtl"==e.lang.dir;switch(n){case 38:(t=r.getParent().getPrevious())&&(t=t.getChild([r.getIndex()]),t.focus()),l.preventDefault();break;case 40:(t=r.getParent().getNext())&&(t=t.getChild([r.getIndex()]))&&1==t.type&&t.focus(),l.preventDefault();break;case 32:case 13:o(t),l.preventDefault();break;case a?37:39:(t=r.getNext())?1==t.type&&(t.focus(),l.preventDefault(!0)):(t=r.getParent().getNext())&&(t=t.getChild([0]))&&1==t.type&&(t.focus(),l.preventDefault(!0));break;case a?39:37:(t=r.getPrevious())?(t.focus(),l.preventDefault(!0)):(t=r.getParent().getPrevious())&&(t=t.getLast(),t.focus(),l.preventDefault(!0))}}var i,s,d,c,g,u=CKEDITOR.dom.element,p=CKEDITOR.document,b=e.lang.colordialog,y={type:"html",html:"&nbsp;"},m=function(e){return CKEDITOR.tools.getNextId()+"_"+e},f=m("hicolor"),h=m("hicolortext"),v=m("selhicolor");return function(){function e(e,o){for(var r=e;e+3>r;r++){var n=new u(g.$.insertRow(-1));n.setAttribute("role","row");for(var a=o;o+3>a;a++)for(var i=0;6>i;i++)t(n.$,"#"+l[a]+l[i]+l[r])}}function t(e,t){var l=new u(e.insertCell(-1));l.setAttribute("class","ColorCell"),l.setAttribute("tabIndex",-1),l.setAttribute("role","gridcell"),l.on("keydown",a),l.on("click",o),l.on("focus",r),l.on("blur",n),l.setStyle("background-color",t),l.setStyle("border","1px solid "+t),l.setStyle("width","14px"),l.setStyle("height","14px");var i=m("color_table_cell");l.setAttribute("aria-labelledby",i),l.append(CKEDITOR.dom.element.createFromHtml('<span id="'+i+'" class="cke_voice_label">'+t+"</span>",CKEDITOR.document))}g=CKEDITOR.dom.element.createFromHtml('<table tabIndex="-1" aria-label="'+b.options+'" role="grid" style="border-collapse:separate;" cellspacing="0"><caption class="cke_voice_label">'+b.options+'</caption><tbody role="presentation"></tbody></table>'),g.on("mouseover",r),g.on("mouseout",n);var l="00 33 66 99 cc ff".split(" ");e(0,0),e(3,0),e(0,3),e(3,3);var i=new u(g.$.insertRow(-1));i.setAttribute("role","row");for(var s=0;6>s;s++)t(i.$,"#"+l[s]+l[s]+l[s]);for(s=0;12>s;s++)t(i.$,"#000000")}(),{title:b.title,minWidth:360,minHeight:220,onLoad:function(){i=this},onHide:function(){t();var e=d.getChild(0).getHtml();d.setStyle("border-color",e),d.setStyle("border-style","solid"),p.getById(f).removeStyle("background-color"),p.getById(h).setHtml("&nbsp;"),d=null},contents:[{id:"picker",label:b.title,accessKey:"I",elements:[{type:"hbox",padding:0,widths:["70%","10%","30%"],children:[{type:"html",html:"<div></div>",onLoad:function(){CKEDITOR.document.getById(this.domId).append(g)},focus:function(){(d||this.getElement().getElementsByTag("td").getItem(0)).focus()}},y,{type:"vbox",padding:0,widths:["70%","5%","25%"],children:[{type:"html",html:"<span>"+b.highlight+'</span><div id="'+f+'" style="border: 1px solid; height: 74px; width: 74px;"></div><div id="'+h+'">&nbsp;</div><span>'+b.selected+'</span><div id="'+v+'" style="border: 1px solid; height: 20px; width: 74px;"></div>'},{type:"text",label:b.selected,labelStyle:"display:none",id:"selectedColor",style:"width: 76px;margin-top:4px",onChange:function(){try{p.getById(v).setStyle("background-color",this.getValue())}catch(e){t()}}},y,{type:"button",id:"clear",label:b.clear,onClick:t}]}]}]}]}});