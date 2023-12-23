package boss.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.OrderDetail;
import boss.model.Orders;
import boss.model.Product;
import boss.service.MasterOrdersService;
import boss.service.MasterProductService;

@Controller
public class MasterOrdersController {

	@Autowired
	MasterOrdersService mos;
	@Autowired
	MasterProductService mps;

	// 관리자 리뷰리스트
	@RequestMapping("masterOrdersList.do")
	public String masterOrdersList(PagePgm pp, Model model,
			@RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage, String search) throws Exception {
		System.out.println("masterOrdersList");

		int total = mos.total();
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
		model.addAttribute("list", mos.list(pp));
		return "master/orders/masterOrdersList";
	}

	// 관리자 주문 상세정보
	@RequestMapping("masterOrdersSelect.do")
	public String masterOrdersSelect(String oid, Model model) throws Exception {
		System.out.println("masterOrdersSelect");
		System.out.println("oid : " + oid);
		List<HashMap<String, Object>> ordersList = new ArrayList<>();
		if (oid != null) { // 주문정보가 있다면. (없으면 처음부터 select도 못들어옴. else처리 안함)
			System.out.println("oid 널통과");
			ordersList = mos.listProduct(Integer.parseInt(oid));
			if (ordersList != null && ordersList.size() > 0) { // 리스트 구해옴
				System.out.println("list 통과 : ");
				model.addAttribute("ordersList", ordersList);
				// 단일정보 (뷰에서 쓰기쉽게 foreach안돌려도됨)
				model.addAttribute("orders", ordersList.get(0));
				System.out.println("dorders" + ordersList.get(0));
			} else { // oid는 있으나 list를 못구해옴
				System.out.println("oid는 있으나 list는 못구해옴 ");
			}
			// 모든정보의 List

		}
		return "master/orders/masterOrdersSelect";
	}

	// 관리자 주문 상세 - 배송상태 변경
	@RequestMapping("masterOrdersStatus.do")
	@ResponseBody
	public String masterOrdersStatus(@RequestParam String odid, @RequestParam String odstatus, Model model)
			throws Exception {
		System.out.println("masterOrdersStatus");
		System.out.println("odid = " + odid);
		System.out.println("odstatus = " + odstatus);
		int oid = mos.selectOrderDetail(odid).getOid();
		System.out.println("oid : " + oid);
		System.out.println("odid : " + odid);
		System.out.println("odstatus : " + odstatus);
		if (odstatus != null) {
			// 상태변경
			int result = mos.updateStatus(odid, odstatus);
			if (result == 1) { // 수정 완료시
				System.out.println("수정성공");
				model.addAttribute("oid", oid);
				return "Y";
			} else { // 수정 실패시
				System.out.println("수정실패");
				return "N";
			}
		} else {
			return "N";
		}
	}

	// 관리자 주문 삭제
	@RequestMapping("masterOrdersDelete.do")
	public String masterReviewDelete(String oid, Model model, HttpServletRequest request) {
		System.out.println("masterMemberDelete");
		System.out.println("rid : " + oid);
		// Service에서 메소드를 1번만 호출하기 위해 리스트로 양식을 통일했음.
		List<String> idList = new ArrayList<String>();
		String[] ids = request.getParameterValues("chkId");

		int result = 0;
		String msg = "";
		// id값이 1개라도 넘어온다면 (복수허용)

		if ((oid != null) || (request.getParameterValues("chkId") != null)) { // 요청받는 방식을 나누는 조건문. 체크박스 / 버튼
			if (oid != null) { // id가 버튼으로 넘어온 경우. (단일, 다중 동일메서드 처리를 위해 List로 양식을 통일했음.)
				System.out.println("id가 버튼으로 1개만 넘어옴.");
				idList.add(0, oid);
				result = mos.deleteOrders(idList);
				model.addAttribute("result", result);
				model.addAttribute("msg", +result + "개 수정 완료");
				System.out.println("1개만 삭제완료. : " + result);

			} else if (oid == null && ids != null) { // id가 체크박스를 통해 넘어온경우.
				System.out.println("id가 체크박스로 1개 or 여러개 넘어옴.");
				System.out.println("체크박스로 넘어온 ID의 갯수 : " + ids.length);
				idList = Arrays.asList(ids);
				result = mos.deleteOrders(idList);
				model.addAttribute("result", result);
				model.addAttribute("msg", +result + "개 수정 완료");
				System.out.println("여러명 삭제 완료 : " + result);
			}
		} else { // 모든값이 Null이라면.
			model.addAttribute("result", result);
			model.addAttribute("msg", "수정할 글을 선택하세요.");
			System.out.println("체크박스가 선택되지않음. " + result);

		}
		return "./master/review/masterReviewDelete";
	}

