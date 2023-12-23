package boss.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Amount;
import boss.model.MainImage;


import boss.model.Member;
import boss.model.Product;

@Mapper
public interface MasterProductDao {

	// 총상품 갯수
	int totalCount();

	// 페이징 처리된 상품 리스트
	List<Product> selectList(PagePgm page);

	// 상품 상세정보 구하기
	Product selectOne(String id);

	// 상품 등록 하기
	int productInsert(Product product);

	Product odidList(String odid);

	// 상품 수정 하기
	int updateProduct(Product product);

	// 재고 구하기
	Amount selectAmount(String id);

	// 상품 등록 시 재고 갯수 추가 하기
	int amountInsert(Map map);

	// 페이징 값 없는 상품 리스트 구하기
	Product changeList();

	// 검색 전체 목록 구하기
	List<Product> searchList(Search search);

	// 상품 수정 시 재고수량 업데이트 하기
	int updateAmount(Map map);

	// 상품 전체 삭제('Y') 업데이트
	int deleteProduct(List<String> pidList);

	// 구매이력이 있는 회원정보 구해오기.
	List<Member> selectMemberOfProduct(String id);


	// 메인 이미지 출력 리스트 구하기
	List<MainImage> selectMainProductList();

	int updateMainImageInsert(Map<String, Object> map);

	// 상품 상세정보 구하기(int)
	Product selectProductOne(int pids);

	// 메인 이미지 변경하기
//	int updateMainImageInsert(@Param("product") Product product, @Param("block") String block);

}



