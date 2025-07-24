<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- パラメータの取得 --%>
<fmt:requestEncoding value="utf-8" />
<c:set var="formKounyuuhins" value="${paramValues.kounyuuhin}"/>

<%-- データベースへのコネクションを取得 --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%-- 詳細画面で入力した値を取得する --%>
<fmt:requestEncoding value="utf-8" />

<%--

  注文内容をデータベースに登録するSQL文を実行する
  [PURCHASE_HISTORY]テーブルに、[PRODUCT_CODE], [CUSTOMER_NAME],
  [PURCHASE_DATE], [PRODUCT_NUM],[PRICE] を登録するSQL文

--%>
<sql:update>
	INSERT INTO PURCHACE_INFO (PRODUCT_CODE,CUSTOMER_MAIL,PURCHACE_DATE,PRIDUCT_NUM,PRICE) VALUES(?, ?, ?, ?, ?*2);
	<sql:param value="${formProductCode}"/>
	<sql:param value="${formCustomerMail}"/>
	<sql:dateParam value="<%=new java.util.Date()%>" type="TIMESTAMP"/>
	<sql:param value="${formProductNum}"/>
	<sql:param value="${formPrice}"/>
</sql:update>

<%-- カスタマイズ3 在庫を減らす --%>
<sql:update>
	UPDATE PRODUCT_STOCK SET STOCK_NUM = STOCK_NUM - ? WHERE PRODUCT_CODE = ?;
	<sql:param value="${formProductNum}"/>
	<sql:param value="${formProductCode}"/>
</sql:update>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<TITLE>購入結果</TITLE>
<STYLE type="text/css">
body {background-color:white;}

.white {background-color:#ffffff}
.top1{height:20px;width:100%;}
.top1 ul{display: flex; justify-content: right; list-style: none;}
.top1 li{padding: 10px; border-left:1px solid #333;}
.top2{height:50px;width:100%;}
h1{background-color:#eeeeee; text-align:center;}
img{text-align:center;}
footer{background-color:#eeeeee; width: 100%; height: 120px; text-align: center; padding: 50px 0;}
</STYLE>
</head>
<BODY>

  	<div class="white top1">
		<ul class="list1">
			<li><a href="relist.jsp">ホーム</a></li>
			<li>ログイン済み</li>
			<li><a href="recart.jsp">カートを見る</a></li>
		</ul>
	</div>
  	<h1><a href="relist.jsp"><img src="HatchfulExport-All2/twitter_header_photo_2.png" width=auto height="250px"></a></h1>
	<div class="white top2"></div>

	<center>
		<FONT size="3" color="#000000"><B>ご購入ありがとうございました。</B></FONT>
		<BR><BR>

		製品コード：${formProductCode}<BR>
		製品価格：${formPrice}<BR>

	</center>
	<br><br>
	<footer>
		<p>© 1X21C064-8 Yuto Takahashi</p>
	</footer>
</BODY>
</HTML>
