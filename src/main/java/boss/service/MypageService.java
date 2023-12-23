package boss.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.MypageDao;
import boss.model.AskBoard;
import boss.model.OrderDetail;
import boss.model.Orders;
import boss.model.QnaBoard;
import boss.model.QnaReply;
import boss.model.Report;
import boss.model.Review;

@Service
public class MypageService {

	@Autowired
	private MypageDao dao;

	public List<Orders> myoders(String mEmail) {
		return dao.myoders(mEmail);
	}

	public String statusMsg(int odstatus) {
		switch (odstatus) {
		case 0:
			return "배송 대기";
		case 1:
			return "배송 완료";
		case 2:
			return "환불 처리중";
		case 3:
			return "환불 완료";
		default:
			return "관리자에게 문의";
		}
	}

	public List<Review> myreviews(String mEmail) {
		return dao.myreviews(mEmail);
	}

	public List<QnaBoard> myqnas(Map<String, Object> search) {
		return dao.myqnas(search);
	}

	public int mypageDeleteReview(String rid) {
		return dao.mypageDeleteReview(rid);
	}

	public int refund(String odid) {
		return dao.refund(odid);
	}

	public OrderDetail myorderDetail(String odid) {
		return dao.myorderDetail(odid);
	}

	public List<HashMap<String, Object>> listProduct(Map<String,Object> map) {
		return dao.listProduct(map);

	}

	public Orders myorders(String mEmail) {
		return dao.myorders(mEmail);
	}

	public List<Map<String, Object>> productlist(String mEmail) {
		return dao.productlist(mEmail);
	}

	public int qnaInsert(QnaBoard board) {

		return dao.qnaInsert(board);
	}

	public QnaBoard selectQna(int qid) {

		return dao.selectQna(qid);
	}

	public int totalCount(String mEmail) {

		return dao.totalCount(mEmail);
	}

	public QnaReply selectReply(int qrid) {

		return dao.selectReply(qrid);
	}

	public int findQrid(int qid) {

		return dao.findQrid(qid);
	}

	public void qnaDelete(int qid) {

		dao.qnaDelete(qid);
	}

	public void replyDelete(int qid) {

		dao.replyDelete(qid);
	}

	public List<Report> listReport(String mEmail) {
		return dao.listReport(mEmail);
	}

	public Report oneReport(String reportid) {
		return dao.oneReport(reportid);
	}

}
