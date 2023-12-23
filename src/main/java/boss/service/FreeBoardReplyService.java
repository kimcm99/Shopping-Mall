package boss.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.FreeBoardReplyDao;
import boss.model.FreeReply;

@Service
public class FreeBoardReplyService {
	
	@Autowired
	private FreeBoardReplyDao frdao;

	public List<FreeReply> freplylist(int fId) {
		return frdao.freplylist(fId);
	}

	public void insert(FreeReply frboard) {
		frdao.insert(frboard);
	}

	public void delete(int frId) {
		frdao.delete(frId);
	}

	public void update(FreeReply frboard) {
		frdao.update(frboard);
	}

	public int replyCount(int fId) {
		return frdao.replyCount(fId);
	}

	

}
