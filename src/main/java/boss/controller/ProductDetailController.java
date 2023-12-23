package boss.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.event.ListDataListener;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.rpc.context.AttributeContext.Request;

import boss.common.PagePgm;
import boss.model.AskBoard;
import boss.model.Member;
import boss.model.Orders;
import boss.model.Product;
import boss.model.QnaBoard;
import boss.model.Review;
import boss.service.ProductDetailService;

@Controller
public class ProductDetailController {

	@Autowired
	private ProductDetailService service;

	// 상세페이지
	@RequestMapping("productDetail.do")
	public String productDetail(String pid, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, String search,AskBoard askboard,
			@RequestParam(value = "anowPage", required = false) String anowPage, 
			@RequestParam(value = "acntPerPage", required = false) String acntPerPage) throws Exception {
		
		// 상품 불러오기
		Product product = service.selectProduct(pid);
		System.out.println("---------------------------------------------------------------------------");
		System.out.println("anowPage : " + anowPage);
		System.out.println("nowPage : " + nowPage);
		System.out.println("productdelete.do 들어왔음");
		
		
		
		// 리뷰 합계
		int total = service.total(pid);
		
		// 페이징 처리
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "5";
		}

		// 리뷰
		PagePgm reviewpp = new PagePgm(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));

		// 리뷰 페이징 처리
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("pid", pid);
		map.put("reviewpp", reviewpp);

		// 리뷰 구해오기
		List<Review> list = service.list(map);
		
		
		/*      문의 페이징 처리 시작      */
		
		// 문의 합계
		int asktotal = service.asktotal(pid);
		
		// 문의 필드 초기화
		if (anowPage == null && acntPerPage == null) {
			anowPage = "1";
			acntPerPage = "5";
		} else if (anowPage == null) {
			anowPage = "1";
		} else if (acntPerPage == null) {
			acntPerPage = "5";
		}
		
		System.out.println("anowPage : " + anowPage);
		System.out.println("nowPage : " + nowPage);
		
		// 문의 페이징 생성자 초기화
		PagePgm askpp = new PagePgm(asktotal, Integer.parseInt(anowPage), Integer.parseInt(acntPerPage));
		
		// 문의 페이징 처리 ( 쿼리문 )
		Map<String, Object> amap = new HashMap<String, Object>();
		amap.put("pid", pid);
		amap.put("askpp", askpp);
		
		// 문의
		List<AskBoard> asklist = service.asklist(amap);

		
		
		if (!list.equals(null) && list.size() > 0) { //review 1개라도 구해옴.
			System.out.println("list.size() : " + list.size());
			model.addAttribute("reviewList", list);
		} else { // 1개도 못구해옴
			System.out.println("list를 못구해옴 : " + list.size());
		}
		
		
		if (!asklist.equals(null) && asklist.size() > 0) {		// askBoard 1개라도 구해옴
			System.out.println("asklist.size() :" + asklist.size());
			model.addAttribute("asklist", asklist);
		}else {	// askBoard 1개라도 못구해옴
			System.out.println("asklist 못구함:" + asklist.size());
		}
		String pcon = product.getPcontent();
		System.out.println("변경전 : " + pcon);
		String pcon2 = pcon.replace("\n", "<br>");
		System.out.println("변경후 : " + pcon2);
		
		
		
		
		model.addAttribute("product", product);
		model.addAttribute("pid", pid);
		model.addAttribute("askpp", askpp);
		model.addAttribute("reviewpp", reviewpp);
		
		return "./product/productDetail";
	}

	// 리뷰 작성 페이지 이동
	@RequestMapping("productReviewInsertForm.do")
	public String productReviewInsertForm(String pid, Model model, HttpSession session) {
		System.out.println("productReviewInsertForm");

		// 세션을 통해서 이메일을 가져감
		Member member = (Member) session.getAttribute("member");
		String mEmail = member.getmEmail();

		// 작성하는 실시간 날짜
		Date date = new Date();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String reviewDate = sdf.format(date);
		
		model.addAttribute("mEmail", mEmail);
		model.addAttribute("pid", pid);
		model.addAttribute("reviewDate", reviewDate); // 오늘 날짜 띄우기

		return "./product/review/productReviewInsertForm";
	}

	// 리뷰 등록
	@RequestMapping(value = "productReviewcheck.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String prInsert(Model model, Review review, HttpSession session, int pid,HttpServletRequest request,
			@RequestParam(value = "rimage1", required = false) MultipartFile mfile) throws Exception {

		int result = 0;
		
		System.out.println(pid);
		
		// 세션 얻어오기
		Member member = (Member) session.getAttribute("member");

		// 이메일 얻기
		String mEmail = member.getmEmail();
		
		// pid 받는 list 가져오기 
		List<Map<String, Object>> plist = service.plist(mEmail);
		
		int pida[] = new int[plist.size()];
		
		for(int i = 0; i<plist.size(); i++) {
			Object pidObject = plist.get(i).get("PID") ;
			
			pida[i] = Integer.parseInt(pidObject.toString());
			
			System.out.println(pida[i]);
		}
		

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memail", mEmail);
		map.put("pid",pid);
		// 내 이메일, pid 로 orders에서 정보 추출 (주문 내역이 있나)
		List<Orders> olist = service.selectlist(mEmail);

		// 내가 쓴 리뷰 갯수 구하기
		List<Review> rlist = service.selectReviewOne(map); // 내가 쓴 리뷰의 갯수

		int oid[] = new int[olist.size()]; // oid

		if (olist != null && rlist.size() <= olist.size()) { // 리뷰등록이 가능한지 검사
			for (int i = 0; i < olist.size(); i++) {
				oid[i] = olist.get(i).getOid();
				// 여기에 review테이블에 이미 oid를 가지고 리뷰를 썼는지 확인 해야함
				Review rcheck = service.rcheck(oid[i]);

				if (rcheck == null) { // oid로 리뷰를 작성 한 적이 없다면
					System.out.println("파일 직전");
					// 파일 set 코드 들어갈 공간
					int sizeCheck, extensionCheck;
					// 첨부 파일명
					String filename = mfile.getOriginalFilename();
					System.out.println("파일이름" + filename);
					// 첨부 파일 사이즈 (Byte)
					int size = (int) mfile.getSize();
					// 파일 저장될 경로

					//String path = "C:\\Users\\ock2k\\OneDrive\\바탕 화면\\bossproject\\boss\\src\\main\\webapp\\images";

					String path = request.getRealPath("images");
					System.out.println("oldpath : " + path);
					System.out.println(path);

					// 확장자 잘라서 저장할 배열
					String[] file = new String[2];

					// 새로운 파일명 저장 번수
					String newfilename = "";

					if (filename != "") { // 첨부 파일이 전송된 경우
						// .뒤에 확장자만 자르기
						String extension = filename.substring(filename.lastIndexOf("."), filename.length());

						UUID uuid = UUID.randomUUID();

						// 난수를 발생시켜 중복 문제 해결후 확장자 결합
						newfilename = uuid.toString() + extension;

						// 확장자를 구분해 조건을 주기 위해 잘라줌 file[1] 에 확장자가 저장됨.
						StringTokenizer st = new StringTokenizer(filename, ".");
						file[0] = st.nextToken();
						file[1] = st.nextToken();

						if (size > 10000000) {
							// 사이즈가 설정된 범위 초과할 경우
							sizeCheck = -1;
							model.addAttribute("sizeCheck", sizeCheck);
							System.out.println("설정범위 초과");
							return "./product/productDetail.do?pid=" + pida;

							// 확장자가 jpg, png, jpeg, gif 가 아닐경우
						} else if (!file[1].equals("jpg") && !file[1].equals("png") && !file[1].equals("jpeg")
								&& !file[1].equals("gif")) {
							extensionCheck = -1;
							model.addAttribute("extensionCheck", extensionCheck);
							return "./product/productDetail.do?pid=" + pida;
						}

					}

					// 첨부파일이 전송된 경우
					if (size > 0) {
						mfile.transferTo(new File(path + "/" + newfilename));
						review.setRimage(newfilename);
						System.out.println("전송됐음!!");
					}

					review.setOid(oid[i]);
					review.setMemail(mEmail);
					result = service.reviewInsert(review);
					break;
				} else {
					continue;
				}

			} // for문 end
		} // if문 end

		model.addAttribute("result", result);
		model.addAttribute("pid", pid);

		return "./product/review/productReviewcheck";
	}

	// 리뷰 상세 불러오기
	@RequestMapping("productReviewSelect.do")
	public String productReviewSelect(int pid, Model model, int rid, Review review) {
		System.out.println("productReviewSelect :" + "리뷰 상세");

		review = service.prselect(rid);

		model.addAttribute("review", review);
		model.addAttribute("pid", pid);

		System.out.println("상세페이지 불러옴");

		return "./product/review/productReviewSelect";
	}

	// 리뷰 수정폼으로 이동
	@RequestMapping("productReviewUpdateForm.do")
	public String productReviewUpdateForm(int pid, Model model, Review review, int rid, HttpSession session) {
		System.out.println("productReviewUpdateForm :" + "수정");

		// 세션 가져오기
		Member member = (Member) session.getAttribute("member");

		String mEmailreview = member.getmEmail();
		System.out.println("mEmail 왔냐? " + mEmailreview);

		// 작성하는 실시간 날짜
		Date date = new Date();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String reviewDate = sdf.format(date);

		review = service.prselect(rid);
		System.out.println(review.getMemail());

		if (mEmailreview.equals(review.getMemail())) {
			System.out.println("update폼 다시 가기");
			model.addAttribute("review", review);
			model.addAttribute("pid", pid);
			model.addAttribute("mEmailreview", mEmailreview);
			model.addAttribute("reviewDate", reviewDate);
			model.addAttribute("rid", review.getRid());
			return "./product/review/productReviewUpdateForm";
			
		} else {
			System.out.println("나이스");
			return "./product/review/productReviewSelect.do?rid=" + rid + "&pid" + pid;
		}

	}

	// 리뷰 수정
	@RequestMapping(value = "productReviewUpdateCheck.do", method = { RequestMethod.POST, RequestMethod.GET })
	public String productReviewUpdateCheck(Model model, Review review, HttpSession session,HttpServletRequest request,
			@RequestParam(value = "rimage1", required = false) MultipartFile mfile) throws Exception {
		
		int result = 0;

		// 세션 얻어오기
		Member member = (Member) session.getAttribute("member");

		// 이메일 얻기
		String mEmail = member.getmEmail();
		System.out.println("수정 리뷰 세션 이메일 확인 : " + mEmail);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memail", mEmail);
		map.put("pid", review.getPid());

		// 내 이메일, pid 로 orders에서 정보 추출 (주문 내역이 있나)
		List<Orders> olist = service.selectlist(mEmail);

		// 내가 쓴 리뷰 갯수 구하기
		List<Review> rlist = service.selectReviewOne(map); // 내가 쓴 리뷰의 갯수

		int oid[] = new int[olist.size()]; // oid

		if (olist != null && rlist.size() <= olist.size()) { // 리뷰 수정이 가능한지 검사
			for (int i = 0; i < olist.size(); i++) {
				oid[i] = olist.get(i).getOid();

				// 여기에 review 테이블에 이미 oid를 가지고 리뷰를 썼는지 확인 해야함
				Review Review = service.rcheck(oid[i]);

				System.out.println("수정 리뷰 파일 직전");

				// 파일 set 코드 들어갈 공간
				int sizeCheck, extensionCheck;
				System.out.println("setcode");
				// 첨부 파일명
				String filename = mfile.getOriginalFilename();
				System.out.println("파일이름" + filename);

				// 첨부 파일 사이즈 (Byte)
				int size = (int) mfile.getSize();

				// 파일 저장될 경로
				//String path = "C:\\Users\\ock2k\\OneDrive\\바탕 화면\\bossproject\\boss\\src\\main\\webapp\\images";
				String path = request.getRealPath("images");
				
				System.out.println("oldpath : " + path);
				System.out.println(path);

				// 확장자 잘라서 저장할 배열
				String[] file = new String[2];

				// 새로운 파일명 저장 번수
				String newfilename = "";

				if (filename != "") { // 첨부 파일이 전송된 경우
					// .뒤에 확장자만 자르기
					String extension = filename.substring(filename.lastIndexOf("."), filename.length());

					UUID uuid = UUID.randomUUID();

					// 난수를 발생시켜 중복 문제 해결후 확장자 결합
					newfilename = uuid.toString() + extension;

					// 확장자를 구분해 조건을 주기 위해 잘라줌 file[1] 에 확장자가 저장됨.
					StringTokenizer st = new StringTokenizer(filename, ".");
					file[0] = st.nextToken();
					file[1] = st.nextToken();

					if (size > 10000000) {
						// 사이즈가 설정된 범위 초과할 경우
						sizeCheck = -1;
						model.addAttribute("sizeCheck", sizeCheck);
						System.out.println("설정범위 초과");
						return "./product/productDetail.do?pid=" + review.getPid();
					} else if (!file[1].equals("jpg") && !file[1].equals("png") && !file[1].equals("jpeg")
							&& !file[1].equals("gif")) {
						// 확장자가 jpg, png, jpeg, gif 가 아닐경우
						extensionCheck = -1;
						model.addAttribute("extensionCheck", extensionCheck);
						return "./product/productDetail.do?pid=" + review.getPid();
					}
				}

				// 첨부파일이 전송된 경우
				if (size > 0) {
					mfile.transferTo(new File(path + "/" + newfilename));
					Review.setRimage(newfilename);
					System.out.println("전송됐음!!");
				}
				review.setRimage(newfilename);
				review.setRid(review.getRid());
				review.setMemail(mEmail);
				
				// 리뷰를 업데이트합니다.
				result = service.reviewupdate(review);

				break;
			} // for문 end
		} // if문 end

		model.addAttribute("rid", review.getRid());
		model.addAttribute("result", result);
		model.addAttribute("pid", review.getPid());

		return "./product/review/productReviewUpdateCheck";
	}
}
