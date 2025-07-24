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
SELECT PRODUCT_CODE, PRODUCT_NAME, CATEGORY_NAME, MAKER_NAME, DETAIL, MATERIAL, SIZE, IMAGE, PRICE
FROM PRODUCT_INFO ORDER BY PRODUCT_CODE;
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
footer{background-color:#eeeeee; width: 100%; height: 120px; text-align: center; padding: 50px 0;}
</STYLE>
</HEAD>

<BODY>

  <div class="white top1">
    <ul class="list1">
    <li><a href="login.html">ログイン</a></li>
    <li><a href="cart.html">カートを見る</a></li>
    </ul>
  </div>

  <h1><img src="HatchfulExport-All2/twitter_header_photo_2.png" width=auto height="250px"></h1>

  <div class="white top2"></div>

  
	<CENTER>
    <font color="#00adb5" size="5px">会員登録がお済の方は、ログインして頂いた便利です！</font>
    <br>
<p>
  <h2>条件指定検索</h2>
  <FORM action="result.jsp" method="POST">
    <input type="checkbox" value="メンズトップス" checked name="categoryName">メンズトップス<br>
    <input type="checkbox" value="メンズシャツ" name="categoryName">メンズシャツ<br>
    <input type="checkbox" value="メンズパンツ" name="categoryName">メンズパンツ<br>
    <input type="checkbox" value="レディーストップス" name="categoryName">レディーストップス<br>
    <input type="checkbox" value="レディーススカート" name="categoryName">レディーススカート<br>
    <input type="checkbox" value="レディースワンピース" name="categoryName">レディースワンピース<br>
    <input type="submit" value="検索実行" name="search">
  </FORM>

</p>

<br>
<hr>

<p>
		<FORM action="detail.jsp" method="POST"> 
      <br><H2>商品一覧</H2><H3><font color="#00adb5">詳細は左端のボタンを選択！</font></H3><br>
			<TABLE>
				<TR>
					<TH>イメージ</TH>
					<TH>製品名</TH>
					<TH>カテゴリー</TH>
					<TH>メーカー</TH>
					<TH>サイズ</TH>
					<TH>販売価格</TH>
				</TR>
      <%-- 検索結果レコードの表示処理。 --%>
      <c:forEach var="row" items="${rs.rows}">
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
			<BR>
      
      <INPUT type="submit" value="詳細" name="detail">

		</FORM> 
</p>
	</CENTER>
  <br>
  <br>
  <footer>
  	<p>© 1X21C064-8 Yuto Takahashi</p>
  </footer>


</BODY>
</HTML>
