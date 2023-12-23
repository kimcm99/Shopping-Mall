package boss.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.OrdersDao;
import boss.model.Orders;

@Service
public class OrdersService {

	@Autowired
	OrdersDao dao;

	public int insertOrders(Orders orders) {
		return dao.insertOrders(orders);
	}

	public Orders selectOrdersOne(String memail) {
		return dao.selectOrdersOne(memail);
	}

	public int insertOrderDetail(Map<String, Object> map) {
		return dao.insertOrderDetail(map);
	}

	public int updateProductCount(Map<String, Object> map) {
		return dao.updateProductCount(map);
	}
}
