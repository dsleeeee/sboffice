/****************************************************************
 *
 * 파일명 : smsSend.js
 * 설  명 : SMS전송 JavaScript
 *
 *    수정일      수정자      Version        Function 명
 * ------------  ---------   -------------  --------------------
 * 2021.06.10     김설아      1.0
 *
 * **************************************************************/
/**
 * get application
 */
var app = agrid.getApp();

// 전송자번호
var telNoComboData = [
    {"name":"선택","value":""}
];

// 메세지관리 목록 내용 삽입
function msgShow(title, message) {
    var scope = agrid.getScope('smsSendCtrl');
    var params = {};
    params.title = title;
    params.message = message;
    scope.msgShow(params);
}

/**
 *  SMS전송 조회 그리드 생성
 */
app.controller('smsSendCtrl', ['$scope', '$http', '$timeout', function ($scope, $http, $timeout) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('smsSendCtrl', $scope, $http, false));

    // 조회조건 콤보박스 데이터 Set
    $scope._setComboData("telNoCombo", telNoComboData); // 전송자번호

    $("#lblStoreNmInfo").text("(광고)" +  "");
    $("#lblMemoInfo").text("(무료수신거부)" +  "080-936-2859");
    $("#lblTxtByte").text("0");
    $("#lblMsgType").text("SMS");
    $("#lblSmsAmt").text("0");

    var gridYn = "N"; // 전송,예약시 그리드가 없는지 체크(추가,조회를 하지않으면 그리드 생성안됨)

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
        // 그리드 링크 효과
        s.formatItem.addHandler(function (s, e) {
            if (e.panel === s.cells) {
                var col = s.columns[e.col];

                // 수신번호
                // if (col.binding === "telNm" || col.binding === "telNo") {
                if (col.binding === "telNo") {
                    var item = s.rows[e.row].dataItem;

                    // 값이 있으면 링크 효과
                    // C:회원조회, X:추가
                    // M:시스템, A:대리점, H:본사, S:매장
                    if (item[("rOgnFg")] !== 'X') {
                        wijmo.addClass(e.cell, 'wj-custom-readonly');
                        wijmo.setAttribute(e.cell, 'aria-readonly', true);

                        // Attribute 의 변경사항을 적용.
                        e.cell.outerHTML = e.cell.outerHTML;
                    }
                }
            }
        });
    };

    // <-- 검색 호출 -->
    $scope.$on("smsSendCtrl", function(event, data) {
        // 페이지 로드시 호출
        $scope.searchSmsSendViewPop(data, "N");
        event.preventDefault();
    });
    $scope.$on("smsSendYCtrl", function(event, data) {
        // 페이지 로드시 호출
        $scope.searchSmsSendViewPop(data, "Y");
        event.preventDefault();
    });
    // 페이지 로드시 호출
    $scope.searchSmsSendViewPop = function(data, pageGubun) {
        var smsSendViewPopScope = agrid.getScope('smsSendCtrl');
        smsSendViewPopScope.initPageSmsSend(data, pageGubun);
        var smsSendViewPopSmsPopupScope = agrid.getScope("smsPopupCtrl");
        smsSendViewPopSmsPopupScope._broadcast('smsPopupCtrl');
    };
    // <-- //검색 호출 -->

    // 페이지 로드시 호출
    $scope.initPageSmsSend = function(data, pageGubun) {
        if(pageGubun == "Y") {
            $("#lblPageGubun").text(pageGubun);
            $("#trStoreNmInfo").css("display", "");
            $("#trMemoInfo").css("display", "");
        } else {
            $("#trStoreNmInfo").css("display", "none");
            $("#trMemoInfo").css("display", "none");
        }

        // 본인인증 여부 체크
        $scope.verifyChk();

        // 관리자/총판/본사/매장 명칭
        $scope.storeNmInfo();

        // 잔여금액
        $scope.restSmsAmt();

        if(data != undefined) {
            // 수신자목록 셋팅
            $scope.receiveNameSet(data);
        }

        // 메세지그룹
        if(msgGrpColList == "") {
            $("#divMsgGrpPage").css("display", "none");
            $("#divMsgGrpPageAuth").css("display", "");
        } else {
            $("#divMsgGrpPage").css("display", "");
            $("#divMsgGrpPageAuth").css("display", "none");

            // 메세지그룹 탭
            $scope.msgGrpShow("01");
        }
    };

    // 본인인증 여부 체크
    $scope.verifyChk = function() {
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/marketingSmsSend/marketingSmsSend/getVerifyChk.sb', params, function (response) {

            if (response.data.data.list === 0) {

                $scope._popConfirm(messages["marketingSmsSend.verifyConfirm"], function() {
                    // 본인인증 팝업창 띄우기
                    $scope.verify();

                });
            } else {

                // 발신번호 유무 체크
                $scope.tellNumChk();
            }
        });
    };

    // 본인인증
    $scope.verify = function(){
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/marketingSmsSend/marketingSmsSend/getVerifyChk.sb', params, function (response) {

            if (response.data.data.list !== 0) {
                $scope._popMsg(messages["marketingSmsSend.verifyChk"]);
                return false;
            } else {


                $.postJSON("/adi/sms/marketingSmsSend/marketingSmsSend/getVerifyVal.sb", null, function(result) {
                    var data = result.data;
                    console.log(data);

                    var auth_form = document.form_auth;

                    var return_gubun;
                    var width = 410;
                    var height = 500;

                    var leftpos = screen.width / 2 - (width / 2);
                    var toppos = screen.height / 2 - (height / 2);

                    var winopts = "width=" + width + ", height=" + height + ", toolbar=no,status=no,statusbar=no,menubar=no,scrollbars=no,resizable=no";
                    var position = ",left=" + leftpos + ", top=" + toppos;

                    var url = data.gwUrl + '?' +                        // KCP 인증창
                        'site_cd=' + data.siteCd + '&' +                // 상점코드
                        'ordr_idxx=' + data.ordrIdxx + '&' +            // 상점관리요청번호
                        'req_tx=cert' + '&' +                                   // 요청의 종류를 구분하는 변수
                        'cert_method=01' + '&' +                                // 01-휴대폰인증 02-공인인증(추후제공)
                        'up_hash=' + data.upHash + '&' +                // 요청 hash data
                        'Ret_URL=' + data.retUrl + '?sid=' + data.sessionId + '&' +                // 본인인증 결과 리턴페이지
                        'cert_otp_use=Y' + '&' +                                // 인요청시 OTP승인 여부
                        'cert_enc_use_ext=Y'
                    ;

                    console.log("JH");
                    console.log("site_cd : " + data.siteCd);
                    console.log("web_siteid : " + data.webSiteid);
                    console.log("gw_url : " + data.gwUrl);
                    console.log("Ret_URL : " + data.retUrl);
                    console.log("ordr_idxx : " + data.ordrIdxx);
                    console.log("up_hash : " + data.upHash);
                    console.log("sessionID : " + data.sessionId);
                    console.log("url : " + url);

                    // 저장기능 수행
                    var params = {};
                    params.certId = data.ordrIdxx;

                    $.postJSONArray("/adi/sms/marketingSmsSend/marketingSmsSend/saveVerify.sb", params, function (result) {
                            console.log("JH : 결과");
                            var AUTH_POP =  window.open(url, 'auth_popup', winopts + position);
                            console.log('1111');
                        },
                        function (result) {
                            s_alert.pop("JH : 결과msg" + result.message);
                            s_alert.pop(result.message);
                        });
                });
            }
        });
    };

    // 발신번호 유무 체크
    $scope.tellNumChk = function() {
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/smsSend/smsSend/getSmsTelNoComboList.sb', params, function (response) {
            if (response.data.data.list.length > 0) {
                var telNoList = response.data.data.list;
                $scope._setComboData("telNoCombo", telNoList); // 전송자번호

            } else {
                $scope._setComboData("telNoCombo", telNoComboData); // 전송자번호

                // 등록된 발신번호가 없습니다. <br/> 문자메세지 발송을 위해서는 <br/> 발신번호를 사전 등록하셔야 합니다. <br/> 등록을 진행하시겠습니까?
                if (confirm(messages["smsSend.telNoConfirm"])) {
                    // 발신번호 사전등록 팝업
                    $scope.wjSmsTelNoRegisterLayer.show(true);
                    var scope = agrid.getScope("smsTelNoRegisterCtrl");
                    scope.getVal();
                    event.preventDefault();

                } else {
                    // 화면
                    // $("#divSmsSendPage").css("display", "none");
                    // $("#divSmsSendPageAuth").css("display", "");
                }
            }
        });
    };

    // 발신번호 유무 체크 (발신번호 사전등록 팝업 닫을때 다시 체크)
    $scope.tellNumChkPop = function() {
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/smsSend/smsSend/getSmsTelNoComboList.sb', params, function (response) {
            if (response.data.data.list.length > 0) {
                var telNoList = response.data.data.list;
                $scope._setComboData("telNoCombo", telNoList); // 전송자번호

            } else {
                $scope._setComboData("telNoCombo", telNoComboData); // 전송자번호

                // 화면
                // $("#divSmsSendPage").css("display", "none");
                // $("#divSmsSendPageAuth").css("display", "");
            }
        });
    };

    // 관리자/총판/본사/매장 명칭
    $scope.storeNmInfo = function() {
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/smsSend/smsSend/getStoreNmList.sb', params, function (response) {
            var storeNmList = response.data.data.result;
            $scope.storeNmList = storeNmList;

            $("#lblStoreNmInfo").text("(광고)" +  storeNmList.storeNm);

            // 바이트
            $scope.showByte();
        });
    };

    // 잔여금액
    $scope.restSmsAmt = function() {
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/smsSend/smsSend/getSmsAmtList.sb', params, function (response) {
            var smsAmtList = response.data.data.result;
            $scope.smsAmtList = smsAmtList;

            $("#lblSmsAmt").text($scope.smsAmtList.smsAmt);
            $("#lblSmsOneAmt").text($scope.smsAmtList.smsOneAmt); // SMS건당금액
            $("#lblLmsOneAmt").text($scope.smsAmtList.lmsOneAmt); // LMS건당금액
            $("#lblMmsOneAmt").text($scope.smsAmtList.mmsOneAmt); // MMS건당금액
        });
    };

    // 수신자목록 셋팅
    $scope.receiveNameSet = function(data) {
        gridYn = "Y"; // 전송,예약시 그리드가 없는지 체크(추가,조회를 하지않으면 그리드 생성안됨)

        for(var i = 0; i < data.length; i++) {
            // 파라미터 설정
            var params = {};
            params.status = "I";
            params.gChk = true;
            params.membrNo = data[i].membrNo;
            // params.telNm = data[i].membrNm;
            params.telNo = data[i].telNo;
            // params.memo = "";
            params.rOgnFg = data[i].orgnFg;
            params.rOgnCd = data[i].orgnCd;
            params.rUserId = data[i].userId;

            // 추가기능 수행 : 파라미터
            $scope._addRow(params);
        }
    };

    // 자동변환(이모티콘도 사용)
    $scope.addMsg = function(str) {
        var msgContent = $("#messageContent").val();
        $("#messageContent").val(msgContent + str);

        // 바이트
        $scope.showByte();
    };

    // 바이트
    $scope.showByte = function() {
        var storeNmInfoByte = $("#lblStoreNmInfo").text().getByteLength();
        var contentByte = $("#messageContent").val().getByteLength();
        var memoInfoByte = $("#lblMemoInfo").text().getByteLength();
        var totByte = 0;

        if ($("#lblPageGubun").text() == "Y") {
            totByte = parseInt(storeNmInfoByte) + parseInt(contentByte) + parseInt(memoInfoByte);
        } else {
            totByte = parseInt(contentByte);
        }

        $("#lblTxtByte").text(totByte);

        if($("#lblMsgType").text() != "MMS") {
            if(totByte > 90) {
                $("#lblMsgType").text("LMS");
            } else {
                $("#lblMsgType").text("SMS");
            }
        }
    };

    // <-- 그리드 행 추가 -->
    $scope.addRow = function() {
        gridYn = "Y"; // 전송,예약시 그리드가 없는지 체크(추가,조회를 하지않으면 그리드 생성안됨)

        // 파라미터 설정
        var params = {};
        params.status = "I";
        params.gChk = true;
        params.membrNo = "";
        // params.telNm = "";
        params.telNo = "";
        // params.memo = "";
        params.rOgnFg = "X";
        params.rOgnCd = "";
        params.rUserId = "";

        // 추가기능 수행 : 파라미터
        $scope._addRow(params);
    };
    // <-- //그리드 행 추가 -->

    // <-- 그리드 행 삭제 -->
    $scope.del = function(){
        for(var i = $scope.flex.collectionView.items.length-1; i >= 0; i-- ){
            var item = $scope.flex.collectionView.items[i];

            if(item.gChk) {
                $scope.flex.collectionView.removeAt(i);
            }
        }
    };
    // <-- //그리드 행 삭제 -->

    // <-- 전송, 예약 -->
    // 전송, 예약
    $scope.smsSendReserve = function(reserveYn) {
        $scope.verifyChk();

        // 전송,예약시 그리드가 없는지 체크(추가,조회를 하지않으면 그리드 생성안됨)
        if (gridYn == "N") {
            s_alert.pop(messages["cmm.not.select"]);
            return;
        }

        if ($scope.telNoCombo == "") {
            $scope._popMsg(messages["smsSend.telNoAlert"]); // 사전등록된 발신번호가 없습니다. <br/> [발신번호 추가] 버튼으로 발신번호 사전등록하여 주십시오.
            return;
        }

        if ($("#messageContent").val() == "") {
            $scope._popMsg(messages["smsSend.messageContentAlert"]); // 메세지를 입력해주세요.
            return false;
        }

        if ($("#srchTitle").val() != "") {
            // 최대길이 체크
            if (nvl($("#srchTitle").val(), '').getByteLengthForOracle() > 40) {
                $scope._popMsg(messages["smsSend.titleLengthChk"]); // 제목 길이가 너무 깁니다.
                return false;
            }
        }

        // 메세지타입 1:SMS 2:LMS 3:MMS
        var msgType = "1";
        var msgTypeGubun = $("#lblMsgType").text();
        var txtByte = $("#lblTxtByte").text();
        var msgOneAmt = $("#lblSmsOneAmt").text(); // SMS건당금액
        if (msgTypeGubun == "LMS") {
            msgType = "2";
            msgOneAmt = $("#lblLmsOneAmt").text(); // LMS건당금액
            if (parseInt(txtByte) > 2000) {
                $scope._popMsg(messages["smsSend.txtByteOverAlert"]); // 2000 바이트 이상 전송이 불가합니다.
                return;
            }
        } else if (msgTypeGubun == "MMS") {
            msgType = "3";
            msgOneAmt = $("#lblMmsOneAmt").text(); // MMS건당금액
            if (parseInt(txtByte) > 2000) {
                $scope._popMsg(messages["smsSend.txtByteOverAlert"]); // 2000 바이트 이상 전송이 불가합니다.
                return;
            }
        }

        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if ($scope.flex.collectionView.items[i].gChk) {
                params.push($scope.flex.collectionView.items[i]);
            }
        }
        if (params.length <= 0) {
            s_alert.pop(messages["cmm.not.select"]);
            return;
        }

        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if ($scope.flex.collectionView.items[i].gChk) {
                if ($scope.flex.collectionView.items[i].telNo === "") {
                    $scope._popMsg(messages["smsSend.telNoBlank"]); // 수신번호를 입력해주세요.
                    return false;
                }
            }
        }

        // 잔여금액
        var smsAmt = $("#lblSmsAmt").text();
        if (parseInt(smsAmt) < 1) {
            $scope._popMsg(messages["smsSend.smsAmtAlert"]); // 전송가능한 금액이 없습니다.
            return;
        }
        if (parseInt(smsAmt) < (parseInt(params.length) * parseInt(msgOneAmt))) {
            $scope._popMsg(messages["smsSend.smsAmtOverAlert"] + (parseInt(params.length) * parseInt(msgOneAmt)) + messages["smsSend.smsAmtOverAlert2"]); // 전송시 필요한 잔여금액이 부족합니다. 000원의 잔여금액이 필요합니다.
            return;
        }

        // 0:전송, 1:예약
        if (reserveYn == "1") {
            var param = {};
            param.reserveYn = reserveYn;
            param.gubun = "smsSend";
            param.msgType = msgType;
            param.msgOneAmt = msgOneAmt;

            $scope.setSelectedSmsSend(param);
            $scope.wjSmsReserveLayer.show(true);
            event.preventDefault();
        } else {
            // 전송 저장
            $scope.smsSendSave(reserveYn, "", msgType, msgOneAmt);
        }
    };

    // 전송 저장
    $scope.smsSendSave = function(reserveYn, reserveDate, msgType, msgOneAmt) {
        // 첨부파일 개수
        var fileCount = 0;
        // MMS 첨부파일 체크
        if(msgType == "3") {
            // 첨부파일1
            if (!isNull($("#fileSms1")[0].files[0])) {
                // 크기제한 체크
                var maxSize = 300 * 1024;
                var fileSize = $("#fileSms1")[0].files[0].size;
                if (fileSize > maxSize) {
                    $scope._popMsg(messages["smsSend.fileSizeChk.300.msg"]); // 첨부파일은 300KB 이내로 등록 가능합니다.
                    return;
                }
                // 파일명 형식 체크
                var imgFullNm = $("#fileSms1").val().substring($("#fileSms1").val().lastIndexOf('\\') + 1);
                if(1 > imgFullNm.lastIndexOf('.')){
                    $scope._popMsg(messages["smsSend.fileNmChk.msg"]); // 파일명 또는 확장자가 올바르지 않습니다. 다시 확인해주세요.
                    return;
                }
                // 확장자 체크
                var reg = /(.*?)\.(jpg|JPG)$/;
                if(! $("#fileSms1").val().match(reg)) {
                    $scope._popMsg(messages["smsSend.fileExtensionChk.msg"]); // 확장자가 .jpg .JPG 인 파일만 등록가능합니다.
                    return;
                }
                fileCount = fileCount + 1;
            }

            // 첨부파일2
            if (!isNull($("#fileSms2")[0].files[0])) {
                // 크기제한 체크
                var maxSize = 300 * 1024;
                var fileSize = $("#fileSms2")[0].files[0].size;
                if (fileSize > maxSize) {
                    $scope._popMsg(messages["smsSend.fileSizeChk.300.msg"]); // 첨부파일은 300KB 이내로 등록 가능합니다.
                    return;
                }
                // 파일명 형식 체크
                var imgFullNm = $("#fileSms2").val().substring($("#fileSms2").val().lastIndexOf('\\') + 1);
                if(1 > imgFullNm.lastIndexOf('.')){
                    $scope._popMsg(messages["smsSend.fileNmChk.msg"]); // 파일명 또는 확장자가 올바르지 않습니다. 다시 확인해주세요.
                    return;
                }
                // 확장자 체크
                var reg = /(.*?)\.(jpg|JPG)$/;
                if(! $("#fileSms2").val().match(reg)) {
                    $scope._popMsg(messages["smsSend.fileExtensionChk.msg"]); // 확장자가 .jpg .JPG 인 파일만 등록가능합니다.
                    return;
                }
                fileCount = fileCount + 1;
            }

            // 첨부파일3
            if (!isNull($("#fileSms3")[0].files[0])) {
                // 크기제한 체크
                var maxSize = 300 * 1024;
                var fileSize = $("#fileSms3")[0].files[0].size;
                if (fileSize > maxSize) {
                    $scope._popMsg(messages["smsSend.fileSizeChk.300.msg"]); // 첨부파일은 300KB 이내로 등록 가능합니다.
                    return;
                }
                // 파일명 형식 체크
                var imgFullNm = $("#fileSms3").val().substring($("#fileSms3").val().lastIndexOf('\\') + 1);
                if(1 > imgFullNm.lastIndexOf('.')){
                    $scope._popMsg(messages["smsSend.fileNmChk.msg"]); // 파일명 또는 확장자가 올바르지 않습니다. 다시 확인해주세요.
                    return;
                }
                // 확장자 체크
                var reg = /(.*?)\.(jpg|JPG)$/;
                if(! $("#fileSms3").val().match(reg)) {
                    $scope._popMsg(messages["smsSend.fileExtensionChk.msg"]); // 확장자가 .jpg .JPG 인 파일만 등록가능합니다.
                    return;
                }
                fileCount = fileCount + 1;
            }
        }

        // 전송수량(체크된 수신자)
        var smsSendQty = 0;
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if($scope.flex.collectionView.items[i].gChk) {
                smsSendQty = smsSendQty + 1;
            }
        }

        // SMS 전송수량은 5건 입니다. 전송하시겠습니까?
        var msg = $("#lblMsgType").text() + messages["smsSend.smsSendConfirm"]  + " " + smsSendQty + messages["smsSend.smsSendConfirm2"];
        if (confirm(msg)) {
            // 전송가능 시간 체크(09~21시)
            var date = new Date();
            var hh = new String(date.getHours());
            if(parseInt(hh) < 9 || parseInt(hh) > 21) {
                $scope._popMsg(messages["smsSend.smsSendTimeAlert"]); // 전송가능한 시간대가 아닙니다. 09~21시만 전송가능합니다.
                return;
            }

            // MMS
            if(msgType == "3") {
                // 첨부파일 저장
                $scope.smsSendFileSave(reserveYn, reserveDate, msgType, msgOneAmt, fileCount);
            // SMS, LMS
            } else {
                // 전송 저장 save
                $scope.smsSendRealSave(reserveYn, reserveDate, msgType, msgOneAmt, 0, "");
            }
        }
    };

    // 전송 저장 save
    $scope.smsSendRealSave = function(reserveYn, reserveDate, msgType, msgOneAmt, fileCount, contentData) {
        // 파라미터 설정
        var params = new Array();
        for (var i = 0; i < $scope.flex.collectionView.items.length; i++) {
            if($scope.flex.collectionView.items[i].gChk) {
                // 내용
                var messageContent = $("#messageContent").val();
                if (messageContent == undefined) {
                    messageContent = "";
                }
                // messageContent = messageContent.replaceAll("#이름#", $scope.flex.collectionView.items[i].telNm);
                // messageContent = messageContent.replaceAll("#추가사항#", $scope.flex.collectionView.items[i].memo);
                var content = messageContent;
                if ($("#lblPageGubun").text() == "Y") {
                    content = $("#lblStoreNmInfo").text() + "\n" + messageContent + "\n" + $("#lblMemoInfo").text();
                }

                $scope.flex.collectionView.items[i].reserveYn = reserveYn; // 0:전송, 1:예약
                if (reserveYn == "1") {
                    $scope.flex.collectionView.items[i].sendDate = reserveDate; // 전송일시
                }
                $scope.flex.collectionView.items[i].title = $("#srchTitle").val(); // 제목
                $scope.flex.collectionView.items[i].content = content; // 내용
                $scope.flex.collectionView.items[i].msgType = msgType; // 메세지타입
                $scope.flex.collectionView.items[i].cstNo = $scope.flex.collectionView.items[i].membrNo; // 회원번호
                $scope.flex.collectionView.items[i].callback = $scope.telNoCombo; // 보내는사람 번호
                $scope.flex.collectionView.items[i].phoneNumber = $scope.flex.collectionView.items[i].telNo.replaceAll("-", ""); // 받는사람 번호
                $scope.flex.collectionView.items[i].rrOrgnFg = $scope.flex.collectionView.items[i].rOgnFg; // 받는사람 소속구분
                $scope.flex.collectionView.items[i].rrOrgnCd = $scope.flex.collectionView.items[i].rOgnCd; // 받는사람 소속코드
                $scope.flex.collectionView.items[i].rrUserId = $scope.flex.collectionView.items[i].rUserId; // 받는사람ID
                $scope.flex.collectionView.items[i].contentCount = fileCount; // 전송할 컨텐츠 개수
                $scope.flex.collectionView.items[i].contentData = contentData; // 전송할 컨텐츠(파일명^컨텐츠타입^컨텐츠서브타입)
                $scope.flex.collectionView.items[i].pageGubun = "smsSend"; // 페이지구분
                $scope.flex.collectionView.items[i].smsSendSeq = ""; // 전송이력시퀀스(SMS전송 팝업 : 전송시 채번 / 마케팅용 SMS전송 : 회원조회시 채번)
                $scope.flex.collectionView.items[i].msgOneAmt = msgOneAmt; // 메세지별 건당금액

                params.push($scope.flex.collectionView.items[i]);
            }
        }

        // 저장기능 수행 : 저장URL, 파라미터, 콜백함수
        $scope._postJSONSave.withPopUp("/adi/sms/smsSend/smsSend/getSmsSendReserveSave.sb", params, function(){ $scope.allSearch(); });
    };

    // 재조회
    $scope.allSearch = function () {
        $("#srchTitle").val("");
        $("#messageContent").val("");
        $("#lblTxtByte").text("0");
        $("#lblMsgType").text("SMS");

        $scope._gridDataInit();

        // 잔여금액
        $scope.restSmsAmt();

        // 첨부파일 초기화
        $scope.clearSmsFile();
    };

    // 첨부파일 저장
    $scope.smsSendFileSave = function(reserveYn, reserveDate, msgType, msgOneAmt, fileCount) {
        var formData = new FormData($("#smsForm")[0]);
        // formData.append("orgnCd", orgnCd);
        formData.append("pageGubun", "fileSms");

        var url = '/adi/sms/smsSend/smsSend/getSmsSendFileSave.sb';
        $.ajax({
            url: url,
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            // async:false,
            success: function(result) {
                // alert(result.status);
                // alert(result.data);
                // console.log('save result', result);
                if (result.status === "OK") {
                    // $scope._popMsg("저장되었습니다.");
                    $scope.$broadcast('loadingPopupInactive');

                    // 전송할 컨텐츠(파일명^컨텐츠타입^컨텐츠서브타입)
                    var contentData = result.data;
                    contentData = contentData.substring(0, contentData.length-1);

                    // 전송 저장 save
                    $scope.smsSendRealSave(reserveYn, reserveDate, msgType, msgOneAmt, fileCount, contentData);
                }
                else if (result.status === "FAIL") {
                    $scope._popMsg('Ajax Fail By HTTP Request');
                    $scope.$broadcast('loadingPopupInactive');
                }
                else if (result.status === "SERVER_ERROR") {
                    $scope._popMsg(result.message);
                    $scope.$broadcast('loadingPopupInactive');
                }
                /*else if(result.status === undefined) {
                    location.href = "/";
                }*/
                else {
                    var msg = result.status + " : " + result.message;
                    $scope._popMsg(msg);
                    $scope.$broadcast('loadingPopupInactive');
                }
            },
            error : function(result){
                $scope._popMsg("error");
                $scope.$broadcast('loadingPopupInactive');
            }
        },function() {
            $scope._popMsg("Ajax Fail By HTTP Request");
            $scope.$broadcast('loadingPopupInactive');
        });
    };
    // <-- //전송, 예약 -->

    // 메세지그룹 탭
    $scope.msgGrpShow = function(msgGrpCd) {
        $("#divMsgComment").html("");

        // 탭 색상변경
        for(var i=0; i < msgGrpColList.length; i++) {
            if(msgGrpColList[i].msgGrpCd == msgGrpCd) {
                $("#msgGrpTab"+ msgGrpColList[i].msgGrpCd).addClass("on");
            } else {
                $("#msgGrpTab" + msgGrpColList[i].msgGrpCd).removeClass("on");
            }
        }

        var params = {};
        params.msgGrpCd = msgGrpCd;

        $scope._postJSONQuery.withOutPopUp("/adi/sms/msgManage/msgManage/getMsgManageDtlList.sb", params, function(response) {
            var list = response.data.data.list;
            var innerHtml = "";

            if(list.length > 0) {
                for(var i=0; i < list.length; i++) {
                    innerHtml += "<div style=\"float:left; text-align:center; width:125px; height:140px; padding-top:10px; padding-right:10px;\">";
                    innerHtml += "<table>";
                    innerHtml += "<colgroup>";
                    innerHtml += "<col class=\"w100\" />";
                    innerHtml += "</colgroup>";
                    innerHtml += "<tbody>";
                    innerHtml += "<table>";
                    innerHtml += "<tr><td><input type=\"text\" class=\"sb-input-msg w100\" value=\""+ list[i].title +"\" readonly/></td></tr>";
                    innerHtml += "<tr style=\"height: 10px\"></tr>";
                    innerHtml += "<tr><td><textarea style=\"width:100%; height:90px; overflow-x:hidden; background-color: #EAF7FF\" onclick=\"msgShow(\'"+ list[i].title + "\', \'"+ list[i].message + "\')\" readonly>" + list[i].message + "</textarea></td></tr>";
                    innerHtml += "</table>";
                    innerHtml += "</div>";
                }
                $("#divMsgComment").html(innerHtml);
            }
        }, false);
    };

    // 메세지관리 목록 내용 삽입
    $scope.msgShow = function (data) {
        $("#srchTitle").val(data.title);
        $("#messageContent").val(data.message);

        // 바이트
        $scope.showByte();
    };

    // 선택
    $scope.selectedSmsSend;
    $scope.setSelectedSmsSend = function(store) {
        $scope.selectedSmsSend = store;
    };
    $scope.getSelectedSmsSend = function() {
        return $scope.selectedSmsSend;
    };

    // 발신번호추가
    $scope.telNoAdd = function() {
        var params = {};

        $scope._postJSONQuery.withOutPopUp('/adi/sms/marketingSmsSend/marketingSmsSend/getVerifyChk.sb', params, function (response) {

            if (response.data.data.list === 0) {

                $scope._popConfirm(messages["marketingSmsSend.verifyConfirm"], function () {
                    // 본인인증 팝업창 띄우기
                    $scope.verify();

                });
            } else {
                $scope.wjSmsTelNoRegisterLayer.show(true);
                var scope = agrid.getScope("smsTelNoRegisterCtrl");
                scope.getVal();
                event.preventDefault();
            }
        });
    };

    // 수신자추가
    $scope.addAddressee = function() {
        $scope.wjAddresseeAddLayer.show(true);
        event.preventDefault();
    };

    // 화면 ready 된 후 설정
    angular.element(document).ready(function () {

        // 발신번호 사전등록 팝업 핸들러 추가
        $scope.wjSmsTelNoRegisterLayer.shown.addHandler(function (s) {
            setTimeout(function() {
                $scope._broadcast('smsTelNoRegisterCtrl', null);
            }, 50)
        });

        // 수신자추가 팝업 핸들러 추가
        $scope.wjAddresseeAddLayer.shown.addHandler(function (s) {
            setTimeout(function() {
                $scope._broadcast('addresseeAddCtrl', null);
            }, 50)
        });

        // SMS예약 팝업 핸들러 추가
        $scope.wjSmsReserveLayer.shown.addHandler(function (s) {
            setTimeout(function() {
                $scope._broadcast('smsReserveCtrl', $scope.getSelectedSmsSend());
            }, 50)
        });
    });

    // 첨부파일
    $scope.changeSmsImage = function (value) {
        if(value.files[0]) {
            $("#lblMsgType").text("MMS");

        // 첨부파일 취소시
        } else {
            // 일단 SMS으로 셋팅하고 다시 바이트 수 체크해서 셋팅
            $("#lblMsgType").text("SMS");
            // 바이트
            $scope.showByte();
        }
    };

    // 첨부파일 초기화
    $scope.clearSmsFile = function () {
        // 첨부파일 리셋
        var agent = navigator.userAgent.toLowerCase();
        if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ){
            // ie 일때
            // $("#fileSms1").replaceWith( $("#fileSms1").clone(true) );
            // $("#fileSms2").replaceWith( $("#fileSms2").clone(true) );
            // $("#fileSms3").replaceWith( $("#fileSms3").clone(true) );
            $("#fileSms1").val("");
            $("#fileSms2").val("");
            $("#fileSms3").val("");
        } else {
            // other browser 일때
            $("#fileSms1").val("");
            $("#fileSms2").val("");
            $("#fileSms3").val("");
        }
        $("#smsForm")[0].reset();
    };

    // 팝업 닫기
    $scope.close = function() {
        $("#srchTitle").val("");
        $("#messageContent").val("");
        $("#lblTxtByte").text("0");
        $("#lblMsgType").text("SMS");
        $scope._gridDataInit();

        // 첨부파일 초기화
        $scope.clearSmsFile();

        $scope.wjSmsSendLayer.hide();
        event.preventDefault();
    };
}]);


