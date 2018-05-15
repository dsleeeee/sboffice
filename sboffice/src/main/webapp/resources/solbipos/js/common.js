"use strict";
!function( win, $ ){

  !"".trim && ( String.prototype.trim = function(){ return this.replace(/^\s|\s$/g, ""); } );
  //jQuery 가 없으면 return
  if( typeof $ !== "function" || !$.prototype.jquery ) return {};

  //id=1,id2=2,id3=3, ... > { id1:1, id2:2, id3:3, ... }
  function parseObject( str, sep ) {
    if( typeof str !== "string" ) return str;
    var arr = str.split( sep || "," )
    var obj = {};
    for( var li in arr ) {
        var keyValue = arr[ li ].split( "=" )
          , key = keyValue[ 0 ] && keyValue[ 0 ].trim()
          , val = keyValue[ 1 ] && keyValue[ 1 ].trim()
          , arr;
        if( !key ) continue;
        if( !obj.hasOwnProperty(key) ){
            obj[ key ] = val;
            continue;
        }
        if( (arr = obj[key]) instanceof Array ) {
          arr[ arr.length ] = val
        }
        else {
          obj[ key ] = [ arr, val ]; //중복되는 값이 생겼을 때 배열로 생성하면서 기존 값, 새로 넣을 값을 추가
        }
    }
    return obj;
  }

  // ajax 기본 설정
  $.ajaxSetup({
    cache: false
  });

  // jQuery Method 추가
  //ex ) $.extendName();
  $.extend({
    send: function( url ){
      if( typeof url !== "string" ) return;

      var method = { "get":"GET", "post":"POST" }[ ("" + arguments[1]).toLowerCase() ] || "POST"
        , target = arguments[ 2 ] || ""
        , temp = url.split( "?" )
        , path = temp[ 0 ]
        , params = parseObject( temp[1], "&" )
        , formId = "f" + new Date().getTime()
        , textHTML = "<form id=\"" + formId + "\" method=\"" + method
                    + "\" target=\"" + target + "\" action=\"" + path + "\">";

      for( var li in params ) {
        textHTML += "<input type=\"hidden\" name=\"" + li + "\" value=\"" + params[ li ] + "\" />";
      }
      $( "body" ).append( textHTML + "</form>" );
      $( "#" + formId ).submit().remove();
    }
    , open: function( urlOrSelector ) {
        var popup
        , options = typeof arguments[ 1 ] === "object" ? arguments[ 1 ]
                                                        : ( parseObject(arguments[1], ",") || {} )
        , target = options.target || "popup" + new Date().getTime()
        , width = options.width || -1
        , height = options.height || -1
        , top = options.top || ( screen.availHeight - height.replace(/[^0-9]/g, "") ) / 2
        , left = options.left || ( screen.availWidth - width.replace(/[^0-9]/g, "") ) / 2
        , popOptions = "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left
                        + ",scrollbars=1,resizable=1,status=1,toolbar=0,menubar=0";

      popup = win.open( "about:blank", target, popOptions );

      if( popup ) {
        try {
          var $form = $( urlOrSelector );
        } catch( e ) {
          var $form = {};
        }

        if( $form.length ) {
          $form.attr( "target", target ).submit();
        }
        else {
          $.send( urlOrSelector, options.method, target );
        }
        popup.focus();
      }
    }
    , postJSON: function( url, data, succ, fail ){
      return $.ajax({
        type: "POST",
        url: url,
        data: data,
        success: function(result) {
          if(result.status === "OK") {
            return succ(result);
          }
          else if(result.status === "FAIL") {
            return fail(result);
          }
          else if(result.status === "SESSION_EXFIRE") {
            s_alert.popOk(result.message, function() {
              location.href = result.url;
             });
          }
          else if(result.status === "SERVER_ERROR") {
            s_alert.pop(result.message);
          }
          else {
            var msg = result.status + " : " + result.message;
            alert(msg);
          }
        },
        cache: false,
        async:true,
        dataType: "json",
        beforeSend: function() {
          $("#_loadTent, #_loading").show();
        },
        complete: function() {
          $("#_loadTent, #_loading").hide();
        },
        error : function(){
          $("#_loadTent, #_loading").hide();
        }
      })
      .fail(function(){
        s_alert.pop("Ajax Fail");
      });
//      return $.post( url, data, func, "json" );
    }
    , postJSONSave: function( url, data, succ, fail ){
    	return $.ajax({
    		type: "POST",
    		url: url,
    		data: data,
    		success: function(result) {
    			if(result.status === "OK") {
    				return succ(result);
    			}
    			else if(result.status === "FAIL") {
    				return fail(result);
    			}
    			else if(result.status === "SESSION_EXFIRE") {
    				s_alert.popOk(result.message, function() {
    					location.href = result.url;
    				});
    			}
    			else if(result.status === "SERVER_ERROR") {
    				s_alert.pop(result.message);
    			}
    			else {
    				var msg = result.status + " : " + result.message;
    				alert(msg);
    			}
    		},
    		cache: false,
    		async:true,
    		dataType: "json",
    		beforeSend: function() {
    			$("#_saveTent, #_saving").show();
    		},
    		complete: function() {
    			$("#_saveTent, #_saving").hide();
    		},
    		error : function(){
    			$("#_saveTent, #_saving").hide();
    		}
    	})
    	.fail(function(){
    		s_alert.pop("Ajax Fail");
    	});
//      return $.post( url, data, func, "json" );
    }
    , postJSONArray: function( url, data, succ, fail ){
      return $.ajax({
        type: "POST",
        url: url,
        data: JSON.stringify(data),
        success: function(result) {
          if(result.status === "OK") {
            return succ(result);
          }
          else if(result.status === "FAIL") {
            return fail(result);
          }
          else if(result.status === "SESSION_EXFIRE") {
            s_alert.popOk(result.message, function() {
              location.href = result.url;
             });
          }
          else if(result.status === "SERVER_ERROR") {
            s_alert.pop(result.message);
          }
          else {
            var msg = result.status + " : " + result.message;
            alert(msg);
          }
        },
        cache: false,
        async:true,
        dataType: "json",
        contentType : 'application/json',
        processData: false,
        beforeSend: function() {
          $("#_loadTent, #_loading").show();
        },
        complete: function() {
          $("#_loadTent, #_loading").hide();
        },
        error : function(){
          $("#_loadTent, #_loading").hide();
        }
      })
      .fail(function(){
        s_alert.pop("Ajax Fail");
      });
//      return $.post( url, data, func, "json" );
    }
    , postJSONAsync: function( url, data, func ){
      return $.ajax({
        type: "POST",
        url: url,
        data: data,
        success: func,
        cache: false,
        async:true,
        dataType: "json",
        beforeSend: function() {

        },
        complete: function() {

        }
      });
    }
    , postJSONFile: function( url, form, succ, fail ){
      return $.ajax({
        url: url,
        type: "POST",
        data: form,
        processData: false, 
        contentType: false,
        cache: false,
        success : function(result) {
          alert("success");
        },
        error : function(result){
          alert("error");
        }
      })
      .fail(function(){
        s_alert.pop("Ajax Fail");
      });
//      return $.post( url, data, func, "json" );
      
      return false;
    }
    , countUtf8Bytes: function( s ){
      for( var b = 0, i = 0, c; c = s.charCodeAt(i++); b += c >> 11 ? 3 : (c >> 7 ? 2 : 1) );
      return b;
    }
    
  });

  // jQuery Selector Method 추가
  // ex ) $( selector ).extendName();
  $.fn.extend({
    changeClass: function( removeClassName, addClassName ){
      this.removeClass( removeClassName ).addClass( addClassName );
    }
    , className: function(){
        return this[ 0 ].className;
    }
  });

}( "undefined" != typeof window ? window : this, jQuery );

