package boss.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.model.Orders;

@Mapper
public interface OrdersDao {

	int insertOrders(Orders orders);

	Orders selectOrdersOne(String memail);

	int insertOrderDetail(Map<String, Object> map);

	int updateProductCount(Map<String, Object> map);

}
