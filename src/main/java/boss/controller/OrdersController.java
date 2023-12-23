package boss.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import boss.model.Bucket;
import boss.model.Member;
import boss.model.Orders;
import boss.model.Product;
import boss.service.BucketService;
import boss.service.MasterProductService;
import boss.service.OrdersService;

@Controller
public class OrdersController {

	@Autowired
	OrdersService os;
	@Autowired
	MasterProductService mps;
	@Autowired
	BucketService bs;

	/*
	 * 결제하기 이동 메소드
	 */
	@RequestMapping("ordersForm.do")
	public String ordersForm(Member member, Model model,String pid, String bid, String mEmail, String omessage, String amountCount,
			HttpServletRequest request) {
		System.out.println("ordersForm");
		System.out.println("ordersForm bid : " + bid);
		String[] bidAll = request.getParameterValues("bidAll");
		System.out.println("bidAll :" + bidAll);
		List<String> bidList = new ArrayList<String>();

		int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
		
		// 바로 구매하기로 넘어옴
		if((bid == null || bid == "") && (bidAll == null)) {
			Product product = mps.selectOne(pid);
			System.out.println("바로 구매하기로 넘어옴");
			model.addAttribute("pid", pid);
			model.addAttribute("product", product);
			model.addAttribute("amountCount", amountCount);
			model.addAttribute("member", member);
			model.addAttribute("omessage", omessage);
			model.addAttribute("totalPrice", totalPrice);
			
			return "orders/oneOrdersForm";
		}

		if ((bid != null && bid != "") || (bidAll != null)) { // 값이 뭐라도 한개있음
			if ((bid != null && bid != "") && (bidAll == null)) { // 값이 단일값임
				Product product = mps.selectOne(pid);
				System.out.println("1");
				//bidList.add(0, bid);
				model.addAttribute("name", product.getPname());
				model.addAttribute("bidList", bidList);
				model.addAttribute("pid", pid);
				model.addAttribute("bid", bid);
				model.addAttribute("amountCount", amountCount);

			} else if ((bid == null || bid == "") || (bidAll != null)) { // 값이 여러개임
				Bucket bbucket = bs.OneBucket(Integer.parseInt(bidAll[0]));
				System.out.println("2");
				
				bidList = Arrays.asList(bidAll);
				model.addAttribute("bidList", bidList);
				model.addAttribute("name", bbucket.getBname());
				model.addAttribute("amountCount", amountCount);
			}
		} else { // 값이 없음
			System.out.println("3");
		}

		// model.addAttribute("bucket", bucket);

		if (bidList != null) {
			member.setmName(mEmail);
		} else {
			System.out.println("bucket null : " + bidList);
		}

		model.addAttribute("member", member);
		model.addAttribute("omessage", omessage);
		model.addAttribute("totalPrice", totalPrice);

		return "orders/ordersForm";
	}

	/*
	 * 결제 폼 이동 메소드
	 */
	@RequestMapping("moveOrdersForm.do")
	public String moveOrdersForm(Bucket bucket, String quantity,String bid, String pid, HttpServletRequest request, HttpSession session,
			Model model) {
		System.out.println("moveOrdersForm");
		int result = 0 ,amountCount = 0;
		int totalPrice = 0;

		List<String> bidList = new ArrayList<String>();
		List<Bucket> bucketList = new ArrayList<Bucket>();
		String[] bids = request.getParameterValues("bidAll");
		Member member = (Member) session.getAttribute("member");
		System.out.println("요기요기요기");
		
		if(quantity == null && pid == null && bids == null && bid == null) {
			model.addAttribute("notBucket", "1");
			return "bucket/bucketMoveForm";
		}

		if (((bid != null && pid != null) && (bid != "" && pid != "")) || (bids != null)) { // 두 값이 전부 들어온경우.

			if ((bid != null && pid != null) && (bid != "" && pid != "")) { // 값이 단일값으로 들어온경우.

				String msg = "";
				bucket = bs.selectBucketOne(bid);
				totalPrice = bucket.getBprice() * bucket.getBcount();
				result = 0;
				amountCount = bucket.getBcount();
				model.addAttribute("bucket", bucket);
				model.addAttribute("member", member);
				model.addAttribute("result", result);
				model.addAttribute("pid", pid);
				model.addAttribute("bid", bid);
				model.addAttribute("amountCount", amountCount);
				System.out.println("버튼으로 들어옴 bid : " + bid);
				model.addAttribute("totalPrice", totalPrice);
			}

			else if (bids != null) { // 값이 체크박스로 들어옴.
				bidList = Arrays.asList(bids);
				bucketList = bs.selectAllBucketList(bidList);
				result = 1;
				System.out.println("체크박스로 들어옴 bid여러개  : " + bids.length);
				model.addAttribute("bucket", bucket);
				model.addAttribute("bucketList", bucketList);
				model.addAttribute("member", member);
				model.addAttribute("result", result);
				model.addAttribute("pid", pid);
				model.addAttribute("bid", bid);
				System.out.println("메서드 실행 후, : " + bucketList.size());
				for (int i = 0; i < bucketList.size(); i++) {
					amountCount++;
					totalPrice += bucketList.get(i).getBprice() * bucketList.get(i).getBcount();
					model.addAttribute("totalPrice", totalPrice);
				}
				model.addAttribute("amountCount", amountCount);
			}
		} else { // 상품 상세정보에서 바로 구매하기를 눌렀을 경우
			System.out.println("상품 상세정보에서 바로 구매하기를 눌렀을 경우");
			System.out.println("quantity : " + quantity);
			System.out.println("pid : " + pid);
			result = 2;
			Product product = mps.selectOne(pid);
			totalPrice = Integer.parseInt(quantity) * product.getPprice();
			model.addAttribute("member", member);
			model.addAttribute("product", product);
			model.addAttribute("result", result);
			model.addAttribute("pid", pid);
			model.addAttribute("totalPrice", totalPrice);
			model.addAttribute("amountCount", Integer.parseInt(quantity));
		}

		return "./orders/moveOrdersForm";
	}