/**
 *  팝업 조회 그리드 생성
 */
app.controller('smsPopupCtrl', ['$scope', '$http', function ($scope, $http) {

    // 상위 객체 상속 : T/F 는 picker
    angular.extend(this, new RootController('smsPopupCtrl', $scope, $http, false));

    // grid 초기화 : 생성되기전 초기화되면서 생성된다
    $scope.initGrid = function (s, e) {
    };

    // <-- 검색 호출 -->
    $scope.$on("smsPopupCtrl", function(event, data) {
        // 닫았다 다시 호출하면 안떠서
        // 날짜 비교하여 팝업 띄우기
        if(Number(now) >= Number(startDate)){
            if(Number(endDate) >= Number(now)){
                if(getCookie("notSmsNotice")!="Y") {
                    $("#divDimmed").css('display', 'block');
                    $("#divPopup").css('display', 'block');
                }
            }
        }
        event.preventDefault();
    });
    // <-- //검색 호출 -->

    // 팝업 게시 기간
    var startDate = '20210201';
    var endDate = '29991231';

    // 오늘 날짜
    var date = new Date();
    var year = new String(date.getFullYear());
    var month = new String(date.getMonth()+1);
    var day = new String(date.getDate());

    // 한자리수일 경우 0을 채워준다.
    if(month.length == 1){
        month = "0" + month;
    }
    if(day.length == 1){
        day = "0" + day;
    }
    var now = year + "" + month + "" + day;

    // 1. 쿠키 만들기
    function setCookie(name, value, expiredays) {
        var today = new Date();
        today.setDate(today.getDate() + expiredays);
        document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
    }

    //2. 쿠키 가져오기
    function getCookie(name){
        var cName = name + "=";
        var x = 0;
        while ( x <= document.cookie.length )
        {
            var y = (x+cName.length);
            if ( document.cookie.substring( x, y ) == cName )
            {
                if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 )
                    endOfCookie = document.cookie.length;
                return unescape( document.cookie.substring( y, endOfCookie ) );
            }
            x = document.cookie.indexOf( " ", x ) + 1;
            if ( x == 0 )
                break;
        }
        return "";
    }

    //alert(getCookie("notSmsNotice"));

    // 날짜 비교하여 팝업 띄우기
    if(Number(now) >= Number(startDate)){
        if(Number(endDate) >= Number(now)){
            if(getCookie("notSmsNotice")!="Y") {
                $("#divDimmed").css('display', 'block');
                $("#divPopup").css('display', 'block');
            }
        }
    }

    // 오늘하루 열지않기
    $scope.closeToday = function() {
        setCookie('notSmsNotice','Y', 1);
        $("#divDimmed").css('display', 'none');
        $("#divPopup").css('display', 'none');
    };

    // 닫기
    $scope.close = function() {
        $("#divDimmed").css('display', 'none');
        $("#divPopup").css('display', 'none');
    };
}]);