package boss.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import boss.common.PagePgm;
import boss.model.AskBoard;
import boss.model.Member;
import boss.model.OrderDetail;
import boss.model.Orders;
import boss.model.Product;
import boss.model.QnaBoard;
import boss.model.QnaReply;
import boss.model.Report;
import boss.model.Review;
import boss.service.MasterOrdersService;
import boss.service.MasterProductService;
import boss.service.MypageService;

@Controller
public class MypageController {

	@Autowired
	private MypageService service;
	
	// 마이페이지 이동


	@RequestMapping("mypage.do")
	public String doMypage(HttpSession session, Model model) {
		System.out.println("마이 페이지 이동");

		Member member = (Member) session.getAttribute("member");

		List<Orders> orders = service.myoders(member.getmEmail()); // 내 주문내역 구해오기 -> 문제 list 로 받아와야함
		int totalcount = 0;
		// 주문 한 내역이 있다면
		if (orders != null) {      // 주문번호가 있다면.
	        model.addAttribute("orders", orders);
		}
		
		return "login/mypage";
	}
	
	// 주문내역
	@RequestMapping("mypageOrderDetail.do")
	public String mypageOrderDetail(String oid,HttpSession session,Model model) {
		
		Member member = (Member) session.getAttribute("member");
		
		String mEmail = member.getmEmail();
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("mEmail", mEmail);
		map.put("oid", oid);

		List<Orders> orders = service.myoders(member.getmEmail()); // 내 주문내역 구해오기

		List<HashMap<String, Object>> ordersList = new ArrayList<>();
		
		//int oid = Integer.parseInt(oid)
		
		// 주문 한 내역이 있다면
		if (orders != null) { // 주문번호가 있다면.
			System.out.println("주문 번호가 있다면??");
			
			// 이제 주문 상세를 뽑아올 수 있어야해

			ordersList = service.listProduct(map);

			// 모든정보의 List
			model.addAttribute("ordersList", ordersList);
			System.out.println("ordersList.size() : " + ordersList.size());

			// 메세지 넣을 배열을 주문 갯수만큼 빼오기
			String statusMsg[] = new String[ordersList.size()]; // 주문 갯수

			// 배송상태 처리
			for (int i = 0; i < ordersList.size(); i++) {
				HashMap<String, Object> orderstatus = ordersList.get(i); // 개별 주문 구해오기

				Object odStatusValue = orderstatus.get("ODSTATUS");

				int odstatus = ((Number) odStatusValue).intValue();
				statusMsg[i] = service.statusMsg(odstatus);

				System.out.println("배송 상태 : " + statusMsg[i] + odstatus);
			}

			// 배송처리 한 메세지 model로 뿌리기
			model.addAttribute("statusMsg", statusMsg);

			// 단일정보 (뷰에서 쓰기쉽게 foreach안돌려도됨)
			model.addAttribute("orders", ordersList.get(0));
			System.out.println(ordersList.get(0));
		}
		return "login/mypage/mypageOrderDetail";
	}
	
	// 리뷰 페이지 이동
	@RequestMapping("mypageReview.do")
	public String mypageReview(HttpSession session, Model model) {

		// 세션 얻어오기
		Member member = (Member) session.getAttribute("member");
		String mEmail = member.getmEmail();

		// review 불러와서 저장 하는 List ( drop값이 N 인것만 )
		List<Review> rlist = service.myreviews(mEmail);

		model.addAttribute("rlist", rlist);
		return "login/mypage/mypageReview";
	}

	@RequestMapping("mypageQnA.do")
	//페이징 처리 해야 함. 하....rownum과 pagepgm 둘 다 필요....
	public String mypageQnA(PagePgm pp, 
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
			HttpSession session, Model model) {
		
		System.out.println("마이페이지 qna 리스트");
		
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}
		
		

		// 세션 얻어오기
		Member member = (Member) session.getAttribute("member");
		String mEmail = member.getmEmail();
		
		// 총 글 갯수
		int totalCount = service.totalCount(mEmail);
		System.out.println(totalCount + "개");
		
