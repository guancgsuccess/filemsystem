<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>角色列表页</title>
		<link rel="stylesheet" href="${path }/dist/css/bootstrap.min.css" />
		<script type="text/javascript" src="${path }/js/jquery-3.2.1.min.js" ></script>
		<script type="text/javascript" src="${path }/dist/js/bootstrap.min.js" ></script>
		<script type="text/javascript" src="${path }/js/layer/layer.js"></script>
	</head>
	<body>
		<!-- 加载页面顶部 -->
		<jsp:include page="/WEB-INF/jsp/include/header.jsp"></jsp:include>
		
		<div class="container">
			<ol class="breadcrumb">
				<li><a href="#">角色信息</a></li>
				<li><a href="#">2017</a></li>
				<li class="active">十月</li>
			</ol>
		</div>
		
		<!--查询开始-->
		<div class="container">
			<div>
				<form action="#" class="bs-example bs-example-form" role="form" method="post">
					<div class="row">
						<div class="col-md-3">
							<div class="input-group">
								<input type="text" id="roleName" name="roleName" value=""  placeholder="角色名称进行模糊查询" class="form-control"> 
								<span class="input-group-btn">
									<button class="btn btn-default" type="button" onclick="queryPage()">查询</button>
								</span>
							</div>
						</div>
						<div class="col-md-4">
							<button class="btn btn-danger" type="button" onclick="delRoles()">删除角色</button>
							<a href="${pageContext.request.contextPath }/sys/roleForm" class="btn btn-info">添加角色</a>
						</div>
					</div>
				</form>
			</div>
		</div>
		<!--查询结束-->
		
		<!--列表主体开始-->
		<div id="roleData"></div>
		<!--列表主体结束-->
		
		<!-- 加载页面底部 -->
		<jsp:include page="/WEB-INF/jsp/include/footer.jsp"></jsp:include>
	</body>
	<script type="text/javascript">
		//全选/反选
		function checkAllOrNot(){
			for(var i=0;i<$(".cks").length;i++){
				var flag = $(".cks:eq(" + i + ")").prop("checked");
				
				$(".cks:eq(" + i + ")").prop("checked",!flag);
			}
		}
		
		//删除
		function delFilms(){
			//询问框
			layer.confirm('确认删除吗？', {
			  btn: ['必须的','算了吧'] //按钮
			}, function(){
				var ids = "";
				for(var i=0;i<$(".cks:checked").length;i++){
					ids += $(".cks:checked:eq(" + i + ")").val() + ",";//1,2
				}
				ids = ids.substr(0,ids.length-1);
				
				$.ajax({
					url:"${pageContext.request.contextPath }/back/filmDel",
					data:{"ids":ids},
					type:"post",
					success:function(msg){
						//判断是否登陆成功
						if(msg == "success"){
							layer.msg("删除成功");
							window.location.href = "${pageContext.request.contextPath }/back/filmList";
							return;
						}else{
							return false;
						}
					}
				});
			}, function(){
			  layer.closeAll();
			});
		  }
		
		//加载数据 
		$(function(){
			$("#roleData").load("${pageContext.request.contextPath }/sys/role/getRoleData");
		})
		
		function queryPage(page){
			var index = layer.load(1, {shade: false});
			$("#roleData").load("${pageContext.request.contextPath }/sys/role/getRoleData",buildQuery(page),function(){
				layer.closeAll();
			});
		}
		
		function buildQuery(page){
			var query = {};
			query.page = typeof(page) == "undefined"?1:page;
			query.roleName = $("#roleName").val();
			return query;
		}
	</script>
</html>
