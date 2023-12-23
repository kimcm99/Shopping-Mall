package boss.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Review;

@Mapper
public interface MasterReviewDao {
	
	Review selectOne(String rid);

	int update(Review review);

	int getTotal(Review review);

	// 게시물 총 갯수
	int total();

	// 페이징 처리 게시글 조회
	List<Review> list(PagePgm vo);

	int deleteReview(List<String> idList);
	// 리뷰 유형별 검색
	List<Review> searchReviewList(Search search);

	

}
