package boss.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.common.Search;
import boss.model.QnaBoard;
import boss.model.QnaReply;

@Mapper
public interface MasterQnaBoardDao {

	// 총qna게시글 갯수
	int totalQnaCount();

	// 모든 qna게시글 조회
	List<QnaBoard> selectQnaBoardList(PagePgm page);

	// Qna 게시글 상세정보 구하기
	QnaBoard selectQnaDetail(int id);

	// qna 답글 저장
	int insertReply(Map<String, Object> map);

	// 댓글 상세 1개 구하기 
	QnaReply selectReplyOne(int id);

	int deleteQna(List<String> idList);
	// qnaBoard 답변 상태 'Y'변겅
	int updateQnaBoardReplyYn(int id);

	// qna답글 수정 하기
	int updateQnaReply(Map<String, Object> map);

	// qna 게시글 삭제('Y') 업데이트 하기
	int deleteQnaBoard(int id);

	// 상품 유형별 검색 메소드
	List<QnaBoard> searchQnaList(Search search);

}
