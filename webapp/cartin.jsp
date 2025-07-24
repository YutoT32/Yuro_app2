<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%--  データベースへのコネクションを取得  --%>
<sql:setDataSource driver="org.h2.Driver" url="jdbc:h2:sdev" />

<%-- データベースに保管 --%>
<sql:update var="cnt">
		INSERT INTO CART (MAIL, PRODUCT_CODE) VALUES(?, ?);	
		<sql:param value="${formCustomerMail}" />
		<sql:param value="${formProductCode}" />
</sql:update>
<script>
	location.href="relist.jsp";
</script>