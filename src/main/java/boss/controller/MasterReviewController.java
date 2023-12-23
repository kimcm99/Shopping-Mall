package boss.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Review;
import boss.service.MasterReviewService;

@Controller
public class MasterReviewController {

	@Autowired
	private MasterReviewService ms;

	// 관리자 리뷰리스트
	@RequestMapping("masterReviewList.do")
	public String masterReviewList(PagePgm pp, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, String search) throws Exception {
		System.out.println("masterReviewList");

		int total = ms.total();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		pp = new PagePgm(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("pp", pp);
		model.addAttribute("list", ms.list(pp));
		return "./master/review/masterReviewList";
	}

	// 관리자 리뷰 상세정보
	@RequestMapping("masterReviewSelect.do")
	public String masterReviewSelect(String rid, Model model) {
		System.out.println("masterReviewSelect");
		System.out.println(rid);
		Review review = ms.selectOne(rid);
		System.out.println("review : " + review);
		model.addAttribute("review", review);

		return "./master/review/masterReviewSelect";
	}

	// 관리자 리뷰 삭제
	@RequestMapping("masterReviewDelete.do")
	public String masterReviewDelete(String rid, Model model, HttpServletRequest request) {
		System.out.println("masterMemberDelete");
		System.out.println("rid : " + rid);
		// Service에서 메소드를 1번만 호출하기 위해 리스트로 양식을 통일했음.
		List<String> idList = new ArrayList<String>();
		String[] ids = request.getParameterValues("chkId");

		int result = 0;
		String msg = "";
		// id값이 1개라도 넘어온다면 (복수허용)

		if ((rid != null) || (request.getParameterValues("chkId") != null)) { // 요청받는 방식을 나누는 조건문. 체크박스 / 버튼
			if (rid != null) { // id가 버튼으로 넘어온 경우. (단일, 다중 동일메서드 처리를 위해 List로 양식을 통일했음.)
				System.out.println("id가 버튼으로 1개만 넘어옴.");
				idList.add(0, rid);
				result = ms.deleteReview(idList);
				model.addAttribute("result", result);
				model.addAttribute("msg", +result + "개 수정 완료");
				System.out.println("1개만 삭제완료. : " + result);

			} else if (rid == null && ids != null) { // id가 체크박스를 통해 넘어온경우.
				System.out.println("id가 체크박스로 1개 or 여러개 넘어옴.");
				System.out.println("체크박스로 넘어온 ID의 갯수 : " + ids.length);
				idList = Arrays.asList(ids);
				result = ms.deleteReview(idList);
				model.addAttribute("result", result);
				model.addAttribute("msg", +result + "개 수정 완료");
				System.out.println("여러명 삭제 완료 : " + result);
				}
			}else { // 모든값이 Null이라면.
			model.addAttribute("result", result);
			model.addAttribute("msg", "수정할 글을 선택하세요.");
			System.out.println("체크박스가 선택되지않음. " + result);
			}
		return "./master/review/masterReviewDelete";
	}

	
	// 리뷰 유형별 검색
	@RequestMapping("masterReviewSearch.do")
	public String masterReviewSearch(Search search, Model model) {
		
		System.out.println(search.getKeyword());
		System.out.println(search.getSearchtype());
		
		if(search.getKeyword() != "" && search.getSearchtype() != "") {
			List<Review> list = ms.searchReviewList(search);
			System.out.println(list);
			model.addAttribute("list", list);
			model.addAttribute("search", "search");
		}
		if(search.getKeyword() == "" && search.getSearchtype() != "") {
			model.addAttribute("type", "notKey");
			model.addAttribute("msg", "검색어를 입력해 주세요.");
			return "./master/product/masterMoveProductList";
		}
		if(search.getKeyword() != "" && search.getSearchtype() == "") {
			model.addAttribute("type", "notType");
			model.addAttribute("msg", "검색타입을 선택해 주세요.");
			return "./master/product/masterMoveProductList";
		}
		if(search.getKeyword() == "" && search.getSearchtype() == "") {
			model.addAttribute("type", "notKeynotType");
			model.addAttribute("msg", "검색타입 & 검색어를 입력해 주세요.");
			return "./master/product/masterMoveProductList";
		}
		
		return "./master/review/masterReviewList";
	}
}

























