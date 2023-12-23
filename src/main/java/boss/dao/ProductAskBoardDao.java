package boss.dao;

import org.apache.ibatis.annotations.Mapper;

import boss.model.AskBoard;
import boss.model.AskReply;

@Mapper
public interface ProductAskBoardDao {
	
	// 문의등록
	int askinsert(AskBoard askboard);
	
	// 문의 불러오기
	AskBoard askselect(int askid);
	
	// 문의 수정
	int askboardupdate(AskBoard askboard);
	
	// 문의 삭제
	int askdelete(String askid);
	
	// 문의 댓글 불러오기
	AskReply arselect(int askid);


	
	
}
