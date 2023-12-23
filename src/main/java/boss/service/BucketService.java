package boss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.BucketDao;
import boss.model.Bucket;

@Service
public class BucketService {

	@Autowired
	private BucketDao dao;

	// 장바구니 전체 리스트 구하기(세션)
	public List<Bucket> selectBucketList(String memail) {
		return dao.selectBucketList(memail);
	}
	
	// 장바구니 전체 리스트 구하기(bid) 오버로딩
	public List<Bucket> selectAllBucketList(List<String> bidList) {
		return dao.selectAllBucketList(bidList);
	}

	// 상품디테일 폼에서 장바구니 추가를 누를경우 장바구니 인서트
	public int InsertCart(Map<String, Object> map) {
		return dao.InsertCart(map);
	}

	// 체크박스 1개 넘어온 경우
	public int deleteCartOne(int id) {
		return dao.deleteCartOne(id);
	}

	// 체크박스가 배열로 넘어온 경우
	public int deleteCartList(List<String> list) {
		return dao.deleteCartList(list);
	}

	// 장바구니에 이미 pid가 일치하는 상품이 있을경우
	public Bucket selectBucket(Map<String, Object> map) {
		return dao.selectBucket(map);
	}

	// 장바구니에 이미 pid가 일치하는 상품이 있을경우 수량 업데이트
	public int updateCart(Map<String, Object> map) {
		return dao.updateCart(map);
	}

	public int updateBdrop(Map<String, Object> map) {
		return dao.updateBdrop(map);
	}
	
	// 결제폼 이동 전 bid일치하는 장바구니 한개 구함.
	public Bucket selectBucketOne(String bid) {
		return dao.selectBucketOne(bid);
	}

	// String bid 로 장바구니 한개 구하기
	public Bucket OneBucket(int bids) {
		return dao.OneBucket(bids);
	}

	

}