	/*
	 * 주문 정보 db 저장
	 */
	@ResponseBody
	@RequestMapping("orderResult.do")
	public String orderResult(String mEmail, String bid, String amountCount,
			Orders orders, String pid, String bcount,String omessage, 
			HttpSession session,@RequestParam Map<String, List<String>> bidList) {
		System.out.println("orderResult");
		System.out.println("bidList : " + bidList);
		Member member = (Member) session.getAttribute("member");
		Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("orders : " + orders);
			System.out.println("orderResult bid : " + bid);
		if (orders != null) {
			orders.setMemail(mEmail);
			orders.setOname(member.getmName());
			if(bid != "") {
				int result = os.insertOrders(orders);
				if (result == 1) {
					System.out.println("단일값으로 넘어옴 bid");
					orders = os.selectOrdersOne(orders.getMemail());
					Product product = mps.selectOne(pid);
					map.put("product", product);
					map.put("oid", orders.getOid());
					map.put("amountCount", amountCount);
					int insertOrderDetail = os.insertOrderDetail(map);
					int id = Integer.parseInt(bid);
					int bucket = bs.deleteCartOne(id);
					map.put("pid", pid);
					int productCount = os.updateProductCount(map);
				}
			}else if(bid == "") {
				orders.setMemail(mEmail);
				orders.setOname(member.getmName());
				JSONObject jsonObject = new JSONObject(bidList);
				String s = (String)jsonObject.get("bidList");
				System.out.println(s);
				s = s.substring(2, s.length() - 2);
				String[] f = s.split(", ");
				int result = os.insertOrders(orders);
				for(int i = 0; i < f.length; i++) {
					System.out.println("*");
					System.out.println("f[i] : " + f[i]);
					Bucket bucket = bs.selectBucketOne(f[i]);
					int pids = bucket.getPid();
					orders = os.selectOrdersOne(orders.getMemail());
					
					Product product = mps.selectProductOne(pids);
					map.put("product", product);
					map.put("oid", orders.getOid());
					map.put("amountCount", amountCount);
					int insertOrderDetail = os.insertOrderDetail(map);
					int bucketDel = bs.deleteCartOne(Integer.parseInt(f[i]));
					map.put("pid", pids);
					int productCount = os.updateProductCount(map);
				}
			}
		} 

		// map.

		return "hi";
	}
	
	@ResponseBody
	@RequestMapping("oneOrderResult.do")
	public String oneOrderResult(String mEmail, String amountCount,Orders orders, String pid,String omessage,HttpSession session) {
		System.out.println("단일 결제");
		Map<String, Object> map = new HashMap<String, Object>();
		Member member = (Member) session.getAttribute("member");
		orders.setMemail(member.getmEmail());
		orders.setOname(member.getmName());
		System.out.println("구매자 : " + orders.getOname());
		int result = os.insertOrders(orders);
		orders = os.selectOrdersOne(orders.getMemail());
		Product product = mps.selectOne(pid);
		map.put("product", product);
		map.put("oid", orders.getOid());
		map.put("amountCount", amountCount);
		int insertOrderDetail = os.insertOrderDetail(map);
		map.put("pid", pid);
		int productCount = os.updateProductCount(map);
		
		System.out.println("구매 완료");
		
		return "hi";
	}
}






















