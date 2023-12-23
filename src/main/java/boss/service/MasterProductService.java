package boss.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.common.PagePgm;
import boss.common.Search;
import boss.dao.MasterProductDao;
import boss.model.Amount;
import boss.model.MainImage;

import boss.model.Member;
import boss.model.Product;

@Service
public class MasterProductService {

	@Autowired
	MasterProductDao dao;

	// 총상품 갯수 구하기
	public int totalCount() {
		return dao.totalCount();
	}

	// 페이징 처리된 리스트 구하기
	public List<Product> selectList(PagePgm page) {
		return dao.selectList(page);
	}

	// 상품 상세정보 구하기
	public Product selectOne(String id) {
		return dao.selectOne(id);
	}

	/*
	 * 상품 등록 하기
	 */
	public int productInsert(Product product) {
		System.out.println("서비스까진 왔어");
		return dao.productInsert(product);
	}

	/*
	 * 상품 수정 하기
	 */
	public int updateProduct(Product product) {
		return dao.updateProduct(product);
	}

	/*
	 * 재고 구하기
	 */
	public Amount selectAmount(String id) {
		// TODO Auto-generated method stub
		return dao.selectAmount(id);
	}

	/*
	 * 상품 등록 시 재고 수량 저장
	 */
	public int amountInsert(Map map) {
		return dao.amountInsert(map);
	}

	/*
	 * 페이징 필요없는 상품 리스트 구하기
	 */
	public Product changeList() {

		return dao.changeList();
	}

	/*
	 * 상품 검색 목록 구하기
	 */
	public List<Product> searchList(Search search) {

		return dao.searchList(search);
	}

	/*
	 * 상품 수정 시 재고수량 업데이트 하기
	 */
	public int updateAmount(Map map) {
		return dao.updateAmount(map);
	}

	// 회원 전체 삭제('Y') 업데이트
	public int deleteProduct(List<String> id) {

		return dao.deleteProduct(id);
	}

	// 구매이력이 있는 회원정보 구해오기.
	public List<Member> selectMemberOfProduct(String id) {
		return dao.selectMemberOfProduct(id);
	}

	// 메인 이미지 리스트 구하기
	public List<MainImage> selectMainProductList() {
		return dao.selectMainProductList();
	}

//	// 메인 이미지 변경
//	public int updateMainImageInsert(Product product, String block) {
//		return dao.updateMainImageInsert(product,block);
//	}

	public int updateMainImageInsert(Map<String, Object> map) {
		return dao.updateMainImageInsert(map);
	}

	// 상품 상세정보 구하기(int)
	public Product selectProductOne(int pids) {
		return dao.selectProductOne(pids);
	}

}