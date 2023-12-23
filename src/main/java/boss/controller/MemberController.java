package boss.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

import boss.model.Member;
import boss.service.MemberService;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}

	// 회원가입 진행하고 ajax 콜백하기
	@RequestMapping("insertMember.do")
	public String loginform(Member member,Model model) {
		System.out.println("Insertmember");

		// member 폼에서 넘어온 값을 암호화
		String encpassword = passwordEncoder.encode(member.getmPwd());

		// db에 넣을 member password 를 암호화 한걸로 넣기
		member.setmPwd(encpassword);

		int result = service.insertMember(member);
		
		model.addAttribute("result", result);
		return "login/insertMemberCheck";

	}

	// 이메일 중복 검사
	// end포인트라는 어노테이션
	@PostMapping("dbCheckEmail.do")
	@ResponseBody // 응답을 HTTP 응답으로 직접 전송된다.
	public String dbCheckEmail(String mEmail) {
		Member member = service.selectOne(mEmail);

		// 사용 불가능한 이메일
		if (member != null) {
			return "N";
		} else

			return "Y";
	}

	// 로그인 첫 화면 요청 메소드 ( 기본 로그인 폼으로 이동 할때 꼭 써야 함 )
	@RequestMapping(value = "NaverLogin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(Model model, HttpSession session) {
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=mo1HJXGXT3n7A3XV59QM&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125

		System.out.println("네이버:" + naverAuthUrl);
		// 네이버
		model.addAttribute("url", naverAuthUrl);

		return "login/LoginForm";
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,
			Member member) throws Exception {
//      public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {

		System.out.println("여기는 callback");

		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);

		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);

		// String형식의 json데이터
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449", "nickname":"shinn****", "age":"20-29",
		 * "gender":"M", "email":"sh@naver.com", "name":"\uc2e0\ubc94\ud638"}}
		 **/

		// 2. String형식인 apiResult를 json형태로 바꿈 ( pom.xml 에 있어용 )
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;

		// 3. 데이터 파싱

		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");

		// response의 name, email, mobile
		String mName = (String) response_obj.get("name");
		String mEmail = (String) response_obj.get("email");
		String nPhone = (String) response_obj.get("mobile");

		System.out.println("네이버 이름 : " + mName);
		System.out.println("네이버 email : " + mEmail);
		System.out.println("네이버 mobile : " + nPhone);

		// 010-0000-0000 을 파싱해서 01000000000으로 바꾸는 코드
		String phone[] = nPhone.split("-");
		String mPhone = "";
		String Pwd = "";

		for (int i = 0; i < phone.length; i++) {
			mPhone += phone[i];
			Pwd = phone[i]; // 네이버 회원의 비밀번호는 회원 마지막 핸드폰 번호
		}

		// 마지막 핸드폰번호 (2311) 암호화
		String mPwd = passwordEncoder.encode(Pwd);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mName", mName);
		map.put("mEmail", mEmail);
		map.put("mPhone", mPhone);
		map.put("mPwd", mPwd);

		Member checkmember = service.selectOne(mEmail);

		// 회원 가입이 안 되어 있을 경우
		if (checkmember == null) {
			// 네이버 회원 가입
			int loginresult = service.insertNMember(map);

			if (loginresult == 1) {
				// 네이버 회원 member 불러오기
				member = service.selectOne(mEmail);
				// 네이버 세션 올리기
				session.setAttribute("member", member);
			}
		} else { // 회원가입이 되어 있을경우 세션만 올림
			session.setAttribute("member", checkmember);
		}

		// 세션 생성 ( 이건 건들면 안돼 )
		model.addAttribute("result", apiResult);
		return "redirect:/main.do";
	}

	// kakao 코드 받기
	@RequestMapping("kakaologin.do")
	public String kakaologin(@RequestParam(value = "code", required = false) String code, Model model,
			HttpSession session, Member member) throws Throwable {

		// 1. 인가코드 받기 ( 인가코드로 토큰을 발행하는거임 )
		System.out.println("code:" + code);

		// 토큰 발행 ( 서비스 클래스에서 ) 그리고 토근 받아오기
		String access_Token = service.getAccessToken(code);

		System.out.println("###access_Token#### : " + access_Token);
		// 위의 access_Token 받는 걸 확인한 후에 밑에 진행

		// 3번
		HashMap<String, Object> userInfo = service.getUserInfo(access_Token);
		System.out.println("###nickname#### : " + userInfo.get("nickname"));
		System.out.println("###email#### : " + userInfo.get("email"));

		String nickname = (String) userInfo.get("nickname");
		String mEmail = (String) userInfo.get("email");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mEmail", mEmail);
		map.put("mName", nickname);
		
		Member checkmember = service.selectOne(mEmail);

		// 회원 가입이 안 되어 있을 경우
		if (checkmember == null) {
			// 카카오 회원 가입
			int loginresult = service.insertKMember(map);

			if (loginresult == 1) {
				// 카카오 회원 member 불러오기
				member = service.selectOne(mEmail);
				// 카카오 세션 올리기
				session.setAttribute("member", member);
			}
		} else { // 회원가입이 되어 있을경우 세션만 올림
			session.setAttribute("member", checkmember);
		}
		
		return "common/main";
	}

	// 이메일 보내는 요청 ( 인증번호 )
	@ResponseBody
	@RequestMapping(value = "emailAuth.do", method = RequestMethod.POST)
	public String emailAuth(String mEmail) {
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		/* 이메일 보내기 */
		String setFrom = "boss_mall@naver.com"; // 이메일을 보내는 사람의 주소 ( 유효해야함 )
		String toMail = mEmail; // 회원가입 폼에서 쓴 email 매개변수로 받았음
		String title = "회원가입 인증 이메일 입니다."; // 제목
		String content = "홈페이지를 방문해주셔서 감사합니다." + "<br><br>" + "인증 번호는 " + checkNum + "입니다." + "<br><br>" // 내용
				+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return Integer.toString(checkNum);
	}

	// 회원가입 폼 이동 ( insert )
	@RequestMapping("insertForm.do")
	public String insertMember() {
		return "login/InsertForm";
	}
	
	// 회원수정 폼 이동 (update)
	@RequestMapping("updateForm.do")
	public String updateForm(HttpSession session, Model model) {
		
		// 세션에 있는 Member 값 구해오기
		Member dbMember = (Member) session.getAttribute("member");
		
		String mEmail = dbMember.getmEmail();
		
		Member member = service.selectOne(mEmail);
		
		model.addAttribute("member", member);
		return "login/updateForm";
	}
	
	// 회원수정
	@RequestMapping("updateMember.do")
	public String updateForm(Member member,Model model) {
		
		int result = 0;
		String mEmail = member.getmEmail();
		
		Member dbmember = service.selectOne(mEmail);
		
		// 비번 비교
		if(passwordEncoder.matches(member.getmPwd(), dbmember.getmPwd())) {
			result = service.updateMember(member);
		}
		
		model.addAttribute("result", result);
		return "login/updateMemberCheck";
	}
	

	// 로그인 기능
	@RequestMapping("login.do")
	public ResponseEntity<Map<String, String>> Login(String mEmail, String mPwd, HttpSession session) {

		Map<String, String> response = new HashMap<>();

		System.out.println(mEmail);

		Member dbmember = service.selectOne(mEmail);

		if (dbmember != null && passwordEncoder.matches(mPwd, dbmember.getmPwd())) {
			response.put("result", "Y");
			session.setAttribute("member", dbmember); // dbmember 라는 이름으로 DTO 객체를 세션 공유 설정
		} else {
			response.put("result", "N");
		}

		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	// 로그아웃 세션 종료
	@RequestMapping(value = "Logout.do")
	public String Logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main.do";
	}
	
	// 회원 탈퇴 폼 이동
	@RequestMapping("deleteForm.do")
	public String deleteForm() {
		return "login/deleteForm";
	}

	// 회원 탈퇴 ( mPwd 넘어오는데 이미 암호화 된게 넘어옴 )
	@RequestMapping("deleteMember.do")
	@ResponseBody
	public String deleteMember(@RequestParam("mEmail") String mEmail,@RequestParam("mPwd") String mPwd) {
		int result = 0;
		Member member = service.selectOne(mEmail);
		
		if(member != null) {
			if(mPwd.equals(member.getmPwd())) {
			result = service.deleteMember(mEmail);
			}
		}
		
		System.out.println("result : " + result);
		
		if(result == 1) {
			return "Y";
		}else {
			return "N";
		}
	}

}