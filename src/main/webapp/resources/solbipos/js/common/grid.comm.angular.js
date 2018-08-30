"use strict";
function RootController($scope, $http, isPicker) {
  // 그리드 초기화
  $scope._gridDataInit = function() {
    $scope.data = new wijmo.collections.CollectionView([]);
  };
  // 조회 : 마스터 그리드
  $scope._inquiryMain = function (url, params, callback) {
    $scope._inquiry(url, params, callback, true, true);
  };
  // 조회 : 서브 그리드
  $scope._inquirySub = function (url, params, callback, isView) {
    if (!isView) {
      isView = true;
    }
    $scope._inquiry(url, params, callback, isView, false);
  };
  // 그리드 조회
  $scope._inquiry = function (url, params, callback, isView, isMaster) {
    if (isMaster) {
      var el = angular.element('input');
      var name = '';
      for (var i = 0, l = el.length; i < l; i += 1) {
        name = angular.element(el[i]).attr('ng-model');
        if (name && $scope[name]) {
          params[name] = $scope[name];
        }
      }
    }
    // ajax 통신 설정
    $http({
      method: 'POST', //방식
      url: url, /* 통신할 URL */
      params : params, /* 파라메터로 보낼 데이터 */
      headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
    }).then(function successCallback(response) {
      // this callback will be called asynchronously
      // when the response is available
      var list = response.data.data.list;
      if (list.length === undefined || list.length === 0) {
        $scope.data = new wijmo.collections.CollectionView([]);
        if(isView) {
          $scope.s_alert(response.data.message);
        }
        return;
      }
      var data = new wijmo.collections.CollectionView(list);
      data.trackChanges = true;
      $scope.data = data;
    }, function errorCallback(response) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
      $scope.s_alert(messages["cmm.error"]);
      // console.log(response);
      return;
    }).then(function() {
      // "complete" code here
      if(typeof callback === 'function') {
        setTimeout(function() {
          callback();
        }, 10);
      }
    });
  };
  // 행 추가
  $scope._addRow = function(params, pos) {
    var flex = $scope.flex;
    if (!flex.collectionView) {
      flex.itemsSource = new wijmo.collections.CollectionView();
    }
    var newRow = flex.collectionView.addNew();
    newRow.status = "I";
    newRow.gChk = true;
    for (var prop in params) {
      newRow[prop] = params[prop];
    }
    flex.collectionView.trackChanges = true;
    flex.collectionView.commitNew();
    // 추가된 Row 선택
    setTimeout(function() {
      flex.scrollIntoView(flex.rows.length - 1, 0);
      flex.select(flex.rows.length - 1, 1);
      flex.focus();
      flex.startEditing(true, flex.rows.length - 1, (pos === null ? 0 : pos), true);
    }, 50);
  };
  // 저장
  $scope._save = function (url, params, callback) {
    // 길이체크
    if (params.length <= 0) {
      s_alert.pop(messages["cmm.not.modify"]);
      return;
    } else {
      params = JSON.stringify(params);
    }
    // ajax 통신 설정
    $http({
      method: 'POST', //방식
      url: url, /* 통신할 URL */
      data: params, /* 파라메터로 보낼 데이터 */
      headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
    }).then(function successCallback(response) {
      // this callback will be called asynchronously
      // when the response is available
      $scope.s_alert(messages["cmm.saveSucc"]);
      $scope.flex.collectionView.clearChanges();
      $scope._refresh();
    }, function errorCallback(response) {
      // called asynchronously if an error occurs
      // or server returns response with an error status.
      $scope.s_alert(messages["cmm.saveFail"]);
      // console.log(response);
      return;
    }).then(function() {
      // "complete" code here
      if ( callback != null ) {
        setTimeout(function() {
          callback;
        }, 10);
      }
    });
  };
  // itemFormatter 기본설정
  $scope._itemFormatter = function (panel, r, c, cell) {
    // 컬럼헤더 merged 의 헤더타이틀 중앙(vertical) 정렬
    if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
      var mRange = $scope.flex.getMergedRange(panel, r, c);
      if (mRange) {
        cell.innerHTML = "<div class='wj-header merged-custom'>" + cell.innerHTML + "</div>";
      }
      // picker 를 위한 설정
    } else if (panel.cellType === wijmo.grid.CellType.TopLeft) {
      if(!isPicker) {
        $(cell).css({"background": "none", "background-color": "#e8e8e8"});
      }
      // 로우헤더 의 RowNum 표시 ( 페이징/비페이징 구분 )
    } else if (panel.cellType === wijmo.grid.CellType.RowHeader) {
      // GroupRow 인 경우에는 표시하지 않는다.
      if (panel.rows[r] instanceof wijmo.grid.GroupRow) {
        cell.textContent = "";
      } else {
        if (!isEmpty(panel._rows[r]._data.rnum)) {
          cell.textContent = (panel._rows[r]._data.rnum).toString();
        } else {
          cell.textContent = (r + 1).toString();
        }
      }
      // readOnly 배경색 표시
    } else if (panel.cellType === wijmo.grid.CellType.Cell) {
      var col = panel.columns[c];
      if (col.isReadOnly) {
        wijmo.addClass(cell, 'wj-custom-readonly');
      }
    }
  };
  // 에디팅 관련 기본설정
  $scope.$watch('flex', function() {
    var flex = $scope.flex;
    if (flex) {
      flex.beginningEdit.addHandler(function(s, e) {
        if (s.columns[e.col].binding !== 'gChk') {
          if (!s.rows[e.row].dataItem.gChk) {
            e.cancel = true;
          } else {
            if (s.columns[e.col].dataType !== wijmo.DataType.Boolean) {
              setTimeout(function () {
                var _cellData = s.getCellData(e.row, e.col, true);
                if (s.activeEditor !== null && s.activeEditor.value !== "") {
                  wijmo.setSelectionRange(s.activeEditor, _cellData.length); // caret position
                }
              }, 0);
            }
          }
        }
      });
      flex.cellEditEnded.addHandler(function(s, e) {
        // console.log('Cell Edit End');
      });
      flex.rowEditEnded.addHandler(function(s, e) {
        // console.log('Row edit end');
      });
    }
  });
  // columnPicker 생성
  $scope._makePickColumns = function (ctrlName) {
    var flex = $scope.flex;
    if(flex && isPicker) {
      flex.hostElement.addEventListener('mousedown', function(e) {
        var ht = flex.hitTest(e);
        if( ht.cellType === wijmo.grid.CellType.TopLeft) {
          // create column picker (once)
          if (!$scope.picker) {
            $scope.picker = new wijmo.grid.ColumnPicker('#'+ctrlName);
            $scope.picker.orgColumns = $scope.flex.columns;
          }
          // show column picker in a dialog
          $scope.picker.grid = $scope.flex;
          var pickerPopup = $scope.colPicker;
          pickerPopup.show(true, function (s) {
            var dr = s.dialogResult;
            if (dr && dr.indexOf('apply') > -1) {
              $scope.picker.save();
            }
          });
          e.preventDefault();
        }
      });
    }
  };
};

