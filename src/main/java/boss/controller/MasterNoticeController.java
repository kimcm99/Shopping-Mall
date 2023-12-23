package boss.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.MasterNotice;
import boss.service.MasterNoticeService;

@Controller
public class MasterNoticeController {

	@Autowired
	MasterNoticeService service;

	// 글 등록폼 이동 메소드
	@RequestMapping("masterNoticeInsertForm.do")
	public String masterNoticeInsertForm() {

		return "./master/notice/masterNoticeInsertForm";
	}

	// 새 글 등록 메소드
	@RequestMapping(value = "masterNoticeInsert.do", method = { RequestMethod.POST })
	public String masterNoticeInsert(MasterNotice notice, Model model,
			@RequestParam(value = "mnOriFile1", required = false) MultipartFile mfile,
			// 파일은 MasterNotice에서 받는 것이 불가능. 해당 DTO는 String형. 파일 이름만 저장 가능
			HttpServletRequest request) throws Exception {

		int result = 0;
		int sizeCheck, extensionCheck;
		String filename = mfile.getOriginalFilename();
		// 전송된 파일에서 이름만 채취
		String path = request.getRealPath("images");
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
				return "redirect:/masterNotice.do"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯
			} else if (!file[1].equals("jpg") && !file[1].equals("png") && !file[1].equals("jpeg")
					&& !file[1].equals("gif"))
			// 확장자가 jpg, png, jpeg, gif 가 아닐경우
			{
				extensionCheck = -1;
				model.addAttribute("extensionCheck", extensionCheck);
				return "redirect:/masterNotice.do"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯

			}

