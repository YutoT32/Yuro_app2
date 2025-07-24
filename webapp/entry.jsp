<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" />

<%--  パラメータの取得(entry.html で入力した文字列を取得し、変数に格納する)  --%>
<c:set var="formName_sei" value="${param.name_sei}"/>
<c:set var="formName_mei" value="${param.name_mei}"/>
<c:set var="formFuri_sei" value="${param.furi_sei}"/>
<c:set var="formFuri_mei" value="${param.furi_mei}"/>
<c:set var="formComname" value="${param.comname}"/>
<c:set var="formAddress" value="${param.address}"/>
<c:set var="formPhone" value="${param.phone}"/>
<c:set var="formMail" value="${param.mail}"/>
<c:set var="formPass" value="${param.pass}"/>
<c:set var="formBirth_year" value="${param.birth_year}"/>
<c:set var="formBirth_month" value="${param.birth_month}"/>
<c:set var="formBirth_day" value="${param.birth_day}"/>

<%-- 入力合否 --%>
<c:choose>
<c:when test="${empty formMail}">
	<html>
		<head>
			<meta http-equiv="refresh" content="3;URL=entry.html">
			<title>オリジナル-ログイン認証-</title>
		</head>
		<body>
			入力不足があります。３秒後に入力画面に戻ります。
		</body>
	</html>
</c:when>
<c:when test="${empty formPass}">
	<html>
		<head>
			<meta http-equiv="refresh" content="3;URL=entry.jsp">
			<title>オリジナル-ログイン認証-</title>
		</head>
		<body>
			入力不足があります。３秒後に入力画面に戻ります。
		</body>
	</html>
</c:when>
<c:otherwise>
	<%--  データベースへのコネクションを取得  --%>
	<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

	<%--  入力値をデータベースに追加する  --%>
	<sql:update var="cnt">
		INSERT INTO CUSTOMER_INFO (NAME_SEI, NAME_MEI, HURI_SEI, HURI_MEI, SHAMEI, ADDRESS, PHONE, PASSWORD, BIRTH_YEAR, BIRTH_MONTH, BIRTH_DAY, MAIL) 
		VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);	
		<sql:param value="${formName_sei}" />
		<sql:param value="${formName_mei}" />
		<sql:param value="${formFuri_sei}" />
		<sql:param value="${formFuri_mei}" />
		<sql:param value="${formComname}" />
		<sql:param value="${formAddress}" />
		<sql:param value="${formPhone}" />
		<sql:param value="${formPass}" />
		<sql:param value="${formBirth_year}" />
		<sql:param value="${formBirth_month}" />
		<sql:param value="${formBirth_day}" />
		<sql:param value="${formMail}" />
	</sql:update>

	<script>
		location.href="login.html";
	</script>
</c:otherwise>
</c:choose>





