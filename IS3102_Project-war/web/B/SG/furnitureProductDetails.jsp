<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="HelperClasses.Member"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="HelperClasses.Furniture"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="EntityManager.StoreEntity"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="checkCountry.jsp" />
<%
          String sku = request.getParameter("sku");
     
   
    if (sku == null) {
%>
<jsp:forward page="index.jsp" />
<%
    }
    Boolean isMemberLoggedIn = false;
    String memberEmail = (String) (session.getAttribute("memberEmail"));
    if (memberEmail == null) {
        isMemberLoggedIn = false;
    } else {
        isMemberLoggedIn = true;
    }
%>
<html> <!--<![endif]-->
    <jsp:include page="header.html" />
    <body>
        <%
            
            List<StoreEntity> storesInCountry = (List<StoreEntity>) session.getAttribute("storesInCountry");
            List<Furniture> furnitures = (List<Furniture>) (session.getAttribute("furnitures"));
                
         System.out.println("furniture size:" + furnitures.size());
            /*define your variables here*/ 
            /*set your variables here*/  
         
     
          for(int i=0; i < furnitures.size(); i+=1) { 
                 String input =furnitures.get(i).getSKU();
            if(sku.equals(input)){
     
int height= furnitures.get(i).getHeight();
int length= furnitures.get(i).getLength();
int width= furnitures.get(i).getWidth();
 String image =  furnitures.get(i).getImageUrl();
 String category = furnitures.get(i).getCategory();
  String description = furnitures.get(i).getDescription();
  double price = furnitures.get(i).getPrice();
 long id =furnitures.get(i).getId();
 String name = furnitures.get(i).getName();
   
            
%>
     
        
        <div class="body">
            <jsp:include page="menu2.jsp" />
            <div class="body">
                <div role="main" class="main">
                    <section class="page-top">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12">
                                    <h2>Furnitures</h2>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="container">   
                        <hr class="tall">
                        <div class="row">
                            <div class="col-md-6">
                                <div>
                                    <div class="thumbnail">
                                        <img alt="" class="img-responsive img-rounded" src="../../..<%=image%>">
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="summary entry-summary">
                                    <h2 class="shorter"><strong><%=name%></strong></h2>
                                    <%
                                        if (isMemberLoggedIn == true) {
                                    %>
                                    <form action="../../ECommerce_AddFurnitureToListServlet">
                                        <input type="hidden" name="id" value="<%=id%>"/>
                                        <input type="hidden" name="SKU" value="<%=sku%>"/>
                                        <input type="hidden" name="price" value="<%=price%>"/>
                                        <input type="hidden" name="name" value="<%=name%>"/>
                                        <input type="hidden" name="imageURL" value="<%=image%>"/>
                                        <input type="submit" name="btnEdit" class="btn btn-primary" id="<%/*insert code here*/%>" value="Add To Cart"/>
                                    </form>
                                    <%}%>
                                    <p class="price"><h4 class="amount">$<%=price%>0</h4></p>
                                    <strong>Description</strong>
                                    <p class="taller">
                                        <%=description%>
                                    </p>
                                    <p>
                                        Height: <%=height%><br/>
                                        Length: <%=length%><br/>
                                        Width: <%=width%>
                                    </p>
                                    <div class="product_meta">
                                        <span class="posted_in">Category: <a rel="tag" href="../../ECommerce_FurnitureCategoryServlet?cat=<%=category%>"><%=category%></a></span>
                                    </div>
                                    <br/><br/>
     <% 

} else{
}
}
%>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <form action="../../ECommerce_StockAvailability">
                                                View Item Availability<br/>
                                                <select style="color: black;" name="storeID">
                                                    <option> </option>
                                                    <%String storeIDstring = (request.getParameter("storeID"));
                                                        Long storeID = 1L;
                                                        if (storeIDstring != null) {
                                                            storeID = Long.parseLong(storeIDstring);
                                                        }
                                                        for (int i = 0; i < storesInCountry.size(); i++) {
                                                            if (!storesInCountry.get(i).getId().equals(storeID)) {%>
                                                    <option value="<%=storesInCountry.get(i).getId()%>"><%=storesInCountry.get(i).getName()%></option>
                                                    <%} else {%>
                                                    <option selected value="<%=storesInCountry.get(i).getId()%>"><%=storesInCountry.get(i).getName()%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select><br/><br/>
                                                <input type="submit" class="btn btn-primary btn-icon" value="Check Item Availability"/>
                                                <input type="hidden" name="sku" value="<%=sku%>"/>
                                                <input type="hidden" name="type" value="Furniture"/>
                                            </form>
                                        </div>
                                        <%
                                            String itemQty = (String) (request.getParameter("itemQty"));
                                            if (itemQty != null) {
                                        %>
                                        <div class="col-md-6">
                                            Status: <%if (Integer.parseInt(itemQty) > 0) {%>Available<%} else {%>Unavailable<%}%>
                                            <br/>
                                            Remaining Qty: <%=itemQty%>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <hr class="tall">
                        </div>
                                      
                    </div>
                </div>
                <jsp:include page="footer.html" />
            </div>

    </body>
</html>
