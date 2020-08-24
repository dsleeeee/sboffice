/**
 * get application
 */
var app = agrid.getApp();
app.controller('dlvrManageCtrl', ['$scope', '$http', function ($scope, $http) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('dlvrManageCtrl', $scope, $http, false));

    $scope._getComboDataQuery('067', 'useYn', '');

    $scope.selectedMember;
    $scope.setSelectedMember = function (data) {
        $scope.selectedMember = data;
    };
    $scope.getSelectedMember = function () {
        return $scope.selectedMember;
    };

    $scope.initGrid = function (s, e) {
        $scope.useYnDataMap = new wijmo.grid.DataMap(useYn, 'value', 'name');
        $scope.$apply(function () {
            $scope.data = new wijmo.collections.CollectionView(dlvrFirstList);
        });

        s.addEventListener(s.hostElement, 'mousedown', function (e) {
            var ht = s.hitTest(e);
            if (ht.cellType === wijmo.grid.CellType.Cell) {
                var col = ht.panel.columns[ht.col];
                if (col.binding === "dlvrLzoneCd") {
                    var selectedData = s.rows[ht.row].dataItem
                    $scope.setSelectedMember(selectedData);
                    var detailScope = agrid.getScope('dlvrManageDetailCtrl');
                    detailScope._broadcast('dlvrManageDetailList', $scope.getSelectedMember());
                    event.preventDefault();
                }
            }
        });

        s.formatItem.addHandler(function (s, e) {
            if (e.panel === s.cells) {
                var col = s.columns[e.col];
                if (col.binding === "dlvrLzoneCd") {
                    wijmo.addClass(e.cell, 'wijLink');
                }
            }
        });
    };

    // row 추가
    $scope.dlvrAreaAdd = function () {
        // 파라미터 설정

        var params = {};
        params.dlvrLzoneCd = '자동채번';
        params.dlvrLzoneNm = '';
        params.pageNo = $scope.flex.collectionView.items.length + 1;
        params.useYn = 'Y';
        params.inFg = 'W';
        // 추가 row
        $scope._addRow(params);
    };
    // 삭제
    $scope.dlvrAreaDel = function () {
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            var item = $scope.flex.collectionView.items[i];
            if (item.gChk) {
                $scope.flex.collectionView.removeAt(i);
            }
        }
    };

    // Up
    $scope.dlvrAreaUp = function () {
        var movedRows = 0;
        for (var i = 0; i < $scope.flex.collectionView.itemCount; i++) {
            var item = $scope.flex.collectionView.items[i];
            if (i > 0 && item.gChk) {
                if (!$scope.flex.collectionView.items[i - 1].gChk) {
                    movedRows = i - 1;
                    var tmpItem = $scope.flex.collectionView.items[movedRows];
                    $scope.flex.collectionView.items[movedRows] = $scope.flex.collectionView.items[i];
                    $scope.flex.collectionView.items[i] = tmpItem;
                    $scope.flex.collectionView.commitEdit();
                    $scope.flex.collectionView.refresh();
                    $scope.flex.collectionView.items[i].pageNo = String(i);
                }
            }
        }
        $scope.flex.select(movedRows, 1);
    };

    // Dn
    $scope.dlvrAreaDn = function () {
        var movedRows = 0;
        for (var i = $scope.flex.itemsSource.itemCount - 1; i >= 0; i--) {
            var item = $scope.flex.collectionView.items[i];
            if ((i < $scope.flex.itemsSource.itemCount - 1) && item.gChk) {
                if (!$scope.flex.collectionView.items[i + 1].gChk) {
                    movedRows = i + 1;
                    var tmpItem = $scope.flex.collectionView.items[movedRows];
                    $scope.flex.collectionView.items[movedRows] = $scope.flex.collectionView.items[i];
                    $scope.flex.collectionView.items[i] = tmpItem;
                    $scope.flex.collectionView.commitEdit();
                    $scope.flex.collectionView.refresh();
                    $scope.flex.collectionView.items[i].pageNo = String(i);
                }
            }
        }
        $scope.flex.select(movedRows, 1);
    };
    /*********************************************************
     * 저장
     * *******************************************************/
    $scope.dlvrAreaSave = function () {
        // 파라미터 설정
        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
            $scope.flex.collectionView.itemsEdited[i].status = "U";
            params.push($scope.flex.collectionView.itemsEdited[i]);
        }
        for (var i = 0; i < $scope.flex.collectionView.itemsAdded.length; i++) {
            var item = $scope.flex.collectionView.itemsAdded[i];
            if (item.dlvrMzoneNm === "" || item.dlvrMzoneNm === null) {
                $scope._popMsg(messages["dlvrManage.areaNm"] + messages["cmm.require.text"]);
                return false;
            }
            $scope.flex.collectionView.itemsAdded[i].status = "I";
            params.push($scope.flex.collectionView.itemsAdded[i]);
        }
        for (var i = 0; i < $scope.flex.collectionView.itemsRemoved.length; i++) {
            $scope.flex.collectionView.itemsRemoved[i].status = "D";
            params.push($scope.flex.collectionView.itemsRemoved[i]);
        }
        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $.postJSONArray("/dlvr/manage/info/dlvrZone/regist.sb", params, function (result) {
            $scope.data = new wijmo.collections.CollectionView(dlvrFirstList);
        }, function (err) {
            s_alert.pop(err.message);
        });
    };
}])
;

