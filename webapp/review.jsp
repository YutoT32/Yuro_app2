<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--

  データベースへのコネクションを取得

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<fmt:requestEncoding value="utf-8" />
<%-- リンクで渡されたパラメータを、変数 formCode に格納する --%>
<%-- (1) --%>
<c:set var="formCode" value="${param.productCode}"/>

<%--

  口コミテーブルからのデータの取得

  [PRODUCT_REVIEW]テーブルから前ページで選択したリンクと一致する商品の
  [COMMENT],[SCORE]を検索するSQL文

--%>
<sql:query var="rs">
<%-- (2) --%>
SELECT COMMENT, SCORE
FROM PRODUCT_REVIEW
WHERE PRODUCT_CODE=?;
<sql:param value="${formCode}"/>
</sql:query>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<TITLE>口コミ</TITLE>
<%--

  表示方法の設定

--%>
<STYLE type="text/css">
body {background-color:white;}
table {border-collapse:separate; border-spacing:2px; width:100%;}
th {background-color:#333333; text-align:center; font-size:large; font-weight:bold; color:white;}
td {background-color:#EFEFEF; font-size:normal; color:black;}
</STYLE>
</head>
<BODY bgcolor="#FFFFFF">
	<CENTER>
		<H2>レビュー一覧</H2>

商品コード：${formCode}

		<TABLE>
			<TR>
				<TH>口コミ</TH>
				<TH>採点</TH>
			</TR>

<c:forEach var="row" items="${rs.rows}">

  <TR>
    <%-- (3) --%>
	<TD>${row.COMMENT}</TD>
	<TD>${row.SCORE}</TD>
  </TR>

</c:forEach>

		</TABLE>

	</CENTER>
</BODY>
</html>
