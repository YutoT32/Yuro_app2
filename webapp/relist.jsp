<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--  データベースへのコネクションを取得  --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%--  データベースからデータを取得して、変数rsに結果を入れる。
  [PRODUCT_INFO]テーブルから [PRODUCT_CODE], [PRODUCT_NAME],
  [CATEGORY_NAME], [MAKER_NAME], [DETAIL], [MATERIAL], [SIZE], [IMAGE],
  [PRICE] を [PRODUCT_CODE]の昇順で検索するSQL文。
--%>
<sql:query var="rs">
  SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL, MATERIAL, SIZE, IMAGE, PRICE FROM PRODUCT_INFO ORDER BY PRODUCT_CODE;
</sql:query>
<sql:query var="rt">
  SELECT PRODUCT_INFO.PRODUCT_CODE, PRODUCT_INFO.PRODUCT_NAME, PRODUCT_INFO.CATEGORY_NAME, PRODUCT_INFO.MAKER_NAME, PRODUCT_INFO.DETAIL, PRODUCT_INFO.MATERIAL, PRODUCT_INFO.SIZE, PRODUCT_INFO.IMAGE, PRODUCT_INFO.PRICE
  FROM PURCHACE_INFO, PRODUCT_INFO
  WHERE PURCHACE_INFO.CUSTOMER_MAIL=? and PURCHACE_INFO.PRODUCT_CODE=PRODUCT_INFO.PRODUCT_CODE;
  <sql:param value="${formCustomerMail}"/>
</sql:query>

<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<TITLE>衣料品販売</TITLE>

<%--  表示方法の設定  --%>

<STYLE type="text/css">
body {background-color:white;}
table {border-collapse:separate; border-spacing:2px; width:100%;}
th {background-color:#333333; text-align:center; font-size:large; font-weight:bold; color:white;}
td {background-color:#EFEFEF; font-size:normal; color:black;}
img {vertical-align: middle;}

.white {background-color:#ffffff}
.top1{height:20px;width:100%;}
.top1 ul{display: flex; justify-content: right; list-style: none;}
.top1 li{padding: 10px; border-left:1px solid #333;}
.top2{height:50px;width:100%;}
h1{background-color:#eeeeee; text-align:center;}
img{text-align:center;}
.main {width:80%; float:left;text-align:center;}
.side {width:20%; float:left;text-align:center;}
</STYLE>
</HEAD>

<BODY>

  <div class="white top1">
    <ul class="list1">
    <li><a href="relist.jsp">ホーム</a></li>
    <li>ログイン済み</li>
    <li><a href="recart.jsp">カートを見る</a></li>
    </ul>
  </div>

  <h1><a href="#"><img src="HatchfulExport-All2/twitter_header_photo_2.png" width=auto height="250px"></a></h1>

  <div class="white top2"></div>

  <div class="side">
      <br><h2>条件指定検索</h2>
      <FORM action="reresult.jsp" method="POST">
        <input type="checkbox" value="メンズトップス" checked name="categoryName">メンズトップス
        <br>
        <input type="checkbox" value="メンズシャツ" name="categoryName">メンズシャツ
        <br>
        <input type="checkbox" value="メンズパンツ" name="categoryName">メンズパンツ
        <br>
        <input type="checkbox" value="レディーストップス" name="categoryName">レディーストップス
        <br>
        <input type="checkbox" value="レディーススカート" name="categoryName">レディーススカート
        <br>
        <input type="checkbox" value="レディースワンピース" name="categoryName">レディースワンピース
        <br>
        <br><input type="submit" value="検索実行" name="search">
      </FORM>
  </div>

  <div class="main">
  	<FORM action="redetail.jsp" method="POST"> 
      <H2>もう一度買う？</H2><br>
			<TABLE>
				<TR>
					<TH>イメージ</TH>
					<TH>製品名</TH>
					<TH>カテゴリー</TH>
					<TH>メーカー</TH>
					<TH>サイズ</TH>
					<TH>販売価格</TH>
				</TR>
      <c:forEach var="row" items="${rt.rows}">
        <TR>
          <TD>
            <input type="radio" name="selectedProductCode" value="${row.PRODUCT_CODE}">
            <img src="image/${row.IMAGE}" height="60" />
          </TD>
          <TD>${row.PRODUCT_NAME}</TD>
          <TD>${row.CATEGORY_NAME}</TD>
          <TD>${row.MAKER_NAME}</TD>
          <TD>${row.SIZE}</TD>
          <TD><fmt:formatNumber value="${row.PRICE}" type="CURRENCY" currencyCode="JPY" maxFractionDigits="0"/></TD>
         </TR>
        </c:forEach>
			  </TABLE>
        <br><INPUT type="submit" value="詳細" name="detail">
		  </FORM> 
    </div>

</BODY>
</HTML>
