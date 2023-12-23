package boss.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.common.PagePgm;
import boss.common.Search;
import boss.dao.MasterOrdersDao;
import boss.model.Member;
import boss.model.OrderDetail;
import boss.model.Orders;

@Service
public class MasterOrdersService {

	@Autowired
	private MasterOrdersDao dao;

	// 1개의 주문정보를 구함.
	public Orders selectOrders(String oid) {
		return dao.selectOrders(oid);
	}

	// 1개의 주문상세정보를 구함.
	public OrderDetail selectOrderDetail(String odid) {
		return dao.selectOrderDetail(odid);
	}

	// 총 주문정보의 갯수를 구함.
	public int total() {
		return dao.total();
	}

	// 페이징처리된 주문정보의 리스트를 구함.
	public List<Member> list(PagePgm pp) {
		return dao.list(pp);
	}

	// 3개의 테이블이 join된 정보를 구함.
	// oid를 기준으로 해당하는 총 product 리스트를 구함.
	public List<HashMap<String, Object>> listProduct(int oid) {
		return dao.listProduct(oid);
	}

	// 배송상태 변경.
	public int updateStatus(String odid, String odstatus) {
		return dao.updateStatus(odid, odstatus);
	}

	// oid를 기준으로 다중삭제.
	public int deleteOrders(List<String> idList) {
		return dao.deleteOrders(idList);
	}	
	// 주문내역 검색 유형별 검색
	public List<Orders> searchOrdersList(Search search) {
		return dao.searchOrdersList(search);
	}

}
