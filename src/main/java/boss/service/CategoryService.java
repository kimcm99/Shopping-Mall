package boss.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.CategoryDao;
import boss.model.Category;
import boss.model.Product;

@Service
public class CategoryService {

	@Autowired
	CategoryDao dao;
	
	//해당 카테고리의 상품 총 갯수
	public int categoryCount(String cid) {

		return dao.categoryCount(cid);
	}

	//해당 카테고리의 상품 list 전송
	public List<Product> categoryList(Category c) {
		System.out.println("서비스");
		return dao.categoryList(c);
	}

	public List<Product> categorySearch(Category c) {

		return dao.categorySearch(c);
	}

	public int categorySearchCount(Category c) {

		return dao.categorySearchCount(c);
	}

	public List<String> selectcid() {

		return dao.selectcid();
	}

	public Product samplecategory(String cid) {

		return dao.samplecategory(cid);
	}
	
	
	
	
	
}
