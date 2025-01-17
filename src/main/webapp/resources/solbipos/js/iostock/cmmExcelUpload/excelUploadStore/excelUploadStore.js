/****************************************************************
 *
 * 파일명 : excelUploadStore.js
 * 설  명 : 공통팝업 실사/조정/폐기 엑셀업로드 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2022.07.04     권지현      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

/**
 *  엑셀업로드 그리드 생성
 */
app.controller('excelUploadStoreCtrl', ['$scope', '$http','$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('excelUploadStoreCtrl', $scope, $http, true));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        $scope.gridVisibleDefault();

        // 컬럼헤더:바인딩명 형태의 JSON 데이터 생성.
        $scope.colHeaderBind = {};
        for (var i = 0; i < $scope.flex.columns.length; i++) {
            var col                          = $scope.flex.columns[i];
            $scope.colHeaderBind[col.header] = col.binding;
        }
    };

    $scope.itemFormatter = function (panel, r, c, cell) {
        // 컬럼헤더 merged 의 헤더타이틀 중앙(vertical) 정렬
        if (panel.cellType === wijmo.grid.CellType.ColumnHeader) {
            var mRange = $scope.flex.getMergedRange(panel, r, c);
            if (mRange) {
                cell.innerHTML = '<div class=\"wj-header merged-custom\">' + cell.innerHTML + '</div>';
            }
        }

        var flex   = panel.grid;
        var column = flex.columns[c];

        if (column) {
            if (column.binding === 'gChk' || column.format === 'checkBox' || column.format === 'checkBoxText') {
                // create and initialize checkbox
                if (column.format === 'checkBoxText') {
                    cell.innerHTML = '<input id=\"' + column.binding + '\" type=\"checkbox\" class=\"wj-cell-check\" />'
                        + '<label for=\"' + column.binding + '\" class=\"wj-header-label\">' + cell.innerHTML + '</label>';
                } else {
                    cell.innerHTML = '<input type=\"checkbox\" class=\"wj-cell-check\" />';
                }
            }
        }
    };

    // 그리드 컬럼 visible 초기화
    $scope.gridVisibleDefault = function () {
        $scope.prodBarcdCdVisibleFg = true; // 상품코드/바코드
        $scope.prodCdVisibleFg      = true; // 상품코드
        $scope.uprcVisibleFg        = true; // 단가
        $scope.unitQtyVisibleFg     = true; // 단위수량
        $scope.etcQtyVisibleFg      = true; // 낱개수량
        $scope.barcdCdVisibleFg     = true; // 바코드
        $scope.qtyVisibleFg         = true; // 수량
        $scope.remarkVisibleFg      = true; // 비고
    };

    // 엑셀양식 다운로드
    $scope.excelFormDownload = function (uploadFg) {

        var name = "";

        $scope.uploadFg = uploadFg;

        $scope.addRow();


        if(uploadFg === "acins") {
            name = '실사양식_';
        } else if(uploadFg === "adj") {
            name = '조정양식_';
        } else if(uploadFg === "disuse") {
            name = '폐기양식_';
        }

        $timeout(function () {
            wijmo.grid.xlsx.FlexGridXlsxConverter.saveAsync($scope.flex, {
                includeColumnHeaders: true,
                includeCellStyles   : true,
                includeColumns      : function (column) {
                    return column.visible;
                }
            }, name + getCurDateTime() + '.xlsx'
            );
        }, 10);
    };

    // 엑셀 양식 다운로드시 1줄 생성하여 어떤값 넣어야할지 양식생성.
    $scope.addRow = function () {
        // 그리드 초기화
        var flex                         = $scope.flex;
        flex.itemsSource                 = new wijmo.collections.CollectionView();
        flex.collectionView.trackChanges = true;

        var params = {};
        // 실사/조정/폐기
        if ($scope.uploadFg === 'acins' || $scope.uploadFg === 'adj' || $scope.uploadFg === 'disuse') {
            $scope.prodBarcdCdVisibleFg = true;  // 상품코드/바코드
            $scope.prodCdVisibleFg      = false; // 상품코드
            $scope.uprcVisibleFg        = false; // 단가
            $scope.poUnitQtyVisibleFg   = false; // 바코드
            $scope.unitQtyVisibleFg     = false; // 단위수량
            $scope.etcQtyVisibleFg      = false; // 낱개수량
            $scope.qtyVisibleFg         = true;  // 수량
            $scope.remarkVisibleFg      = true;  // 비고

            params.prodBarcdCd = '00000001';
            params.qty         = 0;
        }

        var newRow = flex.collectionView.addNew();
        for (var prop in params) {
            newRow[prop] = params[prop];
        }
        flex.collectionView.commitNew();
    };

    // 엑셀파일이 변경된 경우
    $scope.excelFileChanged = function () {
        if ($('#excelUpFile')[0].files[0]) {
            // 엑셀업로드 전 현재 세션ID 와 동일한 자료를 삭제한다.
            $scope.deleteExl('excel');
        }
    };

    // 텍스트파일이 변경된 경우
    $scope.textFileChanged = function () {
        if ($('#textUpFile')[0].files[0]) {
            // 업로드 전 현재 세션ID 와 동일한 자료를 삭제한다.
            $scope.deleteExl('text');
        }
    };

    // 현재 세션ID 와 동일한 데이터 삭제
    $scope.deleteExl = function (upFg) {
        var params = {};
        //가상로그인 session 설정
        if(document.getElementsByName('sessionId')[0]){
            params['sid'] = document.getElementsByName('sessionId')[0].value;
        }

        $http({
            method : 'POST', //방식
            url    : "/iostock/cmmExcelUpload/excelUploadStore/excelUploadStore/delete.sb", /* 통신할 URL */
            params : params, /* 파라메터로 보낼 데이터 */
            headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
        }).then(function successCallback(response) {
            if ($scope._httpStatusCheck(response, true)) {
            }
        }, function errorCallback(response) {
            // called asynchronously if an error occurs
            // or server returns response with an error status.
            $scope._popMsg(response.data.message);
            return false;
        }).then(function () {
            // 'complete' code here
            if (upFg === 'excel') {
                $scope.excelUpload(); // 삭제 완료 된 후 엑셀업로드 호출
            } else if (upFg === 'text') {
                $scope.textUpload(); // 삭제 완료 된 후 텍스트업로드 호출
            }
        });
    };

    // 텍스트 업로드
    $scope.textUpload = function () {
        $scope.excelTextFg = 'text';
        // 업로드 progress 관련 기본값 세팅
        $scope.stepCnt     = 100; // 한번에 DB에 저장할 숫자 세팅
        $scope.progressCnt = 0;   // 처리된 숫자

        // 선택한 파일이 있을 경우
        if ($('#textUpFile')[0].files[0]) {
            var file          = $('#textUpFile')[0].files[0];
            var fileName      = file.name;
            var fileExtension = fileName.substring(fileName.lastIndexOf('.'));

            // 확장자 체크. 확장자가 txt가 아닌 경우 오류메시지
            if (fileExtension.toLowerCase() !== '.txt') {
                $("#textUpFile").val('');
                $scope._popMsg(messages['excelUploadMPS.not.textFile']); // 텍스트 파일만 업로드 됩니다.(*.txt)
                return false;
            }

            var fr = new FileReader();

            fr.onloadend = function (e) {
                // var data = e.target.result;
                $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈
                $timeout(function () {
                    var uploadData = '';
                    var bytes      = new Uint8Array(e.target.result);
                    var length     = bytes.byteLength;
                    for (var i = 0; i < length; i++) {
                        // 값이 스페이스인 경우 건너뜀.
                        if (bytes[i] === 32) {
                            continue;
                        }

                        // 마지막 데이터인 경우
                        if (i === (length - 1)) {
                            // 마지막 데이터가 엔터가 아닌 경우 json 형식 데이터 만들때 split 해서 쓰기 위해 enter 값을 마지막에 추가해준다.
                            if (bytes[i] !== 13) {
                                uploadData += String.fromCharCode(bytes[i]);
                                uploadData += String.fromCharCode(13);
                                // uploadData += '\n';
                            }
                        } else {
                            uploadData += String.fromCharCode(bytes[i]);
                        }
                    }
                    /*
                    console.log('### uploadData: \n' + uploadData);
                    console.log('### uploadData: \n' + JSON.stringify($scope.textUploadToJsonConvert(uploadData)) );
                    return;
                    */
                    // 읽어온 파일데이터가 null 이 아닌 경우
                    if (nvl(uploadData, '') !== '') {
                        var jsonData = $scope.textUploadToJsonConvert(uploadData);

                        if (jsonData.length > 0) {
                            $timeout(function () {
                                $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                                $scope.save(jsonData);
                            }, 10);
                        } else {
                            $scope._popMsg(messages['excelUploadMPS.noData'], function () {
                                $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                            }); // 업로드 할 데이터가 없습니다.
                        }
                    } else {
                        $scope._popMsg(messages['excelUploadMPS.noData'], function () {
                            $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
                        }); // 업로드 할 데이터가 없습니다.
                    }
                }, 10);
            };

            // r.readAsBinaryString(file);
            fr.readAsArrayBuffer(file);
        }
    };

    // 텍스트 업로드 한 데이터를 JSON 형태로 변경한다.
    $scope.textUploadToJsonConvert = function (uploadData) {
        var uploadDataArr       = uploadData.split(String.fromCharCode(13));
        // var uploadDataArr       = uploadData.split('\n');
        var uploadDataArrLength = uploadDataArr.length;
        var jsonData            = [];
        var item                = {};
        //var columnNum           = 2; // 텍스트 업로드시 1줄의 JSON 데이터 컬럼 수 설정
        var columnNum           = 3; // 텍스트 업로드시 1줄의 JSON 데이터 컬럼 수 설정

        for (var i = 0; i < uploadDataArrLength; i++) {
            // String.fromCharCode(13) 으로 replace 를 하면 제대로 되지 않음..그래서 \n으로 replace 함..
            if (nvl(uploadDataArr[i].replace(/\n/gi, ''), '') !== '') {
                // if (nvl(uploadDataArr[i].replace(/String.fromCharCode(13)/gi, ''), '') !== '') {
                // var data          = uploadDataArr[i].replace(/String.fromCharCode(13)/gi, '');
                var data          = uploadDataArr[i].replace(/\n/gi, '').trim();
                var dataArr       = data.split(',');
                var dataArrLength = dataArr.length;
                item              = {};

                // 1줄의 데이터를 , 로 split 한 자료의 길이가 columnNum 보다 작은 경우 수량 없음 오류 메시지
                if (dataArrLength < columnNum) {
                    $scope._popMsg(messages['excelUploadMPS.not.qty']); // 업로드 데이터 중 수량이 없는 데이터가 존재합니다.
                    jsonData = [];
                    break;
                }

                for (var j = 0; j < dataArrLength; j++) {
                    var value = nvl(dataArr[j], '').trim();
                    if (value !== '') {
                        //1줄의 데이터가 columnNum 보다 많은 경우 양식이 이상한 것이므로 for문 종료
                        if (j >= columnNum) break;
                        /*
                        if (j % columnNum === 0) {
                          item.prodBarcdCd = value;
                        } else if (j % columnNum === 1) {
                          item.qty = value;
                        }
                        */
                        if		(j % columnNum === 0)	item.prodBarcdCd 	= value;
                        else if 	(j % columnNum === 1)	item.unitQty 		= value;
                        else if 	(j % columnNum === 2)	item.etcQty 		= value;
                    }
                }
                console.log(teml);
                jsonData.push(item);
            }
        }
        return jsonData;
    };

    // 엑셀 업로드
    $scope.excelUpload = function () {
        $scope.excelTextFg = 'excel';
        // 업로드 progress 관련 기본값 세팅
        $scope.stepCnt     = 5000; // 한번에 DB에 저장할 숫자 세팅
        $scope.progressCnt = 0;   // 처리된 숫자

        // 선택한 파일이 있으면
        if ($('#excelUpFile')[0].files[0]) {
            var file          = $('#excelUpFile')[0].files[0];
            var fileName      = file.name;
            var fileExtension = fileName.substring(fileName.lastIndexOf('.'));

            // 확장자가 xlsx, xlsm 인 경우에만 업로드 실행
            if (fileExtension.toLowerCase() === '.xlsx' || fileExtension.toLowerCase() === '.xlsm') {
                $scope.$broadcast('loadingPopupActive', messages["cmm.progress"]); // 데이터 처리중 메시지 팝업 오픈

                $timeout(function () {
                    var flex = $scope.flex;
                    wijmo.grid.xlsx.FlexGridXlsxConverter.loadAsync(flex, $('#excelUpFile')[0].files[0], {includeColumnHeaders: true}
                        , function (workbook) {
                            $timeout(function () {
                                $scope.excelUploadToJsonConvert();
                            }, 10);
                        }
                    );
                }, 10);
            } else {
                $("#excelUpFile").val('');
                $scope._popMsg(messages['excelUploadMPS.not.excelFile']); // 엑셀 파일만 업로드 됩니다.(*.xlsx, *.xlsm)
                return false;
            }
        }
    };

    // 엑셀업로드 한 데이터를 JSON 형태로 변경한다.
    $scope.excelUploadToJsonConvert = function () {
        var jsonData  = [];
        var item      = {};
        var rowLength = $scope.flex.rows.length;

        if (rowLength === 0) {
            $scope._popMsg(messages['excelUploadMPS.not.excelUploadData']); // 엑셀업로드 된 데이터가 없습니다.
            return false;
        }

        // 업로드 된 데이터 JSON 형태로 생성
        for (var r = 0; r < rowLength; r++) {
            item = {};
            for (var c = 0; c < $scope.flex.columns.length; c++) {
                if ($scope.flex.columns[c].header !== null && $scope.flex.getCellData(r, c, false) !== null) {
                    var colBinding = $scope.colHeaderBind[$scope.flex.columns[c].header];
                    var cellValue  = $scope.flex.getCellData(r, c, false) + '';

                    item[colBinding] = cellValue;
                }
            }

            // item.uploadFg = $scope.uploadFg;
            jsonData.push(item);
        }
        /*
        console.log('### excelUploadToJsonConvert: \n' + JSON.stringify(jsonData) );
        return;
        */
        $scope.$broadcast('loadingPopupInactive'); // 데이터 처리중 메시지 팝업 닫기
        $timeout(function () {
            $scope.save(jsonData);
        }, 10);
    };

    // DB에 저장
    $scope.save = function (jsonData) {
        $scope.totalRows = jsonData.length;
        var params       = [];
        var msg          = '';

        console.log("totalRows : " + $scope.totalRows);

        // 업로드 5000개 제한
        if($scope.totalRows > $scope.stepCnt){
            msg = "업로드 데이터 갯수는 5000개까지만 입력 가능합니다. 데이터 및 양식을 확인해주세요.";
            $scope.valueCheckErrPopup(msg);
            return false;
        }

        // 저장 시작이면 업로드 중 팝업 오픈
        if ($scope.progressCnt === 0) {
            $timeout(function () {
                $scope.excelUploadingPopup(true);
                $("#progressCnt").html($scope.progressCnt);
                $("#totalRows").html($scope.totalRows);
            }, 10);
        }

        // stepCnt 만큼 데이터 DB에 저장
        var loopCnt = (parseInt($scope.progressCnt) + parseInt($scope.stepCnt) > parseInt($scope.totalRows) ? parseInt($scope.totalRows) : parseInt($scope.progressCnt) + parseInt($scope.stepCnt));
        for (var i = $scope.progressCnt; i < loopCnt; i++) {
            var item = jsonData[i];

            // 필수값 및 길이 체크
            // 상품코드/바코드
            if (nvl(item.prodBarcdCd, '') === '') {
                msg = messages["excelUploadMPS.prodBarcdCd"] + messages["excelUploadMPS.require.data"]; // 상품코드/바코드(이)가 없는 데이터가 존재합니다.
                $scope.valueCheckErrPopup(msg);
                return false;
            }

            // 엑셀업로드시 업로드구분에 따른 필수값 체크
            //if ($scope.excelTextFg === 'excel') {
            if ($scope.excelTextFg === 'excel'  ||  $scope.excelTextFg === 'text') {	//'Text'인 경우도 추가
                if ($scope.uploadFg === 'acins' || $scope.uploadFg === 'adj' || $scope.uploadFg === 'disuse') {
                    // 수량
                    if (nvl(item.qty, '') === '') {
                        msg = messages["excelUploadMPS.qty"] + messages["excelUploadMPS.require.data"]; // 수량(이)가 없는 데이터가 존재합니다.
                        $scope.valueCheckErrPopup(msg);
                        return false;
                    }
                }
            }

            // 상품코드/바코드 최대길이 체크
            if (nvl(item.prodBarcdCd, '') !== '' && nvl(item.prodBarcdCd + '', '').getByteLengthForOracle() > 50) {
                msg = messages["excelUploadMPS.prodBarcdCd"] + messages["excelUploadMPS.overLength"] + " 50 " + messages["excelUploadMPS.bateLengthInfo"]; // 상품코드/바코드의 데이터 중 문자열의 길이가 너무 긴 데이터가 있습니다. 최대 : 50
                $scope.valueCheckErrPopup(msg);
                return false;
            }

            // 단위수량 값 체크
            if (nvl(item.unitQty, '') !== '') {
                // 최대크기
                if (parseInt(nvl(item.unitQty, 0)) > 99999999) {
                    msg = messages["excelUploadMPS.unitQty"] + messages["excelUploadMPS.overSize"] + " 99999999"; // 단위수량의 데이터 중 크기가 너무 큰 데이터가 있습니다. 최대 : 99999999
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
                // 숫자가 아닌 값
                var numChkexp = /[^0-9]/g;
                if (numChkexp.test(nvl(item.unitQty, 0))) {
                    msg = messages["excelUploadMPS.unitQty"] + messages["excelUploadMPS.not.numberData"]; // 단위수량의 값에 숫자가 아닌 값이 존재합니다. 데이터 및 양식을 확인해주세요.
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
            }

            // 낱개수량 값 체크
            if (nvl(item.etcQty, '') !== '') {
                // 최대크기
                if(parseInt(nvl(item.etcQty, 0)) > 99999999) {
                    msg = messages["excelUploadMPS.etcQty"] + messages["excelUploadMPS.overSize"] + " 99999999"; // 낱개수량의 데이터 중 크기가 너무 큰 데이터가 있습니다. 최대 : 99999999
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
                // 숫자가 아닌 값
                var numChkexp = /[^0-9]/g;
                if (numChkexp.test(nvl(item.etcQty, 0))) {
                    msg = messages["excelUploadMPS.etcQty"] + messages["excelUploadMPS.not.numberData"]; // 낱개수량의 값에 숫자가 아닌 값이 존재합니다. 데이터 및 양식을 확인해주세요.
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
            }

            // 수량 값 체크
            if (nvl(item.qty, '') !== '') {
                // 최대크기
                if(parseInt(nvl(item.qty, 0)) > 99999999) {
                    msg = messages["excelUploadMPS.qty"] + messages["excelUploadMPS.overSize"] + " 99999999"; // 수량의 데이터 중 크기가 너무 큰 데이터가 있습니다. 최대 : 99999999
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
                // 숫자가 아닌 값
                var numChkexp = /[^0-9]/g;
                if (numChkexp.test(nvl(item.qty, 0))) {
                    msg = messages["excelUploadMPS.qty"] + messages["excelUploadMPS.not.numberData"]; // 수량의 값에 숫자가 아닌 값이 존재합니다. 데이터 및 양식을 확인해주세요.
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
            }

            // 단가 값 체크
            if (nvl(item.uprc, '') !== '') {
                // 최대크기
                if(parseInt(nvl(item.uprc, 0)) > 9999999999) {
                    msg = messages["excelUploadMPS.uprc"] + messages["excelUploadMPS.overSize"] + " 9999999999"; // 단가의 데이터 중 크기가 너무 큰 데이터가 있습니다. 최대 : 9999999999
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
                // 숫자가 아닌 값
                var numChkexp = /[^0-9]/g;
                if (numChkexp.test(nvl(item.uprc, 0))) {
                    msg = messages["excelUploadMPS.uprc"] + messages["excelUploadMPS.not.numberData"]; // 단가의 값에 숫자가 아닌 값이 존재합니다. 데이터 및 양식을 확인해주세요.
                    $scope.valueCheckErrPopup(msg);
                    return false;
                }
            }

            // 비고 최대길이 체크
            if (nvl(item.remark, '') !== '' && nvl(item.remark + '', '').getByteLengthForOracle() > 500) {
                msg = messages["excelUploadMPS.remark"] + messages["excelUploadMPS.overLength"] + " 500 " + messages["excelUploadMPS.bateLengthInfo"]; // 비고의 데이터 중 문자열의 길이가 너무 긴 데이터가 있습니다. 최대 : 1000
                $scope.valueCheckErrPopup(msg);
                return false;
            }

            item.uploadFg = $scope.uploadFg;
            // 매장코드를 직접 파라미터로 넘겨주는 경우에만 storeCd를 받아서 temp 테이블에 넣음.
            if (nvl($scope.storeCd, '') !== '') {
                item.storeCd = $scope.storeCd;
            }

            params.push(item);
        }

        //가상로그인 session 설정
        var sParam = {};
        if(document.getElementsByName('sessionId')[0]){
            sParam['sid'] = document.getElementsByName('sessionId')[0].value;
        }
            console.log(params);

        // ajax 통신 설정
        $http({
            method : 'POST', //방식
            url    : '/iostock/cmmExcelUpload/excelUploadStore/excelUploadStore/save.sb', /* 통신할 URL */
            data   : params, /* 파라메터로 보낼 데이터 : @requestBody */
            params : sParam,
            headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
        }).then(function successCallback(response) {
            if ($scope._httpStatusCheck(response, true)) {
            }
        }, function errorCallback(response) {
            $scope.excelUploadingPopup(false); // 업로딩 팝업 닫기
            if (response.data.message) {
                $scope._popMsg(response.data.message);
            } else {
                $scope._popMsg(messages['cmm.saveFail']);
            }
            return false;
        }).then(function () {
            // 'complete' code here
            // 처리 된 숫자가 총 업로드할 수보다 작은 경우 다시 save 함수 호출
            if (parseInt($scope.progressCnt) < parseInt($scope.totalRows)) {
                // 처리된 숫자 변경
                $scope.progressCnt = loopCnt;
                // 팝업의 progressCnt 값 변경
                $("#progressCnt").html($scope.progressCnt);
                $scope.save(jsonData);
            } else {
                $scope.saveUpdateProdCd();
            }
        });
    };

    // 엑셀업로드 된 데이터를 기반으로 상품코드 업데이트
    // 업데이트 완료 후 callback 호출 함.
    $scope.saveUpdateProdCd = function () {
        var params      = {};
        params.uploadFg = $scope.uploadFg;

        //가상로그인 session 설정
        if(document.getElementsByName('sessionId')[0]){
            params['sid'] = document.getElementsByName('sessionId')[0].value;
        }

        // ajax 통신 설정
        $http({
            method : 'POST', //방식
            url    : '/iostock/cmmExcelUpload/excelUploadStore/excelUploadStore/saveUpdateProdCd.sb', /* 통신할 URL */
            params : params, /* 파라메터로 보낼 데이터 */
            headers: {'Content-Type': 'application/json; charset=utf-8'} //헤더
        }).then(function successCallback(response) {
            if ($scope._httpStatusCheck(response, true)) {
                if (nvl($scope.parentCtrl, '') !== '') {
                    var parentScope = agrid.getScope($scope.parentCtrl);
                    parentScope.uploadCallBack();
                }
            }
        }, function errorCallback(response) {
            $scope.excelUploadingPopup(false); // 업로딩 팝업 닫기
            if (response.data.message) {
                $scope._popMsg(response.data.message);
            } else {
                $scope._popMsg(messages['cmm.saveFail']);
            }
            return false;
        }).then(function () {
        });
    };

    // 엑셀업로딩 팝업 열기
    $scope.excelUploadingPopup = function (showFg) {
        if (showFg) {
            // 팝업내용 동적 생성
            var innerHtml = '<div class=\"wj-popup-loading\"><p class=\"bk\">' + messages['excelUploadMPS.excelUploading'] + '</p>';
            innerHtml += '<div class="mt5 txtIn"><span class="bk" id="progressCnt">0</span> / <span class="bk" id="totalRows">0</span></div>';
            innerHtml += '<p><img src=\"/resource/solbipos/css/img/loading.gif\" alt=\"\" /></p></div>';
            // html 적용
            $scope._loadingPopup.content.innerHTML = innerHtml;
            // 팝업 show
            $scope._loadingPopup.show(true);
        } else {
            $scope._loadingPopup.hide(true);
        }
    };

    // 업로드 한 데이터 값체크 중 에러시 에러팝업 띄우기 및 엑셀업로딩 팝업 닫기
    $scope.valueCheckErrPopup = function (msg) {
        $scope._popMsg(msg, function () {
            $scope.excelUploadingPopup(false); // 업로딩 팝업 닫기
        });
    };

}]);