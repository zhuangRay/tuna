<%@ page pageEncoding="UTF-8"%>
		<!-- header.jsp start -->
		<style>
		h1{margin:0px;background-image: url(./images/bar-s.png);
		front-weight:bold;color:white;}	
		h1 a{color:white;}
		#searchForm{position: absolute;
        			top: 12px;
        			left: 380px;
        			border-radius:60px;
        			 }
        #searchFormSubmit{		
        					background-image:url(images/search_icon.png);
        					background-size:20px 20px;
        					background-position: 4% 50%;
        					background-repeat: no-repeat;
        					padding-left:30px;
        					height:30px;
        					
        					border-radius;
                          }			
		input[type="search"] {
						    border: 2px solid white;
						    border-radius: 10px; 
						    padding: 5px; 
						   }   			
        			
		</style>
		<header>
        <img id="tunaImg" src="images/tuna_logo2.png">
		<h1>
		<a href="<%=request.getContextPath() %>/">鮪魚鮮生</a>
		<sub> ${param.subheader}</sub>
		  
		</h1>
		<form id="searchForm" action="<%=request.getContextPath() %>/products_list.jsp" method="GET">
	  	  <input type="search" id="searchFormSubmit" name="keyword" required value="${parm.keyword}" placeholder="搜尋關鍵字">
		  
	    </form>	
	  
		</header>
		<!-- header.jsp end -->
