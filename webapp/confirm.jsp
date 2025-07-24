<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--

  パラメータの取得

  confirm.html で入力した文字列を取得し、変数 formId と formPasscode に格納する

--%>
<fmt:requestEncoding value="utf-8" />

<c:set var="formId" value="${param.id}"/>
<c:set var="formPasscode" value="${param.passcode}"/>

<%--

  データベースへのコネクションを取得

--%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%--

  入力値をデータベースと参照して認証する。

--%>
<sql:query var="rs">
SELECT PASSCODE FROM CUSTOMER_INFO WHERE ID=?;
<sql:param value="${formId}"/>
</sql:query>

<%--

検索結果(PASSCODE)を変数に入れる

--%>
<c:set var="dbPasscode" value="${rs.rows[0].PASSCODE}"/>

<%--

パスワードが一致していた場合は list.jsp に飛ばす
パスワードが一致していない場合は再度 confirm.html に飛ばす

--%>

<c:if test="${dbPasscode == formPasscode}">
	<script>
		location.href="list.jsp";
	</script>
</c:if>
<c:if test="${dbPasscode != formPasscode}">
	<script>
		location.href="reconfirm.html";
	</script>
</c:if>
