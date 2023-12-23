package boss.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Member;
import boss.model.OrderDetail;
import boss.model.Orders;

@Mapper
public interface MasterOrdersDao {

	// 1개의 주문정보를 구함.
	Orders selectOrders(String oid);

	// 1개의 주문상세정보를 구함.
	OrderDetail selectOrderDetail(String odid);

	// 총 주문정보의 갯수를 구함.
	int total();

	// 페이징처리된 주문정보의 리스트를 구함.
	List<Member> list(PagePgm pp);

	// 3개의 테이블이 join된 정보를 구함.
	// oid를 기준으로 해당하는 총 product 리스트를 구함.
	List<HashMap<String, Object>> listProduct(int oid);

	List<Orders> searchOrdersList(Search search);

	// oid를 기준으로 다중삭제.
	int delete(List<String> idList);

	// 배송상태 변경 (Map사용 않기위해 @Param붙힘)
	int updateStatus(@Param("odid") String odid, @Param("odstatus") String odstatus);

	// 다중삭제.
	int deleteOrders(List<String> idList);

}