			// 첨부파일이 전송된 경우
			if (size > 0) {
				mfile.transferTo(new File(path + "/" + newfilename));
				notice.setMnOriFile(newfilename);
				// 업로드 파일 내부의 파일을 바꾸고 DTO 내부의 이름을 바꿔버림
			}
		}
		// 공지 등록
		result = service.noticeInsert(notice);
		model.addAttribute("notice", notice);
		return "redirect:/masterNotice.do";
	}

	// 글 삭제
	@RequestMapping("masterNoticeDelete.do")
	public String masterNoticeDelete(int mnId, PagePgm pp, Model model) {
			service.noticeDelete(mnId);
			model.addAttribute("nowPage", pp.getNowPage());
			return "redirect:/masterNotice.do";
		
		
	}

	// 글 수정 폼
	@RequestMapping("masterNoticeUpdateForm.do")
	public String masterNoticeUpdateForm(PagePgm pp, Model model, MasterNotice mn,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
		mn = service.selectOne(mn.getmnId());
		model.addAttribute("mn", mn);
		model.addAttribute("pp", pp);

		return "./master/notice/masterNoticeUpdateForm";
	}

	// 글 수정
	@RequestMapping(value = "masterNoticeUpdate.do", method = RequestMethod.POST)
	public String masterNoticeUpdate(PagePgm pp, Model model, MasterNotice mn,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
			@RequestParam(value = "mnOriFile1", required = false) MultipartFile mfile,
			HttpServletRequest request) throws Exception {

		int sizeCheck, extensionCheck;
		String filename = mfile.getOriginalFilename();
		int size = (int) mfile.getSize();
		String path = request.getRealPath("images");
		int result = 0;
		String file[] = new String[2];
		String newfilename = "";
		mn.setMnTitle(mn.getMnTitle() + "(수정)");
		if (filename != "") { // 첨부파일이 전송된 경우
			// 파일 중복문제 해결
			String extension = filename.substring(filename.lastIndexOf("."), filename.length());
			UUID uuid = UUID.randomUUID();
			newfilename = uuid.toString() + extension;
			StringTokenizer st = new StringTokenizer(filename, ".");
			file[0] = st.nextToken(); // 파일명
			file[1] = st.nextToken(); // 확장자
			if (size > 600000) { // 사이즈가 설정된 범위 초과할 경우
				sizeCheck = -1;
				model.addAttribute("sizeCheck", sizeCheck);
				return "./master/notice/masterNotice"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯
			} else if (!file[1].equals("jpg") && !file[1].equals("png") && !file[1].equals("jpeg")
					&& !file[1].equals("gif"))
			// 확장자가 jpg, png, jpeg, gif 가 아닐경우
			{
				extensionCheck = -1;
				model.addAttribute("extensionCheck", extensionCheck);
				return "./master/notice/masterNotice"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯
			}

		}

		if (size > 0) { // 첨부파일이 전송된 경우
			mfile.transferTo(new File(path + "/" + newfilename));
			mn.setMnOriFile(newfilename);
			// 업로드 파일 내부의 파일을 바꾸고 DTO 내부의 이름을 바꿔버림
		}

		if (size == 0) { // 첨부 파일이 수정되지 않으면 파일 유지
							// 이 코드가 없으면 null값으로 변해버림
			MasterNotice oldmn = service.selectOne(mn.getmnId());
			String oldfilename = oldmn.getMnOriFile();
			// sql문을 호출. 테이블에 존재하는 파일명을 가져와 저장
			mn.setMnOriFile(oldfilename); // 테이블에 저장된 파일명을 설정

		}
		
		
			// update문 실행. 완성된 DTO 객체를 전송, 테이블에 덮어씌움
			service.masterNoticeUpdate(mn);
			mn = service.selectOne(mn.getmnId());
			
			model.addAttribute("mnId", mn.getmnId());
			model.addAttribute("nowPage", pp.getNowPage());
			model.addAttribute("cntPerPage", pp.getCntPerPage());
			model.addAttribute("rnum", mn.getRnum());

				return "redirect:/masterNoticeDetail.do";
			
		
	}

	// 공지사항 목록 페이지 출력
	@RequestMapping("masterNotice.do")
	public String masterNotice(PagePgm pp, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "20";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "20";
		}

		// 총 글 갯수
		int totalCount = service.totalCount();
		pp = new PagePgm(totalCount, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		// 페이징 처리된 리스트
		List<MasterNotice> noticeList = service.noticeList(pp);
		model.addAttribute("pp", pp);
		model.addAttribute("list", noticeList);

		return "./master/notice/masterNotice";
	}


	// 공지 내용 : 세부 내용 띄우면서 조회수 + 1
	@RequestMapping("masterNoticeDetail.do")
	public String masterNoticeDetail(PagePgm pp, Model model, MasterNotice mn) {
		
		// 조회수 + 1
		service.updateMnReadCount(mn.getmnId());

		if (mn.getRnum() != 0) {
			mn = service.selectMove(mn.getRnum());
		}else {
			// 해당 공지 번호의 자료 조회
			mn = service.selectOne(mn.getmnId());
		}

		
		// 글 번호의 최대값 구하기
		pp.setTotal(service.totalCount());
		model.addAttribute("mnId", mn.getmnId());
		model.addAttribute("pp", pp);
		model.addAttribute("mnd", mn);
		// mnId,pp,mnd 값들을 다음 페이지로 전송
		return "./master/notice/masterNoticeDetail";
	}

	// 공지 내용 : 이전글/다음글로 이동
	@RequestMapping("masterNoticeDetailMove.do")
	public String masterNoticeDetailMove(PagePgm pp, Model model, MasterNotice mn,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
		// 글 번호의 최대값 구하기
		int t = service.totalCount();
		pp.setTotal(t);
		// 해당 글 번호의 자료 조회
		mn = service.selectMove(mn.getRnum());
		model.addAttribute("mnId", mn.getmnId());
		model.addAttribute("cntPerPage", pp.getCntPerPage());
		model.addAttribute("rnum", mn.getRnum());
		// model.addAttribute를 통해 단일값을 공유하면 get방식으로 공유됨. url 주소에서 확인 가능
		model.addAttribute("pp", pp);
		model.addAttribute("mnd", mn);

		return "redirect:/masterNoticeDetail.do";
	}
	
	// 공지 검색
		@RequestMapping("masterNoticeSearch.do")
		public String masterNoticeSearch(PagePgm pp, Model model,
				@RequestParam(value = "nowPage", required = false) String nowPage,
				@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
			if (nowPage == null) {
				nowPage = "1";
			} else {
				pp.setNowPage(Integer.parseInt(nowPage));
			}
			cntPerPage = "20";
			int total = service.noticeCount(pp);
			PagePgm pp1 = new PagePgm(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage), pp);
			pp1.setSearchtype(pp.getSearchtype());
			pp1.setKeyword(pp.getKeyword());
			List<MasterNotice> noticeSearch = service.noticeSearchList(pp1);
			model.addAttribute("pp", pp1);
			model.addAttribute("list", noticeSearch);
			return "master/notice/masterNoticeSearch";
		}
		
	//검색어가 있을 때 세부내용
	@RequestMapping("masterNoticeSearchDetail.do")
	public String masterNoticeSearchDetail(PagePgm pp, Model model, MasterNotice mn) {
		// 조회수 + 1
				service.updateMnReadCount(mn.getmnId());
				Map<String, Object> map = new HashMap<String, Object>();
				if (mn.getRnum() != 0) {
					map.put("keyword", pp.getKeyword());
					map.put("searchtype", pp.getSearchtype());
					map.put("rnum", mn.getRnum());
					mn = service.searchMove(map);
				}else {
					map.put("keyword", pp.getKeyword());
					map.put("searchtype", pp.getSearchtype());
					map.put("mnid", mn.getmnId());
					// 해당 공지 번호의 자료 조회
					mn = service.searchOne(map);
				}
				// 글 번호의 최대값 구하기
				pp.setTotal(service.noticeCount(pp));
				model.addAttribute("mnId", mn.getmnId());
				model.addAttribute("pp", pp);
				model.addAttribute("mnd", mn);
				
				// mnId,pp,mnd 값들을 다음 페이지로 전송

				return "./master/notice/masterNoticeSearchDetail";
	}

	// 검색어가 있을 때 이전글/다음글로 이동
	@RequestMapping("masterNoticeSearchMove.do")
	public String masterNoticeSearchMove(PagePgm pp, Model model, MasterNotice mn,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
		// 글 번호의 최대값 구하기
		int t = service.noticeCount(pp);
		pp.setTotal(t);
		// 해당 글 번호의 자료 조회
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("keyword", pp.getKeyword());
		map.put("searchtype", pp.getSearchtype());
		map.put("rnum", mn.getRnum());
		mn = service.searchMove(map);
		model.addAttribute("mnId", mn.getmnId());
		model.addAttribute("cntPerPage", pp.getCntPerPage());
		model.addAttribute("keyword",pp.getKeyword());
		model.addAttribute("searchtype",pp.getSearchtype());
		
		// model.addAttribute를 통해 단일값을 공유하면 get방식으로 공유됨. url 주소에서 확인 가능

		return "redirect:/masterNoticeSearchDetail.do";
	}
		
		// 검색 시 글 수정 폼
		@RequestMapping("masterNoticeSearchUpdateForm.do")
		public String masterNoticeSearchUpdateForm(PagePgm pp, Model model, MasterNotice mn,
				@RequestParam(value = "nowPage", required = false) String nowPage,
				@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
			
			mn = service.selectOne(mn.getmnId());

			model.addAttribute("mn", mn);
			model.addAttribute("pp", pp);

			return "./master/notice/masterNoticeSearchUpdateForm";
		}
		
		//검색어가 있을 때 글 등록 폼
		@RequestMapping("masterNoticeSearchInsertForm.do")
		public String masterNoticeSearchInsertForm(PagePgm pp,Model model) {

			model.addAttribute("pp", pp);
			return "./master/notice/masterNoticeSearchInsertForm";
		}
		
		// 검색어가 있을 때 새 글 등록
		@RequestMapping(value = "masterNoticeSearchInsert.do", method = { RequestMethod.POST })
		public String masterNoticeSearchInsert(MasterNotice notice, Model model,PagePgm pp,
				@RequestParam(value = "mnOriFile1", required = false) MultipartFile mfile,
				// 파일은 MasterNotice에서 받는 것이 불가능. 해당 DTO는 String형. 파일 이름만 저장 가능
				HttpServletRequest request) throws Exception {

			int result = 0;
			int sizeCheck, extensionCheck;
			String filename = mfile.getOriginalFilename();
			// 전송된 파일에서 이름만 채취
			String path = request.getRealPath("images");
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
					return "redirect:/masterNoticeSearch.do"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯
				} 
				if (!file[1].equals("jpg") && !file[1].equals("png") && !file[1].equals("jpeg")
						&& !file[1].equals("gif"))
				// 확장자가 jpg, png, jpeg, gif 가 아닐경우
				{
					extensionCheck = -1;
					model.addAttribute("extensionCheck", extensionCheck);

					return "redirect:/masterNoticeSearch.do"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯

				}

				// 첨부파일이 전송된 경우
				if (size > 0) {
					mfile.transferTo(new File(path + "/" + newfilename));
					notice.setMnOriFile(newfilename);
					// 업로드 파일 내부의 파일을 바꾸고 DTO 내부의 이름을 바꿔버림
				}
			}


			// 공지 등록
			result = service.noticeInsert(notice);
			return "redirect:/masterNotice.do";
		}
		
		
		
		// 검색어가 있을 때 글 수정
				@RequestMapping(value = "masterNoticeSearchUpdate.do", method = RequestMethod.POST)
				public String masterNoticeSearchUpdate(PagePgm pp, Model model, MasterNotice mn,
						@RequestParam(value = "nowPage", required = false) String nowPage,
						@RequestParam(value = "cntPerPage", required = false) String cntPerPage,
						@RequestParam(value = "mnOriFile1", required = false) MultipartFile mfile,
						HttpServletRequest request) throws Exception {

					int sizeCheck, extensionCheck;
					String filename = mfile.getOriginalFilename();
					int size = (int) mfile.getSize();
					String path = request.getRealPath("images");
					int result = 0;
					String file[] = new String[2];
					String newfilename = "";

					mn.setMnTitle(mn.getMnTitle() + "(수정)");

					if (filename != "") { // 첨부파일이 전송된 경우

						// 파일 중복문제 해결
						String extension = filename.substring(filename.lastIndexOf("."), filename.length());
						UUID uuid = UUID.randomUUID();
						newfilename = uuid.toString() + extension;
						StringTokenizer st = new StringTokenizer(filename, ".");
						file[0] = st.nextToken(); // 파일명
						file[1] = st.nextToken(); // 확장자

						if (size > 600000) { // 사이즈가 설정된 범위 초과할 경우
							sizeCheck = -1;
							model.addAttribute("sizeCheck", sizeCheck);
							return "./master/notice/masterNoticeSearch"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯

						} else if (!file[1].equals("jpg") && !file[1].equals("png") && !file[1].equals("jpeg")
								&& !file[1].equals("gif"))
						// 확장자가 jpg, png, jpeg, gif 가 아닐경우
						{
							extensionCheck = -1;
							model.addAttribute("extensionCheck", extensionCheck);

							return "./master/notice/masterNoticeSearch"; // 이동 대신 경고메세지 출력 후 복귀가 좋을 듯

						}

					}

					if (size > 0) { // 첨부파일이 전송된 경우
						mfile.transferTo(new File(path + "/" + newfilename));
						mn.setMnOriFile(newfilename);
						// 업로드 파일 내부의 파일을 바꾸고 DTO 내부의 이름을 바꿔버림
					}

					if (size == 0) { // 첨부 파일이 수정되지 않으면 파일 유지
										// 이 코드가 없으면 null값으로 변해버림
						MasterNotice oldmn = service.selectOne(mn.getmnId());
						String oldfilename = oldmn.getMnOriFile();
						// sql문을 호출. 테이블에 존재하는 파일명을 가져와 저장
						mn.setMnOriFile(oldfilename); // 테이블에 저장된 파일명을 설정
					}
						service.masterNoticeUpdate(mn);
						
						model.addAttribute("mnId", mn.getmnId());
						model.addAttribute("cntPerPage", pp.getCntPerPage());
						model.addAttribute("rnum", mn.getRnum());
						
						return "redirect:/masterNoticeDetail.do";
					
				}
				
				// 검색어가 있을 때 글 삭제
				@RequestMapping("masterNoticeSearchDelete.do")
				public String masterNoticeSearchDelete(PagePgm pp, MasterNotice mn, Model model) {
						service.noticeDelete(mn.getmnId());
						model.addAttribute("searchtype", pp.getSearchtype());
						model.addAttribute("keyword", pp.getKeyword());
						model.addAttribute("mnId", mn.getmnId());
						model.addAttribute("cntPerPage", pp.getCntPerPage());
						
						return "redirect:/masterNoticeSearch.do";
					
					
				}

}
