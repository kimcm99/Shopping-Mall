package boss.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boss.common.OpenAI;
import boss.common.Pinecone;
import boss.model.MainImage;
import boss.model.Product;
import boss.service.MasterProductService;

@Controller
public class MainController {

	@Autowired
	private MasterProductService service;

	/*
	 * 메인 페이지 이동 메소드
	 */
	@RequestMapping(value = "main.do")
	public String main(Model model, @RequestParam(value = "block", required = false, defaultValue = "1") String block)
			throws Exception {

		// 초기값 뿌려줌
		Map<String, MainImage> mainImageList = new HashMap<String, MainImage>();
		List<MainImage> mainImageList_db = service.selectMainProductList();

		// by hyesun
//		Collections.sort(mainImageList_db, new Comparator<MainImage>() {
//            @Override
//            public int compare(MainImage o1, MainImage o2) {
//                return o2.getPid() - o1.getPid();	//pid 기준으로 내림차순 정렬되게 함
//            }
//        });
		// by hyesun end

		if (mainImageList_db.size() > 0) { // 1개라도 구해옴.
			for (int i = 0; i < mainImageList_db.size(); i++) { // list size만큼 put

				// int s = Integer.parseInt(block);

				model.addAttribute("block" + (i + 1), i + 1);

				model.addAttribute("mainImageList" + (i+1), mainImageList_db.get(i));
			}
		}
		//model.addAttribute("block", block);

		// by hyesun
		Pinecone.getInstance();
		OpenAI.getInstance();
		// by hyesun end

		return "common/main";
	}

	/*
	 * 메인 이미지 수정 메소드
	 */
	@RequestMapping("masterImageUpdateForm.do")
	public String masterImageUpdateForm(String id, String block, Model model) {

		Product product = service.selectOne(id);

		String mainImage = product.getPimage();
		String mainPname = product.getPname();
		String mainContent = product.getPcontent();

		int bk = Integer.parseInt(block);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("block", bk);
		map.put("id", id);
		map.put("mainimage", mainImage);
		map.put("mainpname", mainPname);
		map.put("maincontent", mainContent);

		int result = service.updateMainImageInsert(map);

		model.addAttribute("block", block);

		return "redirect:/main.do";
	}
}