//트리 생성
var pNode;
var allMenu = "";
var bkmkMenu = "";
// 트리 생성
function makeTree(div, data, initMenu) {

  var tree = new wijmo.nav.TreeView(div, {
    displayMemberPath: 'nm',
    childItemsPath: 'items',
    autoCollapse: true,
    expandOnClick: false
  });

  // 트리의 아이템이 load 완료 되었을 때 이벤트
  tree.loadedItems.addHandler(function(s, e) {
      // 아이콘 Class 추가
      for (var node = s.getFirstNode(); node; node = node.nextSibling()) {
        if(!isEmpty(node)){
          wijmo.addClass(node.element, node.dataItem.icon);
        }
      }
      s.collapseToLevel(0);

      // 초기 메뉴(현재 메뉴) 설정
      if(initMenu) {
        for (var node = s.getFirstNode(); node; node = node.next()) {
          if(isEmpty(node.nodes)) {
            if(!isEmpty(node.dataItem) && node.dataItem.cd == initMenu) {
              s.selectedItem = node.dataItem;
            }
          }
        }
      }
  });

  // 선택된 메뉴가 변경 되었을 때 이벤트
  tree.selectedItemChanged.addHandler(function(s, e) {
    // 이전 메뉴의 클래스 제거
    if(pNode) {
      for (var node = pNode; node; node = node.parentNode) {
        wijmo.removeClass(node.element, "on");
      }
    }
    // 선택된 메뉴에 클래스 추가
    for (var node = s.selectedNode; node; node = node.parentNode) {
      wijmo.addClass(node.element, "on");
    }
    pNode = s.selectedNode;
  });

  // 아이템 클릭 시 이벤트
  tree.itemClicked.addHandler(function(s, e) {
    // URL 이 있을 경우 페이지 이동
    if(!isEmpty(s.selectedNode.dataItem.url)) {
      location.href = s.selectedNode.dataItem.url;
    }
    // 같은 메뉴를 다시 선택 했을 때 메뉴 닫기 기능
    if( pNode == s.selectedNode) {
      s.selectedNode.isCollapsed = !s.selectedNode.isCollapsed;
    }
    else {
      s.selectedNode.isCollapsed = false;
    }
  });

  /* Tree 생성자에서 데이터를 넣는 경우에는 이벤트 핸들러를 생성자에 넣을 수 있다.
  데이터를 생성자에서 넣으면서 이벤트를 나중에 선언하면 생성 시 이벤트 처리 안됨
  아래 처럼 이벤트를 다 선언한 후에 데이터를 넣어야 한다.
  */
  tree.itemsSource = data;

  return tree;
}

