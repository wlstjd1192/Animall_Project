package com.kh.animall.users.product.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.animall.users.product.model.service.ProductService;
import com.kh.animall.users.product.model.vo.Product;
import com.kh.animall.users.product.model.vo.ProductImage;
import com.kh.animall.users.product.model.vo.ProductListView;

@Controller
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	@RequestMapping("/product/productList.do")
	public String selectProductList(@RequestParam String ptype, Model model) {
	
		List<ProductListView> plist = new ArrayList<>();
		
		plist = productService.selectProductList(ptype);
		
		System.out.println("plist : " + plist);
		
		model.addAttribute("plist", plist);
		model.addAttribute("ptype", ptype);
		
		return "users/product/productList";
	}
	
	@RequestMapping("/product/productInsertForm.do")
	public String productInsertForm(@RequestParam String ptype, Model model) {
		System.out.println("ptype:" + ptype);
		model.addAttribute("ptype", ptype);
		return "users/product/productInsertForm";
	}
	
	
	@RequestMapping("/product/productFormEnd.do")
	public String insertProduct(Product product , Model model, HttpServletRequest req,
								@RequestParam(value="pimage", required=false) MultipartFile[] upFiles) {
		
		System.out.println("product-테스트 :" + product);
		System.out.println("ptype:" + product.getPtype());
		
		String saveDirectory = req.getServletContext().getRealPath("/resources/productUpFiles");
		
		String imgpath = saveDirectory + "/";
		
		List<ProductImage> imageList = new ArrayList<ProductImage>();
		
		for(MultipartFile f : upFiles) {
			
			if(f.isEmpty() != true) {
				
				String originName = f.getOriginalFilename();
				
				//확장자 추출
				String afterdot = originName.substring(originName.lastIndexOf(".") + 1);
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rnd = (int)(Math.random()*100);
				
				String changeName =
						sdf.format(new Date(System.currentTimeMillis())) + "_" + rnd + "." + afterdot;
				
				try {
					f.transferTo(new File(saveDirectory + "/" + changeName));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				ProductImage pi = new ProductImage();
				pi.setOriginname(originName);
				pi.setChangename(changeName);
				pi.setImgpath(imgpath);
			
				
				imageList.add(pi);
				
				
			}
			
		}
		
		int result = productService.insertProduct(product, imageList);
		
		System.out.println("result" + result);
		
		String loc = "/product/productList.do?ptype="+product.getPtype();
		String msg = "";
		
		if(result > 0) {
			msg = "상품 등록 완료";
		}
		else {
			msg = "상품 등록 실패";
		}
		
		model.addAttribute("loc",loc);
		model.addAttribute("msg",msg);
		
		
		return "common/msg";
	}
	
	@RequestMapping("/product/productSelectOne.do")
	public String productSelectOne(@RequestParam int pno, Model model) {
		
		Product product = productService.selectOneProduct(pno);
		
		System.out.println("selectOne에서의 product :" + product);
		
		List<ProductImage> imageList = productService.selectProductImageList(pno);
		
		System.out.println("imageList에서의 imageList : " + imageList);
		
		model.addAttribute("product", product);
		model.addAttribute("imageList", imageList);
		
		return "/users/product/productDetail";
	}
	
	@RequestMapping("/product/productGoUpdate.do")
	public String productGoUpdate(@RequestParam int pno, Model model) {
		Product product = productService.selectOneProduct(pno);
		System.out.println("productUpdate에서의 product : " + product);
		
		List<ProductImage> imageList = productService.selectProductImageList(pno);
		System.out.println("productUpdate에서의 imageList : " + imageList );
		
		
		model.addAttribute("product", product);
		model.addAttribute("imageList", imageList);
		return "users/product/productGoUpdate";
		
	}
	
	@RequestMapping("/product/productEndUpdate.do")
	public String productEndUpdate(Product product, Model model) {
		
		int pno = product.getPno();
		System.out.println("pno:"+pno);
		
		Product originProduct = productService.selectOneProduct(pno);
		System.out.println("originProduct : " + originProduct);
		
		originProduct.setPname(product.getPname());
		originProduct.setPcontent(product.getPcontent());
		originProduct.setPprice(product.getPprice());
		originProduct.setPguide(product.getPguide());
	
		int result = productService.updateProduct(originProduct);
		
		String loc = "/product/productSelectOne.do?pno="+pno;
		String msg = "";
		
		if(result > 0) {
			msg = "상품 수정 성공";
		}
		else {
			msg = "상품 수정 실패";
		}
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg", msg);
		
		return "common/msg";
	}
	
	
	
	@RequestMapping("/product/productDelete.do")
	public String productDelete(
								@RequestParam String ptype,
								@RequestParam int pno, 
								HttpServletRequest req,
								Model model) {

		System.out.println("RequestParam으로 받은 ptype :" + ptype);
		
		String saveDir = req.getServletContext().getRealPath("/resources/productUpFiles");
		
		List<ProductImage> deleteList = productService.selectProductImageList(pno);
		
		System.out.println("Delete에서의 imageList : " + deleteList);
		
		int result2 = productService.deleteProductImage(pno);
		int result1 = productService.deleteProduct(pno);
		
		String loc = "/product/productList.do?ptype="+ptype;
		String msg = "";
		
		if(result1 > 0 && result2 > 0) {
			msg = "제품 삭제 완료";
			
			for(ProductImage pi : deleteList) {
				new File(saveDir + "/" + pi.getChangename()).delete();
			}
		}
		else {
			msg = "제품 삭제 실패";
		}
		
		model.addAttribute("loc", loc);
		model.addAttribute("msg",msg);
		
		return "common/msg";
		
	}
}
