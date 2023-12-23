package boss.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import boss.dao.ReportDao;
import boss.model.Report;

@Service
public class ReportService {
	@Autowired
	ReportDao dao;

	public int insert(Report report) {
		return dao.insert(report);
	}
}
