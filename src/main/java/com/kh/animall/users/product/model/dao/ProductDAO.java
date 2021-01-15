package com.kh.animall.users.product.model.dao;


import java.util.ArrayList;
import java.util.List;

import com.kh.animall.users.product.model.vo.Product;
import com.kh.animall.users.product.model.vo.ProductImage;
import com.kh.animall.users.product.model.vo.ProductListView;

public interface ProductDAO {
	
	List<ProductListView> selectProductList(String ptype);
	
	int insertProduct(Product product);

	int insertProductImage(ProductImage pi);

	Product selectOneProduct(int pno);

	List<ProductImage> selectProductImageList(int pno);

	int deleteProduct(int pno);

	int deleteProductImage(int pno);

	int updateProduct(Product originProduct);
	
}
