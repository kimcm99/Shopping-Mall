package boss.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import boss.common.PagePgm;
import boss.model.MasterNotice;

@Mapper
public interface MasterNoticeDao {

		int totalCount();

		List<MasterNotice> noticeList(PagePgm page);

		int noticeInsert(MasterNotice notice);

		void noticeDelete(int mnId);

		void updateMnReadCount(int i);

		MasterNotice selectOne(int mnId);

		void masterNoticeUpdate(MasterNotice mn);

		int noticeCount(PagePgm pp);

		List<MasterNotice> noticeSearchList(PagePgm pp);

		int noticeMax();

		MasterNotice selectMove(int rnum);

		MasterNotice searchMove(Map<String, Object> map);

		MasterNotice searchOne(Map<String, Object> map);

}
