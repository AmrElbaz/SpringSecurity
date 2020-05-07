<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/7/2020
  Time: 3:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Home Page</title>
</head>
<body>
    <p>This is our main home page<p/>
    <hr>
<%--    Display username and role--%>
    <p>
        User: <security:authentication property="principal.username"/>
        <br><br>
        Role (s): <security:authentication property="principal.authorities"/>
    </p>
    <hr>

    <security:authorize access="hasRole('MANAGER')">
        <%--Add A link to point to /managers... this is for managers--%>
        <p>
            <a href="${pageContext.request.contextPath}/managers">LeaderShip Page</a>
            (Only for Managers)
        </p>

    </security:authorize>

    <security:authorize access="hasRole('ADMIN')">
        <%--Add A link to point to /admins... this is for admins--%>
        <p>
            <a href="${pageContext.request.contextPath}/admins">LeaderShip Page</a>
            (Only for Admins)
        </p>

    </security:authorize>

    <%--Add A link to point to /admins... this is for admins--%>
    <p>
        <a href="${pageContext.request.contextPath}/admins">for showing custom access denied page</a>
        (Only for Admins)
    </p>

    <hr>
<%--Add a logout button--%>
<form:form action="${pageContext.request.contextPath}/logout"
           method="post">
    <input type="submit" value="logout"/>
</form:form>

</body>
</html>
