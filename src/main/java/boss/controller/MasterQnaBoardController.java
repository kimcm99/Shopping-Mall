package boss.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.QnaBoard;
import boss.model.QnaReply;
import boss.service.MasterQnaBoardService;

@Controller
public class MasterQnaBoardController {

	@Autowired
	MasterQnaBoardService service;

	/*
	 * qna게시판 이동 메소드 + 페이징 처리
	 */
	@RequestMapping("masterQnaBoardList.do")
	public String masterQnaBoardList(PagePgm page, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) throws Exception {
		System.out.println("masterQnaBoardList");

		int total = service.totalQnaCount();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}
		System.out.println("nowPage" + nowPage);
		System.out.println("cntPerPage" + cntPerPage);
		System.out.println("nowPage" + nowPage);
		System.out.println("nowPage" + nowPage);
		System.out.println("nowPage");
		System.out.println("nowPage");
		System.out.println("nowPage");

		System.out.println(total + "개");

		page = new PagePgm(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		// 페이징 처리된 리스트
		List<QnaBoard> list = service.selectQnaBoardList(page);

		model.addAttribute("page", page);
		model.addAttribute("list", list);

		return "./master/qnaBoard/masterQnaBoardList";
	}

	/*
	 * qna 상세보기 페이지 이동 메소드
	 */
	@RequestMapping("masterQnaBoardDetail.do")
	public String masterQnaBoardDetail(PagePgm page, String qid, Model model) {
		System.out.println("masterQnaBoardDetail");
		System.out.println("qid : " + qid);

		int id = Integer.parseInt(qid);

		QnaBoard qnaBoard = service.selectQnaDetail(id);

		System.out.println("id : " + id);
		QnaReply qnaReply = service.selectReplyOne(id);

		model.addAttribute("qnaBoard", qnaBoard);
		model.addAttribute("qnaReply", qnaReply);
		model.addAttribute("page", page);

		return "master/qnaBoard/masterQnaBoardDetailForm";
	}

	/*
	 * qna게시글 댓글 인서트
	 */
	@RequestMapping("masterQnaReplyInsert.do")
	public String masterQnaReplyInsert(PagePgm page, Model model, HttpServletRequest request,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPage", required = false) String cntPerPage) {

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}

		int totalQnaCount = service.totalQnaCount();

		page = new PagePgm(totalQnaCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		System.out.println("masterQnaReplyInsert");
		System.out.println("qid22 : " + request.getParameter("qid"));
		int id = Integer.parseInt(request.getParameter("qid"));
		String memail = request.getParameter("memail");
		String qrcontent = request.getParameter("qrcontent");

		System.out.println("qid : " + id);
		System.out.println("memail : " + memail);
		System.out.println("qrcontent : " + qrcontent);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("memail", memail);
		map.put("qrcontent", qrcontent);
		List<QnaBoard> list = service.selectQnaBoardList(page);

		// 댓글 저장
		int inset = service.insertReply(map);
		// qnaBoard 답변 상태 'Y'변겅
		int update = service.updateQnaBoardReplyYn(id);
		System.out.println("update성공 : " + update);

		System.out.println("여기까지옴?");
		// QnaReply qnaReply = service.selectReplyOne(id);

		model.addAttribute("id", id);
		// model.addAttribute("memail", memail);
		model.addAttribute("qrcontent", qrcontent);
		// model.addAttribute("qnaReply", qnaReply);
		model.addAttribute("page", page);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("cntPerPage", cntPerPage);
		model.addAttribute("list", list);

		return "redirect:/masterQnaBoardList.do";
	}

	/*
	 * qna답글 수정 메소드
	 */
	@RequestMapping("masterQnaBoardUpdate.do")
	public String masterQnaBoardUpdate(String qid, String qrcontent, Model model) {

		int id = Integer.parseInt(qid);

		QnaReply qnaReply = service.selectReplyOne(id);
		System.out.println(qnaReply.getQrid());
		System.out.println(qnaReply.getQrcontent());

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("qrcontent", qrcontent);

		int result = service.updateQnaReply(map);

		return "redirect:/masterQnaBoardList.do";
	}

	/*
	 * qna게시글 검색 메소드
	 */
	@RequestMapping("masterQnaBoardSearch.do")
	public String masterQnaBoardSearch(Search search, Model model) {

		System.out.println(search.getKeyword());
		System.out.println(search.getSearchtype());

		if (search.getSearchtype().equals("qnayn")) {
			search.setKeyword(search.getKeyword().toUpperCase());
		}

		if (search.getKeyword() != "" && search.getSearchtype() != "") {
			List<QnaBoard> list = service.searchQnaList(search);
			System.out.println(list);
			model.addAttribute("list", list);
			model.addAttribute("search", "search");
			// return "./master/product/masterProductList";
		}
		if (search.getKeyword() == "" && search.getSearchtype() != "") {
			model.addAttribute("type", "notKey");
			model.addAttribute("msg", "검색어를 입력해 주세요.");
			return "./master/product/masterMoveProductList";
		}
		if (search.getKeyword() != "" && search.getSearchtype() == "") {
			model.addAttribute("type", "notType");
			model.addAttribute("msg", "검색타입을 선택해 주세요.");
			return "./master/product/masterMoveProductList";
		}
		if (search.getKeyword() == "" && search.getSearchtype() == "") {
			model.addAttribute("type", "notKeynotType");
			model.addAttribute("msg", "검색타입 & 검색어를 입력해 주세요.");
			return "./master/product/masterMoveProductList";
		}

		return "./master/qnaBoard/masterQnaBoardList";
	}

	// 관리자 QNA 삭제
	@RequestMapping("masterQnaBoardDelete.do")
	public String masterQnaBoardDelete(String id, Model model, HttpServletRequest request) {
		System.out.println("masterQnaBoardDelete");

		// Service에서 메소드를 1번만 호출하기 위해 리스트로 양식을 통일했음.
		List<String> idList = new ArrayList<String>();
		String[] ids = request.getParameterValues("chkId");

		int result = 0;
		String msg = "";
		// id값이 1개라도 넘어온다면 (복수허용)

		if ((id != null) || (request.getParameterValues("chkId") != null)) { // 요청받는 방식을 나누는 조건문. 체크박스 / 버튼
			if (id != null) { // id가 버튼으로 넘어온 경우. (단일, 다중 동일메서드 처리를 위해 List로 양식을 통일했음.)
				System.out.println("id가 버튼으로 1개만 넘어옴.");
				idList.add(0, id);
				result = service.deleteQna(idList);
				model.addAttribute("result", result);
				model.addAttribute("msg", +result + "개 수정 완료");
				System.out.println("1개만 삭제완료. : " + result);

			} else if (id == null && ids != null) { // id가 체크박스를 통해 넘어온경우.
				System.out.println("id가 체크박스로 1개 or 여러개 넘어옴.");
				System.out.println("체크박스로 넘어온 ID의 갯수 : " + ids.length);
				idList = Arrays.asList(ids);
				result = service.deleteQna(idList);
				model.addAttribute("result", result);
				model.addAttribute("msg", +result + "개 수정 완료");
				System.out.println("여러명 삭제 완료 : " + result);
			}
		} else { // 모든값이 Null이라면.
			model.addAttribute("result", result);
			model.addAttribute("msg", "수정할 글을 선택하세요.");
			System.out.println("체크박스가 선택되지않음. " + result);

		}
		return "master/qnaBoard/masterQnaBoardDelete";
	}

}