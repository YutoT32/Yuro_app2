<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- パラメータの取得 --%>
<fmt:requestEncoding value="utf-8" />
<c:set var="formCategoryNames" value="${paramValues.categoryName}"/>

<%-- データベースへのコネクションを取得 --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%--

  データベースからデータを取得して、変数rsに結果を入れる。

  [PRODUCT_INFO]テーブルから formMakerNameとMAKER_NAMEが一致する商品の、
  [PRODUCT_NAME], [MAKER_NAME], [IMAGE] を検索するSQL文。
  
  複数選択の場合はその分表示する．選択なしの場合は全て表示する．

--%>
<c:choose>
<c:when test="${empty formCategoryNames}">
<sql:query var="rs">
	SELECT * FROM PRODUCT_INFO;
</sql:query>
</c:when>
<c:otherwise>
<sql:query var="rs">
	SELECT * FROM PRODUCT_INFO
	WHERE CATEGORY_NAME='${fn:join(formCategoryNames, "' OR CATEGORY_NAME='")}';
</sql:query>
</c:otherwise>
</c:choose>

<HTML>
<HEAD>
	<META http-equiv="Content-Language" content="ja">
	<META http-equiv="Content-Type" content="text/html; charset=utf-8">
	<TITLE>オリジナル-検索結果-</TITLE>

<%--

  表示方法の設定

--%>
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
footer{background-color:#eeeeee; width: 100%; height: 120px; text-align: center; padding: 50px 0;}
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
	
	  <h1><a href="relist.jsp"><img src="HatchfulExport-All2/twitter_header_photo_2.png" width=auto height="250px"></a></h1>
	
	  <div class="white top2"></div>

<CENTER>
  
<H2>検索結果</H2>
<form action="redetail.jsp" method="POST">
	<TABLE>
			<TR>
							<TH>イメージ</TH>
							<TH>製品名</TH>
							<TH>カテゴリー</TH>
							<TH>メーカー</TH>
							<TH>サイズ</TH>
							<TH>販売価格</TH>
			</TR>
		<%-- 検索結果レコードの表示処理 --%>
		<c:forEach var="row" items="${rs.rows}">
			<TR>
				<TR>
					<TD><input type="radio" name="selectedProductCode" value="${row.PRODUCT_CODE}"><CENTER><img src="image/${row.IMAGE}" height="60" /></CENTER></TD>
					<TD>${row.PRODUCT_NAME}</TD>
					<TD>${row.CATEGORY_NAME}</TD>
					<TD>${row.MAKER_NAME}</TD>
					<TD>${row.SIZE}</TD>
					<TD><fmt:formatNumber value="${row.PRICE}" type="CURRENCY" currencyCode="JPY" maxFractionDigits="0"/></TD>
				</TR>
			</TR>
		</c:forEach>
	</TABLE>
	<input type="hidden" name="selectedProductCode" value="${row.PRODUCT_CODE}">
	<INPUT type="submit" value="詳細" name="detail">
</form>

</CENTER>
<br><br>
<footer>
	<p>© 1X21C064-8 Yuto Takahashi</p>
</footer>
</BODY>
</HTML>
