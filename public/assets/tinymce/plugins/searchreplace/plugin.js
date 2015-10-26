!function(){function a(a,b,c,d,e){function f(a,b){if(b=b||0,!a[0])throw"findAndReplaceDOMText cannot handle zero-length matches";var c=a.index;if(b>0){var d=a[b];if(!d)throw"Invalid capture group";c+=a[0].indexOf(d),a[0]=d}return[c,c+a[0].length,[a[0]]]}function g(a){var b;if(3===a.nodeType)return a.data;if(n[a.nodeName]&&!m[a.nodeName])return"";if(b="",(m[a.nodeName]||o[a.nodeName])&&(b+="\n"),a=a.firstChild)do b+=g(a);while(a=a.nextSibling);return b}function h(a,b,c){var d,e,f,g,h=[],i=0,j=a,k=b.shift(),l=0;a:for(;;){if((m[j.nodeName]||o[j.nodeName])&&i++,3===j.nodeType&&(!e&&j.length+i>=k[1]?(e=j,g=k[1]-i):d&&h.push(j),!d&&j.length+i>k[0]&&(d=j,f=k[0]-i),i+=j.length),d&&e){if(j=c({startNode:d,startNodeIndex:f,endNode:e,endNodeIndex:g,innerNodes:h,match:k[2],matchIndex:l}),i-=e.length-g,d=null,e=null,h=[],k=b.shift(),l++,!k)break}else{if((!n[j.nodeName]||m[j.nodeName])&&j.firstChild){j=j.firstChild;continue}if(j.nextSibling){j=j.nextSibling;continue}}for(;;){if(j.nextSibling){j=j.nextSibling;break}if(j.parentNode===a)break a;j=j.parentNode}}}function i(a){var b;if("function"!=typeof a){var c=a.nodeType?a:l.createElement(a);b=function(a,b){var d=c.cloneNode(!1);return d.setAttribute("data-mce-index",b),a&&d.appendChild(l.createTextNode(a)),d}}else b=a;return function(a){var c,d,e,f=a.startNode,g=a.endNode,h=a.matchIndex;if(f===g){var i=f;e=i.parentNode,a.startNodeIndex>0&&(c=l.createTextNode(i.data.substring(0,a.startNodeIndex)),e.insertBefore(c,i));var j=b(a.match[0],h);return e.insertBefore(j,i),a.endNodeIndex<i.length&&(d=l.createTextNode(i.data.substring(a.endNodeIndex)),e.insertBefore(d,i)),i.parentNode.removeChild(i),j}c=l.createTextNode(f.data.substring(0,a.startNodeIndex)),d=l.createTextNode(g.data.substring(a.endNodeIndex));for(var k=b(f.data.substring(a.startNodeIndex),h),m=[],n=0,o=a.innerNodes.length;o>n;++n){var p=a.innerNodes[n],q=b(p.data,h);p.parentNode.replaceChild(q,p),m.push(q)}var r=b(g.data.substring(0,a.endNodeIndex),h);return e=f.parentNode,e.insertBefore(c,f),e.insertBefore(k,f),e.removeChild(f),e=g.parentNode,e.insertBefore(r,g),e.insertBefore(d,g),e.removeChild(g),r}}var j,k,l,m,n,o,p=[],q=0;if(l=b.ownerDocument,m=e.getBlockElements(),n=e.getWhiteSpaceElements(),o=e.getShortEndedElements(),k=g(b)){if(a.global)for(;j=a.exec(k);)p.push(f(j,d));else j=k.match(a),p.push(f(j,d));return p.length&&(q=p.length,h(b,p,i(c))),q}}function b(b){function c(){function a(){f.statusbar.find("#next").disabled(!g(l+1).length),f.statusbar.find("#prev").disabled(!g(l-1).length)}function c(){tinymce.ui.MessageBox.alert("Could not find the specified string.",function(){f.find("#find")[0].focus()})}var d,e={};d=tinymce.trim(b.selection.getContent({format:"text"}));var f=tinymce.ui.Factory.create({type:"window",layout:"flex",pack:"center",align:"center",onClose:function(){b.focus(),k.done()},onSubmit:function(b){var d,h,i,j;return b.preventDefault(),h=f.find("#case").checked(),j=f.find("#words").checked(),i=f.find("#find").value(),i.length?e.text==i&&e.caseState==h&&e.wholeWord==j?0===g(l+1).length?void c():(k.next(),void a()):(d=k.find(i,h,j),d||c(),f.statusbar.items().slice(1).disabled(0===d),a(),void(e={text:i,caseState:h,wholeWord:j})):(k.done(!1),void f.statusbar.items().slice(1).disabled(!0))},buttons:[{text:"Find",subtype:"primary",onclick:function(){f.submit()}},{text:"Replace",disabled:!0,onclick:function(){k.replace(f.find("#replace").value())||(f.statusbar.items().slice(1).disabled(!0),l=-1,e={})}},{text:"Replace all",disabled:!0,onclick:function(){k.replace(f.find("#replace").value(),!0,!0),f.statusbar.items().slice(1).disabled(!0),e={}}},{type:"spacer",flex:1},{text:"Prev",name:"prev",disabled:!0,onclick:function(){k.prev(),a()}},{text:"Next",name:"next",disabled:!0,onclick:function(){k.next(),a()}}],title:"Find and replace",items:{type:"form",padding:20,labelGap:30,spacing:10,items:[{type:"textbox",name:"find",size:40,label:"Find",value:d},{type:"textbox",name:"replace",size:40,label:"Replace with"},{type:"checkbox",name:"case",text:"Match case",label:" "},{type:"checkbox",name:"words",text:"Whole words",label:" "}]}}).renderTo().reflow()}function d(a){var b=a.getAttribute("data-mce-index");return"number"==typeof b?""+b:b}function e(c){var d,e;return e=b.dom.create("span",{"data-mce-bogus":1}),e.className="mce-match-marker",d=b.getBody(),k.done(!1),a(c,d,e,!1,b.schema)}function f(a){var b=a.parentNode;a.firstChild&&b.insertBefore(a.firstChild,a),a.parentNode.removeChild(a)}function g(a){var c,e=[];if(c=tinymce.toArray(b.getBody().getElementsByTagName("span")),c.length)for(var f=0;f<c.length;f++){var g=d(c[f]);null!==g&&g.length&&g===a.toString()&&e.push(c[f])}return e}function h(a){var c=l,d=b.dom;a=a!==!1,a?c++:c--,d.removeClass(g(l),"mce-match-marker-selected");var e=g(c);return e.length?(d.addClass(g(c),"mce-match-marker-selected"),b.selection.scrollIntoView(e[0]),c):-1}function i(a){var c=b.dom,d=a.parentNode;c.remove(a),c.isEmpty(d)&&c.remove(d)}function j(a){var b=d(a);return null!==b&&b.length>0}var k=this,l=-1;k.init=function(a){a.addMenuItem("searchreplace",{text:"Find and replace",shortcut:"Meta+F",onclick:c,separator:"before",context:"edit"}),a.addButton("searchreplace",{tooltip:"Find and replace",shortcut:"Meta+F",onclick:c}),a.addCommand("SearchReplace",c),a.shortcuts.add("Meta+F","",c)},k.find=function(a,b,c){a=a.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g,"\\$&"),a=c?"\\b"+a+"\\b":a;var d=e(new RegExp(a,b?"g":"gi"));return d&&(l=-1,l=h(!0)),d},k.next=function(){var a=h(!0);-1!==a&&(l=a)},k.prev=function(){var a=h(!1);-1!==a&&(l=a)},k.replace=function(a,c,e){var h,m,n,o,p,q,r=l;for(c=c!==!1,n=b.getBody(),m=tinymce.grep(tinymce.toArray(n.getElementsByTagName("span")),j),h=0;h<m.length;h++){var s=d(m[h]);if(o=p=parseInt(s,10),e||o===l){for(a.length?(m[h].firstChild.nodeValue=a,f(m[h])):i(m[h]);m[++h];){if(o=parseInt(d(m[h]),10),o!==p){h--;break}i(m[h])}c&&r--}else p>l&&m[h].setAttribute("data-mce-index",p-1)}return b.undoManager.add(),l=r,c?(q=g(r+1).length>0,k.next()):(q=g(r-1).length>0,k.prev()),!e&&q},k.done=function(a){var c,e,g,h;for(e=tinymce.toArray(b.getBody().getElementsByTagName("span")),c=0;c<e.length;c++){var i=d(e[c]);null!==i&&i.length&&(i===l.toString()&&(g||(g=e[c].firstChild),h=e[c].firstChild),f(e[c]))}if(g&&h){var j=b.dom.createRng();return j.setStart(g,0),j.setEnd(h,h.data.length),a!==!1&&b.selection.setRng(j),j}}}tinymce.PluginManager.add("searchreplace",b)}();