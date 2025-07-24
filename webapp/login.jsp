<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" />

<%--  パラメータの取得(login.html で入力した文字列を取得し、変数 formMail と formPassword に格納する)  --%>
<c:set var="formCustomerMail" value="${param.Mail}" scope="session"/>
<c:set var="formPass" value="${param.Pass}"/>

<%--  データベースへのコネクションを取得  --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%--  入力値をデータベースと参照して認証する  --%>
<sql:query var="rs">
    SELECT PASSWORD FROM CUSTOMER_INFO WHERE MAIL=?;
    <sql:param value="${formCustomerMail}"/>
</sql:query>

<%--  検索結果(PASSWORD)を変数に入れる  --%>
<c:set var="dbPass" value="${rs.rows[0].PASSWORD}"/>

<%--  パスワードが一致していた場合は list.jsp に飛ばす  パスワードが一致していない場合は再度 error_login.html に飛ばす  --%>
<c:if test="${dbPass == formPass}">
	<script>
		location.href="relist.jsp";
	</script>
</c:if>
<c:if test="${dbPass != formPass}">
	<script>
		location.href="error_login.html";
	</script>
</c:if>