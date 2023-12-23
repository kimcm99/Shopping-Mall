package boss.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Category;
import boss.model.Product;
import boss.service.CategoryService;

@Controller
public class CategoryController {
	
	@Autowired
	CategoryService cs;
	
		// 상품 리스트로 이동 이동
		@RequestMapping("category.do")
		public String category(PagePgm pp, Model model, Category c,
				@RequestParam(value = "nowPage", required = false) String nowPage,
				@RequestParam(value = "cntPerPage", required = false) String cntPerPage, String search) throws Exception {
			
			if(c.getNewCid() == null) {
				List<String> clist = cs.selectcid();
				List<Product> sample = new ArrayList<Product>();
				
				for (String cid : clist) {
					sample.add(cs.samplecategory(cid));
		        }
				
				model.addAttribute("clist",clist);
				model.addAttribute("sample",sample);
				
				
				return "./category/sampleList";
				
			}
			int categoryCount = cs.categoryCount(c.getNewCid());
			//해당 카테고리의 상품 갯수를 검색
			
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "15";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "15";
			}
			
			//1.페이징처리를 위한 값들을 전송 후 거기서 파생된 변수들을 Category DTO에 저장. 
			pp = new PagePgm(categoryCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			
			model.addAttribute("pp", pp);  //상품 갯수, 현재페이지번호, 한 페이지에 출력될 번호를 공유
			c.setNewStartRow(pp.getStartRow());
			c.setNewEndRow(pp.getEndRow());
			List<Product> list = cs.categoryList(c);
			if(list != null) {
				model.addAttribute("list", list);
			}else {
				model.addAttribute("list", "상품이 없습니다");
			}
			model.addAttribute("cid",c.getNewCid());
			model.addAttribute("category",c);
			//cid로 찾아낸 해당 카테고리 상품 목록을 페이징 처리하여 공유
			
			
			int sum = 0;
		
			
			
			return "./category/categoryList";
		}
		
		//검색 리스트로 이동
		@RequestMapping("categorySearch.do")
		public String categorySearch(PagePgm pp, Model model, Category c,
				@RequestParam(value = "nowPage", required = false) String nowPage,
				@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
			
			int categorySearchCount = cs.categorySearchCount(c);
			//카테고리 내에서 해당 검색어를 가진 상품의 갯수를 파악
			
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "15";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "15";
			}
			
			//1.페이징처리를 위한 값들을 전송 후 거기서 파생된 변수들을 Category DTO에 저장. 
			pp = new PagePgm(categorySearchCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
			
			c.setNewStartRow(pp.getStartRow());
			c.setNewEndRow(pp.getEndRow());
			
			model.addAttribute("pp", pp);  //상품 갯수, 현재페이지번호, 한 페이지에 출력될 번호를 공유
			List<Product> list = cs.categorySearch(c);
			
			model.addAttribute("list", list);
			model.addAttribute("cid",c.getNewCid());
			model.addAttribute("category",c);
			//cid로 찾아낸 해당 카테고리 상품 목록을 페이징 처리하여 공유
			return "./category/categorySearch";
		}

}
