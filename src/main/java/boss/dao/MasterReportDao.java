package boss.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.Report;

@Mapper
public interface MasterReportDao {
	
	Report selectOne(String reportId);

	int update(Report report);

	int getTotal(Report report);

	// 게시물 총 갯수
	int total();

	// 페이징 처리 게시글 조회
	List<Report> list(PagePgm pp);

	int deleteReport(List<String> idList);
	
	// 리뷰 유형별 검색
	List<Report> searchReportList(Search search);

	

}