		pp = new PagePgm(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		System.out.println(pp.getCntPerPage());
		
		//페이징 처리를 위해선 startrow와 endrow가 필요. 추가적으로 나의 공지글을 찾아오기 위한 memail값을 전송
		Map<String, Object> search = new HashMap<String, Object>();
		search.put("start", pp.getStartRow());
		search.put("end", pp.getEndRow());
		search.put("memail", mEmail);

		// 내가 쓴 QnA 불러와서 저장하는 List ( drop 값이 N 인것만 )
		//이 부분 수정. 새로운 sql문을 통해 문의글과 답변글을 함께 가져온 후 공유
		List<QnaBoard> qlist = service.myqnas(search);

		System.out.println(qlist);
		System.out.println(pp.getLastPage());
		System.out.println(pp.getEndPage());
		
		model.addAttribute("qlist", qlist);
		model.addAttribute("pp", pp);
		model.addAttribute("memail", mEmail);
		return "login/mypage/mypageQnaBoard";
	}
	
	//QNA 작성 폼
	@RequestMapping("myPageQnaBoardInsertForm.do")
	public String myPageQnaBoardInsertForm(QnaBoard board,Model model) {
		
		model.addAttribute("board", board);
		return "login/mypage/myPageQnaBoardInsertForm";
	}
	
	//QNA 작성
	@RequestMapping(value = "myPageQnaBoardInsert.do", method = { RequestMethod.POST })
	public String myPageQnaBoardInsert(QnaBoard board, Model model,
			@RequestParam(value = "qnaorifile1", required = false) MultipartFile mfile,
			// 파일은 QnaBoard에서 받는 것이 불가능. 해당 DTO는 String형. 파일 이름만 저장 가능
			HttpServletRequest request) throws Exception {
		String msg = "";
		System.out.println("id:"+board.getMemail());
		int result = 0;
		int sizeCheck, extensionCheck;
		String filename = mfile.getOriginalFilename();
		// 전송된 파일에서 이름만 채취
		System.out.println("파일이름:" + filename);
		String path = request.getRealPath("images");
		 System.out.println(path);
		// 파일 저장될 경로 path
		int size = (int) mfile.getSize();
		// 첨부 파일 사이즈 (Byte) int size
		String[] file = new String[2];
		// 확장자 잘라서 저장할 배열
		String newfilename = "";
		// 새로운 파일명 저장 번수

		if (filename != "") { // 첨부 파일이 전송된 경우
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			// .뒤에 확장자만 자르기
			UUID uuid = UUID.randomUUID();
			// 난수를 발생시켜 중복 문제 해결후 확장자 결합
			newfilename = uuid.toString() + extension;
			StringTokenizer st = new StringTokenizer(filename, ".");
			// 확장자를 구분해 조건을 주기 위해 잘라줌
			file[0] = st.nextToken();
			file[1] = st.nextToken();
			// file[0]에 파일명, file[1] 에 확장자가 저장됨.

			if (size > 600000) { // 사이즈가 설정된 범위 초과할 경우
				sizeCheck = -1;
				model.addAttribute("sizeCheck", sizeCheck);
				System.out.println("설정범위 초과");
				return "login/mypage/myPageQnaBoardInsert"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯
			} 
			
			if (!file[1].equals("jpg") && 
					   !file[1].equals("png") && 
					   !file[1].equals("jpeg")&& 
					   !file[1].equals("gif"))
					   // 확장자가 jpg, png, jpeg, gif 가 아닐경우
			{
				extensionCheck = -1;
				model.addAttribute("extensionCheck", extensionCheck);

				System.out.println("올바른 확장자가 아닙니다");
				return "login/mypage/myPageQnaBoardInsert"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯

			}

			// 첨부파일이 전송된 경우
			if (size > 0) {
				mfile.transferTo(new File(path + "/" + newfilename));
				board.setQnaorifile(newfilename);
				//업로드 파일 내부의 파일을 바꾸고 DTO 내부의 이름을 바꿔버림
				System.out.println("전송됐음!!");
			}
		}

		System.out.println("파일명:"+board.getQnaorifile());

		// qna 등록
		result = service.qnaInsert(board);
		System.out.println("qna 입력 성공");

		if (result == 1) {
			System.out.println("qna 등록 성공");
			model.addAttribute("result" , result);
			model.addAttribute("msg" , "qna등록에 성공하였습니다.");
			
			
			
		} else {
			result = -1;
			model.addAttribute("result" , result);
			model.addAttribute("msg" , "qna등록에 성공하였습니다.");
			System.out.println("qna 등록 실패");
		}

		model.addAttribute("board", board);
		return "redirect:/mypageQnA.do";
		//일단은 이렇게. 팝업창에서 작성 후 유효성검사 통과시 팝업창 닫고 재요청/불통시 주의 문구 출력 후 다시 폼으로
	}
	