	@RequestMapping("masterOrdersSearch.do")
	public String masterOrdersSearch(Search search, Model model) {

		System.out.println(search.getKeyword());
		System.out.println(search.getSearchtype());

		String msg = "";
		int result = 0;
		if (search.getKeyword() != "" && search.getSearchtype() != "") {
			List<Orders> list = mos.searchOrdersList(search);
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

		return "master/orders/masterOrdersList";
	}

	// 문자전송을 방식을 검증
	@RequestMapping("masterOrdersSmsMove.do")
	public String masterOrdersSmsMove(Orders orders, OrderDetail orderDetail, String type, String odstatus, String oid,
			String odid, Model model) {
		System.out.println("masterOrdersSmsMove");
		System.out.println("전송타입 : " + type);
		System.out.println("리스트로 들어옴 OID  : " + oid);
		System.out.println("에이작스 버튼으로 들어옴 ODID : " + odid);
		System.out.println("배송상태가 어떤지 status : " + odstatus);

		// 값이 하나라도 있을경우 자유작성인지, 배송작성인지 메시지작성 타입을 정해주는 조건.
		if (((oid != null) && (type != null)) || // 자유작성인 경우 검증.
				((odid != null) && (type != null)) && (odstatus != null)) { // 배송작성인 경우 검증.

			if (type.equals("free")) { // 관리자의 임의작성인 경우.(oid)
				System.out.println("관리자 임의작성 메시지");
				orders = mos.selectOrders(oid);
				if (orders != null) { // oid를 기준으로 orders를 구해온경우.
					System.out.println("주문번호 : " + oid);
					System.out.println("보낼번호 : " + orders.getOphone());
					System.out.println("수령인 : " + orders.getOname());

					model.addAttribute("type", type);
					model.addAttribute("orders", orders);

					return "master/orders/masterOrdersSmsForm";
				}

			} else if (type.equals("delivery")) { // 배송탭인경우. (odid)
				System.out.println("배송메시지 작성");
				orderDetail = mos.selectOrderDetail(odid);
				Product product = mps.selectOne("" + orderDetail.getPid());
				String pname = product.getPname();
				switch (odstatus) {
				case "0": // 배송대기
					model.addAttribute("msg", "주문하신 " + pname + " 상품이 현재 출발하였습니다. \n구매에 진심으로 감사드립니다.\n-Boss_Mall-");
					model.addAttribute("result", "delevary" + odstatus);
					break;
				case "1": // 배송완료
					model.addAttribute("msg", "주문하신 " + pname + " 상품이 배송완료 되었습니다. \n구매에 진심으로 감사드립니다.\n-Boss_Mall-");
					model.addAttribute("result", "delevary" + odstatus);
					break;
				case "2": // 취소대기
					model.addAttribute("msg", "주문하신 " + pname + " 상품의 취소신청이 수락 되었습니다. \n-Boss_Mall-");
					model.addAttribute("result", "delevary" + odstatus);
					break;

				case "3": // 취소완료
					model.addAttribute("msg", "주문하신 " + pname + " 상품의 취소신청이 완료 되었습니다. \n-Boss_Mall-");
					model.addAttribute("result", "delevary" + odstatus);
					System.out.println("케이스 3");
					break;
				}
				System.out.println("스위치 빠져나옴");
				// 해당 주문상세를 공유함. (정보 출력용)
				model.addAttribute("type", type);
				model.addAttribute("orderDetail", mos.selectOrderDetail(odid));
				model.addAttribute("orders", mos.selectOrders(orderDetail.getOid() + ""));
				System.out.println("마지막 폰번 : " + mos.selectOrders(orderDetail.getOdid() + ""));
			}
		}
		return "master/orders/masterOrdersSmsForm";

	}

	// 문자 전송시 검증
	@RequestMapping("sendSms.do")
	public String sendSms(String type, String oid, String odid, Orders orders, Model model, HttpServletRequest request)
			throws Exception {
		System.out.println("sendSms");
		System.out.println("전송타입 : " + type);
		System.out.println("리스트로 들어옴 OID  : " + oid);
		System.out.println("에이작스 버튼으로 들어옴 ODID : " + odid);

		String ophone = request.getParameter("to"); // 수령인 휴대폰번호 (관리자 입력에 따라 바뀔 여지가 있음.)
		String msg = "";
		int resultMy = 0;
		orders = mos.selectOrders(oid);

		// ** 아래부턴 문자 API관련 메서드이다.**
		String api_key = "NCSRYPBYYEAXEHUI"; // 위에서 받은 api key를 추가
		String api_secret = "GQXOPEODU6IKF2VHTJCIUDAPOGS3BU2U"; // 위에서 받은 api secret를 추가

		// 이 부분은 홈페이지에서 받은 자바파일을 추가한다음 그 클래스를 import해야 쓸 수 있는 클래스이다.
		boss.common.Coolsms coolsms = new boss.common.Coolsms(api_key, api_secret);

		HashMap<String, String> set = new HashMap<String, String>();
		set.put("to", ophone); // 수신번호

		set.put("from", (String) request.getParameter("from")); // 발신번호, jsp에서 전송한 발신번호를 받아 map에 저장한다.
		set.put("text", (String) request.getParameter("text")); // 문자내용, jsp에서 전송한 문자내용을 받아 map에 저장한다.
		set.put("type", "sms"); // 문자 타입

		System.out.println(set);

		JSONObject result = coolsms.send(set); // 보내기&전송결과받기

		// 모든 인증과정을 통과한경우.

		if ((boolean) result.get("status") == true) {
			if (type.equals("free")) {
				System.out.println("문자전송 결과 : " + result.get("result_message")); // 결과 메시지
				resultMy = 1;
				msg = orders.getOname() + " 님에게" + " 문자를 전송하였습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("result", "free");
			} else if (type.equals("delivery")) {
				System.out.println("문자전송 결과 : " + result.get("result_message")); // 결과 메시지
				resultMy = 1;
				msg = orders.getOname() + " 님에게" + " 문자를 전송하였습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("orders", orders);
				model.addAttribute("result", "delivery");
			}

		} else { // 인증과정을 통과하지 못한경우.
			System.out.println("문자전송 결과 : " + result.get("result_message")); // 결과 메시지
			resultMy = -1;
			msg = orders.getOname() + " 님에게" + " 문자전송을 실패하였습니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("result", resultMy);
		}
		return "master/orders/masterOrdersSmsResult";

	}

}
