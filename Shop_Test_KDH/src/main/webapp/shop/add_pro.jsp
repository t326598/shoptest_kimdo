<%@page import="java.io.File"%>
<%@page import="shop.dto.Product"%>
<%@page import="shop.dto.User"%>
<%@page import="shop.dao.ProductRepository"%>
<%@page import="java.util.Iterator"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

DiskFileUpload upload = new DiskFileUpload();
/* String path = application.getRealPath("/userImg"); // 실제 경로 확인 */
String path = "C:\\UPLOAD";
/* String path = application.getRealPath("/webapp/static/fimg"); */

upload.setSizeMax(10 * 1000 * 1000); // 10MB - 파일 최대 크기
upload.setSizeThreshold(4 * 1024); // 4MB - 메모리상의 최대 크기

List<FileItem> items = upload.parseRequest(request);
Iterator<FileItem> params = items.iterator();


ProductRepository pr = new ProductRepository();


String paramCode = "";
String paramName = "";
String paramContent = "";
String paramMake = "";
String paramCategory = "";
int paramUnitsinstock = 0;
String paramStatus = "";
int paramPrice = 0;

User user = (User) session.getAttribute("loginUser");
Product pp = new Product();



while (params.hasNext()) {
	FileItem item = params.next();

	// 일반 데이터
	if (item.isFormField()) {
		String name = item.getFieldName();
		String value = item.getString("utf-8");

		if (name.equals("code")) {
	paramCode = value;
		} else if (name.equals("name")) {
	paramName = value;
		} else if (name.equals("content")) {
	paramContent = value;
		} else if (name.equals("make")) {
	paramMake = value;
		} else if (name.equals("price")) {
	paramPrice = Integer.parseInt(value);
		}else if (name.equals("category")) {
	paramCategory = value;
		}else if (name.equals("units_in_stock")) {
	paramUnitsinstock = Integer.parseInt(value);
		}else if (name.equals("status")) {
	paramStatus = value;
				}
	}
	// 파일 데이터
	else {
		String fileName = item.getName();


		// 경로 확인 및 디렉토리 생성
	
		if (fileName != null && !fileName.isEmpty()) {
			// 파일 이름에서 경로를 제외한 순수 파일 이름만 추출
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1);

			// 경로 확인 및 디렉토리 생성
			File dir = new File(path);
			if (!dir.exists()) {
				boolean created = dir.mkdirs();
				if (!created) {
					out.println("디렉토리 생성 실패: " + path);
					return; // 오류 발생 시 종료
				}
			}

			File file = new File(dir, fileName);
			pp.setFile(path + "/" + fileName); // 파일 경로를 Product 객체에 설정
			try {
				item.write(file); // 파일 저장
			} catch (Exception e) {
				out.println("파일 저장 실패: " + e.getMessage());
				return; // 오류 발생 시 종료
			}
		} else {
			// 파일이 없으면 경로를 설정하지 않음
			pp.setFile(null);
		}
	}
}
pp.setProductId(paramCode);
pp.setName(paramName);
pp.setUnitPrice(paramPrice);
pp.setDescription(paramContent);
pp.setManufacturer(paramMake);
pp.setCategory(paramCategory);
pp.setUnitsInStock(paramUnitsinstock);
pp.setCondition(paramStatus);
pp.setQuantity(0);


int result = pr.insert(pp);
String root = request.getContextPath();
if(result > 0){
	System.out.print("업로드 성공");
response.sendRedirect( "products.jsp");

}
else{
	out.print("<script>alert('제품 등록에 실패했습니다.'); history.back();</script>");
}

%>