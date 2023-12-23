package boss.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.model.AskBoard;
import boss.model.Orders;
import boss.model.Product;
import boss.model.QnaBoard;
import boss.model.Review;

@Mapper
public interface ProductDetailDao {

	

	

	Product selectProduct(String pid);

	// 내가 쓴 review 구해오기
	List<Review> selectReviewOne(Map<String, Object> map);
	
	
	// 리뷰 불러오기
	Review prselect(int rid);
	
	// 문의 합계
	int total(String pid);
	
//	페이징 처리
	List<Review> list(Map<String, Object> map);

//  리뷰 memail 뽑기	

	List<Review> selectMemberReview(String memail);

	// 리뷰 작성 
	int reviewInsert(Review review);

	Orders selectOrders(String mEmail);
	
	// order
	List<Orders> selectlist(String mEmail);

	Review rcheck(int oid);
	
	// review 업데이트
	int reviewupdate(Review review);
	
	// ask리스트 불러오기 
	List<AskBoard> asklist(Map<String, Object> map);
	
	// 리뷰 등록 pid 불러오기 
	List<Map<String, Object>> plist(String mEmail);
	// 문의 합계
	int asktotal(String pid);
	



//	int insert(int rid);

}