!function (win, $) {
  var app = angular.module('rootApp', ['wj']);
  // main-controller
  app.controller('rootCtrl', ['$scope', '$http', function ($scope, $http) {
    // 조회
    $scope._broadcast = function(controllerName, params) {
      $scope.$broadcast('init');
      $scope.$broadcast(controllerName, params);
    };
    // 로딩 메시지 팝업 열기
    $scope.$on('loadingPopupActive', function() {
      $scope._loadTent.show(true);
    });
    // 로딩 메시지 팝업 닫기
    $scope.$on('loadingPopupInactive', function() {
      $scope._loadTent.hide();
    });
    // 메시지 팝업
    $scope.s_alert = function(msg, callback) {
      $scope.s_alert_msg = msg;
      setTimeout(function() {
        $scope._alertTent.show(true, function() {
          if (typeof callback === 'function') {
            setTimeout(function() {
              callback();
            }, 10);
          }
        });
      }, 100);
    }
  }]);
  app.factory('myHttpInterceptor', function ($timeout, $q, $rootScope) {
    return {
      'request': function (config) {
        $rootScope.$broadcast('loadingPopupActive');
        return config;
      },
      'requestError': function (rejectionRequest) {
        console.log("from REQUEST ERROR")
        $rootScope.$broadcast('loadingPopupInactive');
        return $q.reject("Couldnot have a successfull request, Sorry :(");
      },
      'response': function (response) {
        $rootScope.$broadcast('loadingPopupInactive');
        return response;
      },
      'responseError': function (rejectionRequest) {
        console.log("from RESPONSE ERROR")
        $rootScope.$broadcast('loadingPopupInactive');
        return $q.reject(rejectionRequest)
      }
    }
  });
  app.config(function ($httpProvider) {
    $httpProvider.interceptors.push('myHttpInterceptor');
  });
  // angular Grid 생성
  var agrid = {
    getApp: function() {
      return app;
    },
    getScope: function (ctrlName) {
      var sel = 'div[ng-controller="' + ctrlName + '"]';
      return angular.element(sel).scope();
    }
  };

  win.agrid = agrid;

}("undefined" != typeof window ? window : this, jQuery);















