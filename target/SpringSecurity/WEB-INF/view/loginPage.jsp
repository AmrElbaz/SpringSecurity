<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/7/2020
  Time: 4:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Custom Login Page</title>
</head>
<body>
<h3>My Custom Login Page</h3>
    <form:form action="${pageContext.request.contextPath}/authenticateTheUser" method="post">
<%--        Check For login error--%>
        <c:if test="${param.error != null}">
            <i>Sorry! you entered invalid userName/password</i>
        </c:if>
        
        <p>
            User name: <input type="text" name="username"/>
        </p>

        <p>
            Password: <input type="password" name="password"/>
        </p>
        <input type="submit" value="login"/>
    </form:form>
</body>
</html>
