package boss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.common.PagePgm;
import boss.dao.ProductDetailDao;
import boss.model.AskBoard;
import boss.model.Orders;
import boss.model.Product;
import boss.model.QnaBoard;
import boss.model.Review;

@Service
public class ProductDetailService {

	@Autowired
	ProductDetailDao dao;
	// 상품 불러오기 
	public Product selectProduct(String pid) {
		return dao.selectProduct(pid);
	}
	// 내가 적은 리뷰 갯수 구하기 
	public List<Review> selectReviewOne(Map<String, Object> map) {
		return dao.selectReviewOne(map);
	}
	// 리뷰 상세 불러오기
	public Review prselect(int rid) {
		return dao.prselect(rid);
	}
	// 페이징 처리 합
	public int total(String pid) {
		return dao.total(pid);
	}
	// 리뷰 페이징
	public List<Review> list(Map<String, Object> map) {
		return dao.list(map);
	}
	// 리뷰 작성 리스트
	public List<Review> selectMemberReview(String memail) {

		return dao.selectMemberReview(memail);
	}
	
	// 리뷰 작성 

	public int reviewInsert(Review review) {
		return dao.reviewInsert(review);
	}
	
	// 리뷰 작성 시 주문 결과 확인
	public List<Orders> selectlist(String mEmail) {
		return dao.selectlist(mEmail);
	}
	// review 테이블에 oid를 가지고 리뷰를 썻는지 확인 
	public Review rcheck(int oid) {
		return dao.rcheck(oid);
	}
	
	// 리뷰 수정
	public int reviewupdate(Review review) {
		return dao.reviewupdate(review);
	}
	// 문의 리스트 가졍괴 
	public List<AskBoard> asklist(Map<String, Object> map) {
		return dao.asklist(map);
	}
	
	// 리뷰 등록 pid 불러오기 (수정) 
	public List<Map<String, Object>> plist(String mEmail) {
		return dao.plist(mEmail);
	}
	// 문의 합계
	public int asktotal(String pid) {
		return dao.asktotal(pid);
	}

	

	
	
	

//	public int insert(int rid) {
//		return dao.insert(rid);
//	}

}
