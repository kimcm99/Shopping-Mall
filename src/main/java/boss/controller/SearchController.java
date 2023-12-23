package boss.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boss.common.PagePgm;
import boss.model.Product;
import boss.service.SearchService;

@Controller
public class SearchController {

	@Autowired
	SearchService ss;

	@RequestMapping("allSearch.do")
	public String allSearch(PagePgm pp, 
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, Model model) {
		
		
		if (nowPage == null && cntPerPage == null) {
			pp.setNowPage(1);
			pp.setCntPerPage(15);
		} else if (nowPage == null) {
			pp.setNowPage(1);
		} else if (cntPerPage == null) {
			pp.setCntPerPage(15);
		}else {
			pp.setNowPage(Integer.parseInt(nowPage));
			pp.setCntPerPage(Integer.parseInt(cntPerPage));
		}
		
		int total = ss.searchCount(pp.getKeyword());
		
		
		
		PagePgm pp1 = new PagePgm(total,pp.getNowPage(), pp.getCntPerPage(), pp);
		pp1.setKeyword(pp.getKeyword());
		
		List<Product> searchList = ss.allSearch(pp1);
		model.addAttribute("search", searchList);
		model.addAttribute("pp", pp1);
		
		return "./product/search";
}
	
}
