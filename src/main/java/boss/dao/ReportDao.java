package boss.dao;

import org.apache.ibatis.annotations.Mapper;

import boss.model.Report;

@Mapper
public interface ReportDao {

	int insert(Report report);

}
