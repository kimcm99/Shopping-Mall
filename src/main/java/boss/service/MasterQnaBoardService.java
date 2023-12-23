package boss.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.common.PagePgm;
import boss.common.Search;
import boss.dao.MasterQnaBoardDao;
import boss.model.QnaBoard;
import boss.model.QnaReply;

@Service
public class MasterQnaBoardService {

	@Autowired
	MasterQnaBoardDao dao;

	// 총qna게시글 갯수
	public int totalQnaCount() {
		return dao.totalQnaCount();
	}

	// 모든 qna게시글 조회
	public List<QnaBoard> selectQnaBoardList(PagePgm page) {
		// TODO Auto-generated method stub
		return dao.selectQnaBoardList(page);
	}

	/*
	 * Qna게시글 상세정보 구하기
	 */
	public QnaBoard selectQnaDetail(int id) {
		return dao.selectQnaDetail(id);
	}

	// qna답글 인서트
	public int insertReply(Map<String, Object> map) {
		return dao.insertReply(map);
	}

	/*
	 * 댓글 상세정보 1개 구하기 메소드
	 */
	public QnaReply selectReplyOne(int id) {
		return dao.selectReplyOne(id);
	}

	public int deleteQna(List<String> idList) {
		return dao.deleteQna(idList);
	}

	// qnaBoard 답변 상태 'Y'변겅
	public int updateQnaBoardReplyYn(int id) {
		return dao.updateQnaBoardReplyYn(id);

	}

	// qna답글 수정 하기
	public int updateQnaReply(Map<String, Object> map) {
		return dao.updateQnaReply(map);
	}

	// qna게시글 삭제('Y') 업데이트 메소드
	public int deleteQnaBoard(int id) {
		return dao.deleteQnaBoard(id);
	}

	// qna 게시글 유형별 검색 메소드
	public List<QnaBoard> searchQnaList(Search search) {
		return dao.searchQnaList(search);
	}
}
