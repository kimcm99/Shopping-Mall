package boss.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.ProductAskBoardDao;
import boss.model.AskBoard;
import boss.model.AskReply;

@Service
public class ProductAskBoardService {

	@Autowired
	ProductAskBoardDao dao;
	
	// 상품문의 등록
	public int askinsert(AskBoard askboard) {
		return dao.askinsert(askboard);
	}
	
	// 상품 문의 불러오기
	public AskBoard askselect(int askid) {
		return dao.askselect(askid);
	}
	
	// 상품 수정
	public int askboardupdate(AskBoard askboard) {
		return dao.askboardupdate(askboard);
	}
	
	// 문의 삭제
	public int askdelete(String askid) {
		return dao.askdelete(askid);
	}
	
	// 문의 댓글 불러오기 
	public AskReply arselect(int askid) {
		return dao.arselect(askid);
	}


}
