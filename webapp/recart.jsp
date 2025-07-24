<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--  データベースへのコネクションを取得  --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%-- データベースからデータ取得 --%>
<sql:query var="rs">
SELECT PRODUCT_INFO.PRODUCT_CODE, PRODUCT_INFO.PRODUCT_NAME, PRODUCT_INFO.CATEGORY_NAME, PRODUCT_INFO.MAKER_NAME, PRODUCT_INFO.DETAIL, PRODUCT_INFO.MATERIAL, PRODUCT_INFO.SIZE, PRODUCT_INFO.IMAGE, PRODUCT_INFO.PRICE
FROM CART, PRODUCT_INFO
WHERE CART.MAIL=? and CART.PRODUCT_CODE=PRODUCT_INFO.PRODUCT_CODE;
<sql:param value="${formCustomerMail}"/>
</sql:query>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>オリジナル-カート-</title>
<STYLE type="text/css">
    body {background-color:white;}
    table {border-collapse:separate; border-spacing:2px; width:100%;}
    th {background-color:#333333; text-align:center; font-size:large; font-weight:bold; color:white;}
    td {background-color:#EFEFEF; font-size:normal; color:black;}

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

<body>

	<div class="white top1">
		<ul class="list1">
			<li><a href="relist.jsp">ホーム</a></li>
			<li>ログイン済み</li>
			<li><a href="cart.html">カートを見る</a></li>
		</ul>
	</div>
	
	<h1><a href="relist.jsp"><img src="HatchfulExport-All2/twitter_header_photo_2.png" width=auto height="250px"></a></h1>

	<div class="white top2"></div>
  
<center>
<h2>カート</h2>
<br><br>
<FORM action="cartbuy.jsp" method="POST">
	<TABLE>
		<TR>
			<TH>イメージ</TH>
			<TH>製品名</TH>
			<TH>カテゴリー</TH>
			<TH>メーカー</TH>
			<TH>サイズ</TH>
			<TH>販売価格</TH>
			<TH>カート</TH>
		</TR>
		<c:forEach var="row" items="${rs.rows}">
			<TR>
				<TD>
					<input type="checkbox" name="kounyuuhin" value="kounyuuhin">
					<img src="image/${row.IMAGE}" height="60" />
				</TD>
				<TD>${row.PRODUCT_NAME}</TD>
				<TD>${row.CATEGORY_NAME}</TD>
				<TD>${row.MAKER_NAME}</TD>
				<TD>${row.SIZE}</TD>
				<TD><fmt:formatNumber value="${row.PRICE}" type="CURRENCY" currencyCode="JPY" maxFractionDigits="0"/></TD>
				<TD></TD>
			</TR>
		</c:forEach>
	</TABLE><br>
	<INPUT type="submit" value="購入する" name="detail">
</FORM>
</center>
<br><br>
</body>
</html>
