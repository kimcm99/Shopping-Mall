package boss.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import boss.model.AskBoard;
import boss.model.AskReply;
import boss.model.Member;
import boss.model.Product;
import boss.service.ProductAskBoardService;

@Controller
public class ProductAskBoardController {

	@Autowired
	private ProductAskBoardService service;

	// 문의 작성 페이지로 이동
	@RequestMapping("productAskBoardInsertForm.do")
	public String productAskBoardInsertForm(Model model, String pid, HttpSession session) {

		// 세션 불러오기
		Member member = (Member) session.getAttribute("member");

		String mEmail = member.getmEmail();
		System.out.println("세션 이메일 :" + mEmail);

		model.addAttribute("pid", pid);
		model.addAttribute("mEmail", mEmail);

		return "./product/askBoard/productAskBoardInsertForm";
	}

	// 문의 insert
	@RequestMapping("productAskBoardInsertCheck.do")
	public String productAskBoardInsertCheck(Model model, String pid, HttpSession session, AskBoard askboard) {
		System.out.println("productAskBoardInsertCheck 여기는 왔따.");

		int result = 0;

		Member member = (Member) session.getAttribute("member");
		String mEmail = member.getmEmail();

		result = service.askinsert(askboard);

		model.addAttribute("mEmail", mEmail);
		model.addAttribute("result", result);
		model.addAttribute("pid", pid);

		return "./product/askBoard/productAskBoardInsertCheck";
	}

	// 문의상세 폼 이동
	@RequestMapping("productAskBoardSelectForm.do")
	public String productAskBoardSelectForm(Model model, AskBoard askboard, int pid, HttpSession session, int askid,AskReply askreply) {
		System.out.println("productAskBoardSelectForm:" + "문의 상세 들어왔찌");
		
		askboard = service.askselect(askboard.getAskid());
		
		// 문의 댓글 불러오기
		askreply = service.arselect(askreply.getAskid());
		System.out.println(askreply);

		model.addAttribute("askboard", askboard);
		model.addAttribute("askreply", askreply);
	
		return "./product/askBoard/productAskBoardSelectForm";
	}

	// 문의 수정폼 이동
	@RequestMapping("productAskBoardUpdateForm.do")
	public String productAskBoardUpdateForm(Model model, int askid, int pid, AskBoard askboard) {
		System.out.println("productAskBoardUpdateForm:" + "문의 수정폼 이동");

		System.out.println("askboard : " + askboard);

		askboard = service.askselect(askboard.getAskid());

		model.addAttribute("askboard", askboard);
		return "./product/askBoard/productAskBoardUpdateForm";
	}

	// 문의 수정
	@RequestMapping("productAskBoardUpdateCheck.do")
	public String productAskBoardUpdateCheck(Model model, String askcontent, int askid) {
		System.out.println("productAskBoardUpdateCheck");

		int result = 0;
		
		AskBoard asb = service.askselect(askid);
		
		asb.setAskcontent(askcontent);
		
		result = service.askboardupdate(asb);

		System.out.println(result);

		model.addAttribute("result", result);
		model.addAttribute("askboard", asb);

		return "./product/askBoard/productAskBoardUpdateCheck";
	}
	
	// 문의 삭제
	@ResponseBody
	@RequestMapping("productAskBoardDeleteCheck.do")
	public String productAskBoardDeleteCheck(String askid) {
		
		System.out.println(askid);
		
		int result = service.askdelete(askid);
		
		System.out.println("result 삭제 확인 : " + result);
		
		if(result == 1) {
			return "Y";
		}else {
			return "N";
		}
	}
	

	
	
}
