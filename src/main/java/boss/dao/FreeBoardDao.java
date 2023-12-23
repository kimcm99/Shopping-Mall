package boss.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import boss.model.FreeBoard;

@Mapper
public interface FreeBoardDao {
	int insert(FreeBoard board);
	int listcount(FreeBoard board);
	List<FreeBoard> selectList(FreeBoard board);
	int readcount(int fId);
	FreeBoard getDetail(int fId);
	int update(FreeBoard board);
	int delete(int fId);
	int setLike(FreeBoard board);
}