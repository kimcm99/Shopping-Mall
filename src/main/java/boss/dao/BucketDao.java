package boss.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.model.Bucket;

@Mapper
public interface BucketDao {

	// 장바구니 전체리스트 구하기(세션)
	List<Bucket> selectBucketList(String memail);
	
	// 장바구니 전체 리스트 구하기(bid) 오버로딩
	List<Bucket> selectAllBucketList(List<String> bidList);
	
	// 상품디테일 폼에서 장바구니 추가를 누를경우 장바구니 인서트
	int InsertCart(Map<String, Object> map);

	// 체크박스 1개 넘어온 경우
	int deleteCartOne(int id);

	// 체크박스가 배열로 넘어온 경우
	int deleteCartList(List<String> list);

	// 장바구니에 이미 pid가 일치하는 상품이 있을경우
	Bucket selectBucket(Map<String, Object> map);

	// 장바구니에 이미 pid가 일치하는 상품이 있을경우 수량 업데이트
	int updateCart(Map<String, Object> map);

	int updateBdrop(Map<String, Object> map);

	Bucket selectBucketOne(String bid);

	// String bid 로 장바구니 한개 구하기
	Bucket OneBucket(int bids);

	
  
}