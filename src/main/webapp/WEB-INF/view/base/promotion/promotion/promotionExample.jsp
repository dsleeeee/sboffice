<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<wj-popup control="promotionExampleLayer" show-trigger="Click" hide-trigger="Click" style="display:none;width:950px;">
    <div class="wj-dialog wj-dialog-columns" ng-controller="promotionExampleCtrl">

        <%-- header --%>
        <div class="wj-dialog-header wj-dialog-header-font">
            <s:message code="promotion.promotion"/>&nbsp;<s:message code="promotion.example"/>
            <a href="" class="wj-hide btn_close" ng-click="close()"></a>
        </div>

        <div class="wj-dialog-body">

            <div class="divBar mt10" id="ex1" onclick="divFldUnfld('ex1')">
                <a href="#" class="open">
                    (사례1) <span style="color:red;">[기간 할인]</span> 2022년 11월1일부터 11월30일까지 모든 고객을 대상으로 구매 금액의 15%를 할인해 주는 행사
                </a>
            </div>
            <div class="w100" id="ex1Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex1.JPG" style="width:100%" alt="ex1" />
            </div>

            <div class="divBar mt10" id="ex2" onclick="divFldUnfld('ex2')">
                <a href="#" class="open">
                    (사례2) <span style="color:red;">[시간대 할인]</span> 매주 수요일 오전 10:30 부터 11:30 사이에 구매시 구매 금액의 20% 할인
                </a>
            </div>
            <div class="w100" id="ex2Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex2.JPG" style="width:100%" alt="ex2" />
            </div>

            <div class="divBar mt10" id="ex3" onclick="divFldUnfld('ex3')">
                <a href="#" class="open">
                    (사례3) <span style="color:red;">[금액구간별 할인]</span> 10만원 이상 구매시 구매 금액의 10% 할인, 20만원 이상 구매시 구매금액의 20% 할인, 30만원 이상 구매시 구매금액의 30%할인
                </a>
            </div>
            <div class="w100" id="ex3Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex3.JPG" style="width:100%" alt="ex3" />
            </div>

            <div class="divBar mt10" id="ex4" onclick="divFldUnfld('ex4')">
                <a href="#" class="open">
                    (사례4) <span style="color:red;">[회원등급별 할인]</span> 골드회원 10% 할인, 플래티넘 회원 20% 할인, VIP 회원 30%할인
                </a>
            </div>
            <div class="w100" id="ex4Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex4.JPG" style="width:100%" alt="ex4" />
            </div>

            <div class="divBar mt10" id="ex5" onclick="divFldUnfld('ex5')">
                <a href="#" class="open">
                    (사례5) <span style="color:red;">[조건품목 전체구매 할인]</span> 0200500001(불고기피자)와 0200700002(고구마피자) 각각 1개씩 총 2개 구매시 해당 메뉴 3000원 할인 
                </a>
            </div>
            <div class="w100" id="ex5Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex5.JPG" style="width:100%" alt="ex5" />
            </div>

            <div class="divBar mt10" id="ex6" onclick="divFldUnfld('ex6')">
                <a href="#" class="open">
                    (사례6) <span style="color:red;">[조건품목 일부할인 (종류와수량)]</span> 지정된 5가지 품목 중 2가지 품목을 각각 2개 구매시 해당 품목 5000원 할인
                </a>
            </div>
            <div class="w100" id="ex6Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex6.JPG" style="width:100%" alt="ex6" />
            </div>

            <div class="divBar mt10" id="ex7" onclick="divFldUnfld('ex7')">
                <a href="#" class="open">
                    (사례7) <span style="color:red;">[조건품목 일부할인 (수량)]</span> 지정된 5가지 품목 중 아무거나 2개 구매시 2000원 할인
                </a>
            </div>
            <div class="w100" id="ex7Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex7.JPG" style="width:100%" alt="ex7" />
            </div>

            <div class="divBar mt10" id="ex8" onclick="divFldUnfld('ex8')">
                <a href="#" class="open">
                    (사례8) <span style="color:red;">[헤택품목할인 (A 전체구매시 B 할인)]</span> 0200900011(쉬림프 피자) 1개 구매시 0202100011(베이컨 파스타) 1개를 50% 할인
                </a>
            </div>
            <div class="w100" id="ex8Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex8.JPG" style="width:100%" alt="ex8" />
            </div>

            <div class="divBar mt10" id="ex9" onclick="divFldUnfld('ex9')">
                <a href="#" class="open">
                    (사례9) <span style="color:red;">[헤택품목할인 (A 일부구매시 B 할인)]</span> 0200500001~5 피자류 5가지 품목중 1개 구매시 특정 0202100011(베이컨 파스타) 1개를 50% 할인
                </a>
            </div>
            <div class="w100" id="ex9Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex9.JPG" style="width:100%" alt="ex9" />
            </div>

            <div class="divBar mt10" id="ex10" onclick="divFldUnfld('ex10')">
                <a href="#" class="open">
                    (사례10) <span style="color:red;">[전체구매 전체증정]</span> 0200900011(쉬림프 피자) 1개 구매시 0302100001(콜라) 1개 증정
                </a>
            </div>
            <div class="w100" id="ex10Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex10.JPG" style="width:100%" alt="ex10" />
            </div>

            <div class="divBar mt10" id="ex11" onclick="divFldUnfld('ex11')">
                <a href="#" class="open">
                    (사례11) <span style="color:red;">[일부구매 전체증정]</span> 0200300001~5(나뚜르 종류 아이스크림)중 아무거나 2개 구매시 0200300001(나뚜르 그린티) 1개 더 증정
                </a>
            </div>
            <div class="w100" id="ex11Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex11.JPG" style="width:100%" alt="ex11" />
            </div>

            <div class="divBar mt10" id="ex12" onclick="divFldUnfld('ex12')">
                <a href="#" class="open">
                    (사례12) <span style="color:red;">[전체구매 선택증정]</span> 0200300001(나뚜르 그린티) 1개 구매시 0200400001~5(티백 종류) 아무거나 1개 선택 증정
                </a>
            </div>
            <div class="w100" id="ex12Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex12.JPG" style="width:100%" alt="ex12" />
            </div>

            <div class="divBar mt10" id="ex13" onclick="divFldUnfld('ex13')">
                <a href="#" class="open">
                    (사례13) <span style="color:red;">[묶음상품 특별가 할인]</span> 0201900011(실론티 후라이팬) 2개 + 0201900012(실론티 냄비) 1개 같이 구매시 세트 특별가 59,700원으로 판매
                </a>
            </div>
            <div class="w100" id="ex13Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex13.JPG" style="width:100%" alt="ex13" />
            </div>

            <div class="divBar mt10" id="ex14" onclick="divFldUnfld('ex14')">
                <a href="#" class="open">
                    (사례14) <span style="color:red;">[품목개별 할인]</span> 지정된 5가지 품목 중 각기 개별 할인
                </a>
            </div>
            <div class="w100" id="ex14Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex14.JPG" style="width:100%" alt="ex14" />
            </div>

           <%-- <div class="divBar mt10" id="ex15" onclick="divFldUnfld('ex15')">
                <a href="#" class="open">
                    (사례15) <span style="color:red;">[쿠폰 할인]</span> 2022년 12월26일부터 2023년 1월31일까지 모든 고객을 대상으로 쿠폰사용시 구매 금액의 15%를 할인해 주는 행사
                </a>
            </div>
            <div class="w100" id="ex15Div">
                <img src="/resource/solbipos/css/img/promotion/example2/ex15.JPG" style="width:100%" alt="ex15" />
            </div>--%>

        </div>

    </div>
</wj-popup>

<script type="text/javascript" src="/resource/solbipos/js/base/promotion/promotion/promotionExample.js?ver=20221227.01" charset="utf-8"></script>