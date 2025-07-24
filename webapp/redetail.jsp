<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- データベースへのコネクションを取得 --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%-- 販売画面で選択した衣料品の情報を取得する --%>
<fmt:requestEncoding value="utf-8" />
<c:set var="formProductCode" value="${param.selectedProductCode}" scope="session"/>

<%--  商品の在庫を検索する --%>
<sql:query var="rs">
  SELECT STOCK_NUM FROM PRODUCT_STOCK WHERE PRODUCT_CODE = ?;
  <sql:param value="${formProductCode}" />
</sql:query>

<%-- 在庫数を変数[stockNum]に格納する --%>
<c:choose>
  <c:when test="${rs.rowCount == 0}">
    <c:set var="stockNum" value="0" />
  </c:when>
  <c:otherwise>
    <c:set var="row" value="${rs.rows[0]}" />
    <c:set var="stockNum" value="${row.STOCK_NUM}" />
  </c:otherwise>
</c:choose>

<%-- 商品の情報を検索する --%>
<sql:query var="rs">
  SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL, MATERIAL, SIZE, IMAGE, PRICE
  FROM PRODUCT_INFO WHERE PRODUCT_CODE=? ORDER BY PRODUCT_CODE;
<sql:param value="${formProductCode}" />
</sql:query>

<%-- 一行目を変数rowに代入 --%>
<c:set var="row" value="${rs.rows[0]}" />

<%-- セッション変数 --%>
<c:set var="formPrice" value="${row.Price}" scope="session"/>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <TITLE>詳細情報</TITLE>

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
    <H2>詳細画面</H2>
    <img src="image/${row.IMAGE}" /><BR>
    メーカー：${row.MAKER_NAME}<BR>
    製品名：${row.PRODUCT_NAME}<BR>
    素材：${row.MATERIAL}<BR>
    カテゴリ：${row.CATEGORY_NAME}<BR>
    説明：${row.DETAIL}<BR><BR>
    販売価格：${row.PRICE}<BR>

    <%-- 在庫数を確認して結果を表示する --%>
    <c:choose>
      <c:when test="${stockNum < 1}">
        申し訳ございません。${row.PRODUCT_NAME} は品切れです。<BR>
      </c:when>
      <c:otherwise>
        在庫：${stockNum}
        <FORM action="cartin.jsp" method="POST">
          <INPUT type="submit" name="buttonCart" value="カートに入れる">
        </FORM>
        <FORM action="buy.jsp" method="POST">
          <br>個数：
          <input type="text" name="productNum" value=""/><br><br>
          <INPUT type="submit" name="buttonBuy" value="即購入する">
        </FORM>
      </c:otherwise>
    </c:choose>
    </center>
    <br><br>
    <footer>
      <p>© 1X21C064-8 Yuto Takahashi</p>
    </footer>
  </BODY>
</HTML>
