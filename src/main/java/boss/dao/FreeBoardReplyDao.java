package boss.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boss.model.FreeReply;

@Mapper
public interface FreeBoardReplyDao {

	List<FreeReply> freplylist(int fId);

	void insert(FreeReply frboard);

	void delete(int frId);

	void update(FreeReply frboard);

	int replyCount(int fId);

}
