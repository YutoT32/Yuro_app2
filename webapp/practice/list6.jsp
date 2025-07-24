<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--

  パラメータの取得

  search6.html で入力した文字列を取得し、変数 formMakerName に格納する

--%>
<fmt:requestEncoding value="utf-8" />

<c:set var="formPrice" value="${param.price}"/>

<%--

  データベースへのコネクションを取得

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%--

  データベースからデータを取得して、変数rsに結果を入れる。

  [PRODUCT_INFO]テーブルから formMakerNameとMAKER_NAMEが一致する商品の、
  [PRODUCT_NAME], [MAKER_NAME], [IMAGE] を検索するSQL文。
  
  複数選択の場合はその分表示する．選択なしの場合は全て表示する．

--%>
<sql:query var="rs">
SELECT * FROM PRODUCT_INFO WHERE PRICE<=?;
<sql:param value="${formPrice}"/>
</sql:query>

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
</STYLE>
</HEAD>

<BODY>
<CENTER>
  
<H2>検索結果</H2>

<TABLE>
	<TR>
					<TH>イメージ</TH>
					<TH>製品名</TH>
					<TH>カテゴリー</TH>
					<TH>メーカー</TH>
					<TH>サイズ</TH>
					<TH>販売価格</TH>
	</TR>

<%--

  検索結果レコードの表示処理

--%>

<c:forEach var="row" items="${rs.rows}">

<TR>

<%-- (3)ここに表示処理を追加する --%>
	<TR>
		<TD><CENTER><img src="image/${row.IMAGE}" height="60" /></CENTER></TD>
		<TD>${row.PRODUCT_NAME}</TD>
		<TD>${row.CATEGORY_NAME}</TD>
		<TD>${row.MAKER_NAME}</TD>
		<TD>${row.SIZE}</TD>
		<TD><fmt:formatNumber value="${row.PRICE}" type="CURRENCY" currencyCode="JPY" maxFractionDigits="0"/></TD>
	</TR>

</TR>

</c:forEach> <%-- rsのループ --%>

</TABLE>

</CENTER>
</BODY>
</HTML>