app.controller('dlvrManageDetailCtrl', ['$scope', '$http', function ($scope, $http) {
    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('dlvrManageDetailCtrl', $scope, $http, true));

    $scope._getComboDataQuery('067', 'useYn', '');

    $scope.selectedMember;
    $scope.setSelectedMember = function (data) {
        $scope.selectedMember = data;
    };
    $scope.getSelectedMember = function () {
        return $scope.selectedMember;
    };
    // $scope.data = new wijmo.collections.CollectionView([]);

    $scope.initGrid = function (s, e) {
        $scope.useYnDataMap = new wijmo.grid.DataMap(useYn, 'value', 'name');
    };
    $scope.$on("dlvrManageDetailList", function (event, data) {
        $scope.setSelectedMember(data);
        $scope.getDlvrManageDetailList();
        event.preventDefault();
    });

    // 상세 조회
    $scope.getDlvrManageDetailList = function () {
        var params = {};
        params.storeCd = $scope.getSelectedMember().storeCd;
        params.dlvrLzoneCd = $scope.getSelectedMember().dlvrLzoneCd;
        $scope.$broadcast('loadingPopupActive');
        // ajax 통신 설정
        $http({
            method: 'POST', //방식
            url: '/dlvr/manage/info/dlvrZone/dlvrDetail.sb', /* 통신할 URL */
            params: params, /* 파라메터로 보낼 데이터 */
            headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
        }).then(function successCallback(response) {
            // 로딩바 hide
            $scope.$broadcast('loadingPopupInactive');
            if (response.data.data.list.length === undefined || response.data.data.list.length === 0) {
                $scope.data = new wijmo.collections.CollectionView([]);
            } else {
                var data = new wijmo.collections.CollectionView(response.data.data.list);
                data.trackChanges = true;
                $scope.data = data;
            }
        }, function errorCallback(response) {
            $scope.$broadcast('loadingPopupInactive');
            if (response.data.message) {
                $scope._popMsg(response.data.message);
            } else {
                $scope._popMsg(messages['cmm.error']);
            }
            return false;
        }).then(function () {
            // 'complete' code here
            if (typeof callback === 'function') {
                setTimeout(function () {
                    callback();
                }, 10);
            }
        });
    };

    // row 추가
    $scope.dlvrDetailAreaAdd = function () {
        // 파라미터 설정
        var params = {};
        params.dlvrMzoneCd = '자동채번';
        params.dlvrMzoneNm = '';
        params.dlvrLzoneCd = $scope.selectedMember.dlvrLzoneCd;
        params.pageNo = $scope.flex.collectionView.items.length + 1;
        params.dlvrAddr = 'test'
        params.useYn = 'Y';
        params.inFg = 'W';
        // 추가 row
        $scope._addRow(params);
    };
    // 삭제
    $scope.dlvrDetailAreaDel = function () {
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            var item = $scope.flex.collectionView.items[i];
            if (item.gChk) {
                $scope.flex.collectionView.removeAt(i);
            }
        }
    };

    // Up
    $scope.dlvrDetailAreaUp = function () {
        var movedRows = 0;
        for (var i = 0; i < $scope.flex.collectionView.itemCount; i++) {
            var item = $scope.flex.collectionView.items[i];
            if (i > 0 && item.gChk) {
                if (!$scope.flex.collectionView.items[i - 1].gChk) {
                    movedRows = i - 1;
                    var tmpItem = $scope.flex.collectionView.items[movedRows];
                    $scope.flex.collectionView.items[movedRows] = $scope.flex.collectionView.items[i];
                    $scope.flex.collectionView.items[i] = tmpItem;
                    $scope.flex.collectionView.commitEdit();
                    $scope.flex.collectionView.refresh();
                    $scope.flex.collectionView.items[i].pageNo = String(i);
                }
            }
        }
        $scope.flex.select(movedRows, 1);
    };

    // Dn
    $scope.dlvrDetailAreaDn = function () {
        var movedRows = 0;
        for (var i = $scope.flex.itemsSource.itemCount - 1; i >= 0; i--) {
            var item = $scope.flex.collectionView.items[i];
            if ((i < $scope.flex.itemsSource.itemCount - 1) && item.gChk) {
                if (!$scope.flex.collectionView.items[i + 1].gChk) {
                    movedRows = i + 1;
                    var tmpItem = $scope.flex.collectionView.items[movedRows];
                    $scope.flex.collectionView.items[movedRows] = $scope.flex.collectionView.items[i];
                    $scope.flex.collectionView.items[i] = tmpItem;
                    $scope.flex.collectionView.commitEdit();
                    $scope.flex.collectionView.refresh();
                    $scope.flex.collectionView.items[i].pageNo = String(i);
                }
            }
        }
        $scope.flex.select(movedRows, 1);
    };
    /*********************************************************
     * 저장
     * *******************************************************/
    $scope.dlvrDetailAreaSave = function () {
        // 파라미터 설정
        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.itemsEdited.length; i++) {
            $scope.flex.collectionView.itemsEdited[i].status = "U";
            params.push($scope.flex.collectionView.itemsEdited[i]);
        }
        for (var i = 0; i < $scope.flex.collectionView.itemsAdded.length; i++) {
            var item = $scope.flex.collectionView.itemsAdded[i];
            if (item.dlvrLzoneNm === "" || item.dlvrLzoneNm === null) {
                $scope._popMsg(messages["dlvrManage.areaNm"] + messages["cmm.require.text"]);
                return false;
            }
            $scope.flex.collectionView.itemsAdded[i].status = "I";
            params.push($scope.flex.collectionView.itemsAdded[i]);
        }
        for (var i = 0; i < $scope.flex.collectionView.itemsRemoved.length; i++) {
            $scope.flex.collectionView.itemsRemoved[i].status = "D";
            params.push($scope.flex.collectionView.itemsRemoved[i]);
        }
        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $.postJSONArray("/dlvr/manage/info/dlvrZone/detailRegist.sb", params, function (result) {
            $scope.data = new wijmo.collections.CollectionView(dlvrFirstList);
        }, function (err) {
            s_alert.pop(err.message);
        });
    };
}]);