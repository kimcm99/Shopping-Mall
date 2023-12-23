package boss.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import boss.model.Bucket;
import boss.model.Member;
import boss.model.Product;
import boss.service.BucketService;
import boss.service.MasterProductService;

@Controller
public class BucketController {
	
	@Autowired
	private BucketService service;
	@Autowired
	private MasterProductService mp;
	
	/*
	 * 장바구니 폼 이동 메소드
	 */
	@RequestMapping("cartFormMove.do")
	public String cartFormMove(HttpSession session,
			@RequestParam(value = "pid", required = false, defaultValue = "0") String pid, String quantity,Model model) {
		
		Member member = (Member)session.getAttribute("member");
		String memail = member.getmEmail();
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("memail", memail);
		
		// 상품 디테일에서 장바구니로 올 경우
		if(!pid.equals("0")) {
			Product product = mp.selectOne(pid);
			map.put("product", product);
			map.put("quantity", quantity);
			map.put("pid", pid);
			// 장바구니에 이미 pid가 일치하는 상품이 있을경우
			Bucket bucket = service.selectBucket(map);
			if(bucket != null) {
				// 상품 수량 업데이트
				if(bucket.getBdrop().equals("N")) {
					model.addAttribute("msg", "같은 상품이 담겨있습니다, 수량이 추가 됩니다.");
					int updateCart = service.updateCart(map);
					return "bucket/bucketMoveForm";
				}else {
					// pid가 일치하는 상품이 있고 삭제된 상태이면
					int updateBdrop = service.updateBdrop(map);
				}
			}else {
				// 상품 인서트
				int InsertCart = service.InsertCart(map);
			}
		}
		
		List<Bucket> list = service.selectBucketList(memail);
		
		// 총 결제 금액 구하기
		int totalPrice = 0;
		
		for(int i = 0; i < list.size(); i++) {
				Bucket b = list.get(i);
				if(b.getBdrop().equals("N")) {
					int price = b.getBprice();
					int count = b.getBcount();
					totalPrice += price * count;
				}
			
		}
		
		model.addAttribute("list", list);
		model.addAttribute("totalPrice", totalPrice);
		
		return "bucket/bucketList";
	}
	
	@RequestMapping("cartListDelete.do")
	public String cartListDelete(String bid,Model model,HttpServletRequest request) {
		int result = 0;
		List<String> list = new ArrayList<String>();
		String[] str = request.getParameterValues("bidAll");
		if((bid != null) || (str != null)) {
			System.out.println("bid : " + bid);
			System.out.println("checkOne : " + request.getParameterValues("bidAll"));
			if((bid != null) && (str == null)) {
				// 1개 or 여러개
				int id = Integer.parseInt(bid);
				result = service.deleteCartOne(id);
			}else if((bid == null) && (str != null)) {
				list = Arrays.asList(str);
				result = service.deleteCartList(list);
			}
			
		}else {
			model.addAttribute("resultCheck", "checkBoxNull");
			model.addAttribute("resultMsg", "삭제할 사항을 선택해 주세요.");
			return "master/product/masterMoveProductList";
		}
		
		return "redirect:/cartFormMove.do";
	}
	
}
