	//qna 상세 페이지
	@RequestMapping("mypageQnaBoardDetail.do")
	public String mypageQnaBoardDetail(PagePgm pp,QnaBoard board, Model model) {
		//현재 필요한 것은 글 조회를 위한 qid값과 페이징에 필요한 객체 뿐이나 매개변수에 int qid를 입력해선 안 됨.
		//컴파일 상의 에러 같은데 해결 불가. IllegalArgumentException 예외 발생
		//답변글 조회 쪽도 마찬가지일 것
		
		//DTO를 통해 받아야 하는데....
		
					// 해당 공지 번호의 자료 조회
					QnaBoard board1 = service.selectQna(board.getQid());
					board1.setRnum(board.getRnum());
					System.out.println(board.getQid());
					System.out.println(board.getRnum());
					System.out.println(pp.getCntPerPage());

					model.addAttribute("pp", pp);
					model.addAttribute("board", board1);
					//mnId,pp,mnd 값들을 다음 페이지로 전송

					return "login/mypage/mypageQnaBoardDetail";
	}
	
	//qna 답변 상세 페이지
	@RequestMapping("mypageQnaBoardReplyDetail.do")
	public String mypageQnaBoardReplyDetail(PagePgm pp,QnaReply reply, Model model) {
		
		if(reply.getQrid() == 0) {
			reply.setQrid(service.findQrid(reply.getQid()));
		}
		
		QnaReply reply1 = service.selectReply(reply.getQrid());
		reply1.setRnum(reply.getRnum());
		System.out.println(reply1.getRnum());
		
		model.addAttribute("pp", pp);
		model.addAttribute("reply", reply1);
		
		return "login/mypage/mypageQnaBoardReplyDetail";
	}
	
	//qna 삭제
	// 글 삭제
		@RequestMapping("mypageQnaBoardDelete.do")
		public String mypageQnaBoardDelete(int qid) {

			System.out.println("mypageQnaBoardDelete");
			service.qnaDelete(qid);
			service.replyDelete(qid);
//			model.addAttribute("pp", pp);
//			model.addAttribute("mnId", mnId);
//			model.addAttribute("nowPage", nowPage);
			return "redirect:/mypageQnA.do";
		}

	// 리뷰 삭제
	@RequestMapping("mypageDeleteReview.do")
	@ResponseBody
	public String mypageDeleteReview(@RequestParam("rid") String rid) {

		int result = service.mypageDeleteReview(rid);

		if (result == 1) {
			return "Y";
		} else {
			return "N";
		}

	}

	// 환불 요청
	@RequestMapping("refund.do")
	@ResponseBody
	public String refund(@RequestParam("odid") String odid) {
		
		System.out.println("odid : " + odid);
		int result = 0;
		
		OrderDetail od = service.myorderDetail(odid);
		
		int odstatus = od.getOdstatus();
		
		if (odstatus == 0) {
			result = service.refund(odid);
			return "Y"; // 환불 요청 완료
		} else if (odstatus == 1) {
			return "A"; // arrive 배송 완료
		} else if (odstatus == 2) {
			return "R"; // already 환불 처리중 이미
		} else {
			return "F"; // finish 환불 처리 완료.
		}

	}
	
	// my ask폼으로 이동
	@RequestMapping("mypageAskBoard.do")
	public String mypageAskBoard(HttpSession session,Model model) {
		
		Member member = (Member) session.getAttribute("member");
		
		String mEmail = member.getmEmail();
		
		// 내가 쓴 ask 불러오기
		List<Map<String,Object>> plist = service.productlist(mEmail);
		System.out.println("plist.size() : " + plist.size());
		model.addAttribute("plist", plist);
		return "login/mypage/mypageAskBoard";
	}
	
	// mypage 신고폼 이동
	@RequestMapping("mypageReport.do")
	public String mypageReport(HttpSession session, Model model) {
		
		Member member = (Member) session.getAttribute("member");
		
		String mEmail = member.getmEmail();
		
		//내가 신고한 목록
		List<Report> rlist = service.listReport(mEmail);
		System.out.println("rlist.size() : " + rlist.size());
		model.addAttribute("rlist", rlist);
		return "login/mypage/mypageReport";
	}
	
	//mypageDetail 폼 이동
	@RequestMapping("mypageReportDetail.do")
	public String mypageReportDetail(String reportid, Model model) {
		
		Report report = service.oneReport(reportid);
		
		model.addAttribute("report", report);
		return "login/mypage/mypageReportDetail";
	}

}
