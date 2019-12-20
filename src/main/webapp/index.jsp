<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="org.jasig.cas.client.authentication.AttributePrincipal" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CAS Client 1</title>
</head>
<body>

<h1>CAS Client 1</h1>
<p>
    请注意！下方的客户端连接以及退出链接需要根据自己的服务端及客户端部署环境信息自行调整。
</p>
<h2><a href="http://127.0.0.1:9001/cas-client-1/index.jsp">客户端1</a></h2>
<h2><a href="http://127.0.0.1:9002/cas-client-2/index.jsp">客户端2</a></h2>
<h2><a href="http://127.0.0.1:8080/com.jorian.blog/login.html">宁波大运河本地</a></h2>
<h2><a href="http://127.0.0.1:8081/cas/logout?service=http://127.0.0.1:9001/cas-client-1/index.jsp">登出</a></h2>
<p>A sample web application that exercises the CAS protocol features via the Java CAS Client.</p>
<hr>

<p><b>Authenticated User Id:</b> <a href="logout.jsp" title="Click here to log out"><%= request.getRemoteUser() %>
</a></p>

<%
    if (request.getUserPrincipal() != null) {
        AttributePrincipal principal = (AttributePrincipal) request.getUserPrincipal();

        final Map attributes = principal.getAttributes();

        if (attributes != null) {
            Iterator attributeNames = attributes.keySet().iterator();
            out.println("<b>Attributes:</b>");

            if (attributeNames.hasNext()) {
                out.println("<hr><table border='3pt' width='100%'>");
                out.println("<th colspan='2'>Attributes</th>");
                out.println("<tr><td><b>Key</b></td><td><b>Value</b></td></tr>");

                for (; attributeNames.hasNext(); ) {
                    out.println("<tr><td>");
                    String attributeName = (String) attributeNames.next();
                    out.println(attributeName);
                    out.println("</td><td>");
                    final Object attributeValue = attributes.get(attributeName);

                    if (attributeValue instanceof List) {
                        final List values = (List) attributeValue;
                        out.println("<strong>Multi-valued attribute: " + values.size() + "</strong>");
                        out.println("<ul>");
                        for (Object value : values) {
                            out.println("<li>" + value + "</li>");
                        }
                        out.println("</ul>");
                    } else {
                        out.println(attributeValue);
                    }
                    out.println("</td></tr>");
                }
                out.println("</table>");
            } else {
                out.print("No attributes are supplied by the CAS server.</p>");
            }
        } else {
            out.println("<pre>The attribute map is empty. Review your CAS filter configurations.</pre>");
        }
    } else {
        out.println("<pre>The user principal is empty from the request object. Review the wrapper filter configuration.</pre>");
    }
%>

</body>
</html>
