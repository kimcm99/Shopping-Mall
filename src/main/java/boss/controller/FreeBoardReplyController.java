package boss.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import boss.model.FreeBoard;
import boss.model.FreeReply;
import boss.service.FreeBoardReplyService;
import boss.service.FreeBoardService;

@Controller
public class FreeBoardReplyController {
	@Autowired
	private FreeBoardService fservice;

	@Autowired
	private FreeBoardReplyService frservice;

	// 댓글 목록 출력
	@RequestMapping("FreeReplyList.do")
	public String FreeReplyList(int fId, Model model) {
		FreeBoard detail = fservice.getDetail(fId); // 부모글 상세정보
		List<FreeReply> freplylist = frservice.freplylist(fId); // 댓글 목록
		
		//댓글수 (삭제된 댓글수출력됨 수정하기)
		int replycount=frservice.replyCount(fId);
		model.addAttribute("replycount", replycount);
		
		model.addAttribute("freplylist", freplylist);
		model.addAttribute("detail", detail);
		return "freeboard/freeboardReplyList";
	}
	
	//댓글 저장
	@RequestMapping("replyInsert.do")
	public String replyInsert(FreeReply frboard, Model model) {
		frservice.insert(frboard);
		return "redirect:FreeReplyList.do?fId="+frboard.getfId(); //fId:부모글의 글번호 
	}
	
	//댓글 삭제
	@RequestMapping("freereplyDelete.do")
	public String replyDelete(FreeReply frboard, Model model) {
		frservice.delete(frboard.getFrId()); //frId값으로만 삭제가능하지만 다시 돌아갈떄 fId값 필요  //frId : 댓글 글번호값 
		return "redirect:FreeReplyList.do?fId="+frboard.getfId(); //삭제후 다시돌아갈때 fId값을 전달시켜서 FreeReplyList로 요청(댓글목록) 
	}

	
	//댓글 수정 
	@RequestMapping("freereplyUpdate.do")
	public String freereplyUpdate(FreeReply frboard, Model model) {
		
		frservice.update(frboard);
		return "redirect:FreeReplyList.do?fId="+frboard.getfId();
	}

}