package boss.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.common.PagePgm;
import boss.common.Search;
import boss.dao.MasterReviewDao;
import boss.model.Review;

@Service
public class MasterReviewService {
	@Autowired
	private MasterReviewDao dao;

	public Review selectOne(String rid) {
		return dao.selectOne(rid);
	}

	public int total() {
		return dao.total();
	}

	public List<Review> list(PagePgm pp) {
		return dao.list(pp);
	}

	public int update(Review review) {
		return dao.update(review);
	}


	public int deleteReview(List<String> idList) {
		return dao.deleteReview(idList);
	}
	

	// 리뷰 유형별 검색
	public List<Review> searchReviewList(Search search) {
		return dao.searchReviewList(search);
	}
}
