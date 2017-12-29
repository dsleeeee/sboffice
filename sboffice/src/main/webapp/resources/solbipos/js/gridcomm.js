"use strict";
!function( win, $ ){
  
  /*
  $(document).ajaxStart(function() {
    $("#loading").show();
  });
  $(document).ajaxComplete(function() {
    $("#loading").hide();
  });
  $(document).ajaxError(function() {
    $("#loading").hide();
  });
  */
  
  // 그리드
  var wgrid = {
      genGrid: function( div, columns, resrceCd, gridIdx, columnLayout ) {
        var g = new wijmo.grid.FlexGrid(div, {
          columns : columns,
          isReadOnly : true,
          showSort : true,
          autoGenerateColumns: false,  // 이거 안하면 컬럼이 자동으로 막 생김
          formatItem : function(s, e) {
            // 표시 화면 입력 생성
            if (e.panel == s.topLeftCells) {
              e.cell.innerHTML = "<i class=\"fa fa-bars\" aria-hidden=\"true\"></i>";
            }
          },
          draggedColumn : function(s, e){
            wgrid.setGridItem(resrceCd, gridIdx, s.columnLayout);
          }
        });
        
        // 저장된 레이아웃이 있을 경우 적용
        if(columnLayout !== undefined) {
          g.columnLayout = columnLayout;
        }
        
        genGridPicker(g, resrceCd, gridIdx);
        
        function genGridPicker(grid, resrceCd, gridIdx) {
          
          // column picker element add 
          var item = {};
          item.style = "display:none";
          item.id = grid._e.id + "picker";
          item.cl = "column-picker";
          var html = wijmo.format("<div style=\"{style}\"><div id=\"{id}\" class=\"{cl}\"></div></div>", item);
          $(".content_page").append(html);
          
          // column picker gen
          wgridPic.genGridPicker("#" + item.id, grid, resrceCd, gridIdx);
        }
        
        return g; 
      },
      
      // columnsLayout 서버에 저장
      setGridItem: function(resrceCd, idx, columnLayout) {
        
        var param = {};
        
        param.resrceCd = resrceCd;
        param.gridIdx = idx;
        param.columnItem = columnLayout;
        
        $.postJSONAsync("/setGridItem.sb", param, function(result) {
          console.log("resource : " + resrceCd + ", idx : " + idx + ", setGridItem success..");
        })
        .fail(function(){
          alert("Ajax Fail");
        });
      }
  };
  
  //그리드 표시 항목 생성
  var wgridPic = {
      
      genGridPicker: function( div, g, resrceCd, gridIdx) {
        // 표시 항목 생성
        var columnPicker = new wijmo.input.ListBox(div, {
          itemsSource: g.columns,
          checkedMemberPath: 'visible',
          displayMemberPath: 'header',
          lostFocus : function(s, e) {
            wgrid.setGridItem(resrceCd, gridIdx, g.columnLayout);
            wijmo.hidePopup(s.hostElement);
          }
        });
        
        genGridPickerView(columnPicker, g);
        
        // 표시 항목 그리드에 적용
        function genGridPickerView(columnPicker, g) {
          
          var tlClass = "fa fa-bars";
          var ref = g.hostElement.querySelector('.wj-topleft');
          
          ref.addEventListener('mousedown', function (e) {
            if (wijmo.hasClass(e.target, tlClass)) {
              wijmo.showPopup(columnPicker.hostElement, ref, false, true, false);
              columnPicker.focus();
              e.preventDefault();
            }
          });
        }
        
        return columnPicker;
      }
  };
  
  
  // 공통 콤보박스
  var wcombo = {
      // combo : 콤보박스 ID '#combo' data : json 형태 데이터 f : 콤보박스 선택 이벤트
      genCommonBox: function( div, data, f) {
        return new wijmo.input.ComboBox(div, {
          displayMemberPath : "name",
          selectedValuePath : "value",
          itemsSource : data,
          selectedIndexChanged : function(s, e) {
            f(s, e);
          }
        });
      },
      genCommonBox: function( div, data ) {
        return new wijmo.input.ComboBox(div, {
          displayMemberPath : "name",
          selectedValuePath : "value",
          itemsSource : data
        });
      }
  };
  
  // 엑셀 다운로드
  var wexcel = {
      down: function( grid, sheet, excel ) {
     // create book with current view
        var book = wijmo.grid.xlsx.FlexGridXlsxConverter.save(grid, {
          includeColumnHeaders : true,
          includeRowHeaders : true,
          includeColumns : function(column) {
//            console.log(column.binding + " : " + column.visible);
            return true;
          }
        });
        book.sheets[0].name = sheet;
        // save the book
        book.save(excel);
      }
  };
  
  win.wgrid = wgrid;
  win.wcombo = wcombo;
  win.wgridPic = wgridPic;
  win.wexcel = wexcel;
}( "undefined" != typeof window ? window : this, jQuery );













