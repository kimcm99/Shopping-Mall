package boss.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import boss.model.Report;
import boss.service.ReportService;

@Controller
public class ReportController {

	@Autowired
	ReportService rs;

	// 신고 작성 폼 이동
	@RequestMapping("reportWriteForm.do")
	public String reportWriteForm(String pid, Report report, Model model) {
		System.out.println("reportWriteForm");
		String reporttype = report.getReporttype();
		String reportnum = "" + report.getReportnum();

		System.out.println("type : " + reporttype);
		System.out.println("reportnum : " + reportnum);

		if (reporttype.equals("review")) {
			model.addAttribute("Report", report);
			model.addAttribute("pid", pid);

		} else if (reporttype.equals("freeBoard")) {
			model.addAttribute("Report", report);
		}
		return "report/reportWriteForm";
	}

	// 신고 작성값 받음
	@RequestMapping("reportWrite.do")
	public String reportWrite(String pid, Report report, Model model, HttpServletRequest request,
			@RequestParam(value = "image1", required = false) MultipartFile mfile) throws Exception {
		System.out.println("reportWrite");
		int result = 0;
		String realFileName = mfile.getOriginalFilename();
		int size = (int) mfile.getSize();
		if (realFileName != null && realFileName != "") { // 파일이 있는경우
			String extension = realFileName.substring(realFileName.lastIndexOf("."), realFileName.length());
			System.out.println("파일이있음. : " + extension);
			if (size > 5000000) { // 이미지의 용량이 약 4MB를 초과한 경우.
				System.out.println("용량초과");
				model.addAttribute("result", 2);
				model.addAttribute("msg", "용량이 3MB 이상입니다.");
				return "report/reportWriteResult";
			} else if (!extension.equals(".jpg") && !extension.equals(".png") && !extension.equals(".jpeg")
					&& !extension.equals(".gif")) { // 이미지 형식이 올바르지 않은경우.
				System.out.println("이미지 형식 다름");
				model.addAttribute("result", 3);
				model.addAttribute("msg", "올바른 파일 형식이 아닙니다.");
				return "report/reportWriteResult";
			}
			UUID uuid = UUID.randomUUID();
			String newFileName = uuid + extension;
			report.setReportimage(newFileName);
			//String path = "C:\\gitBoss\\boss\\src\\main\\webapp\\uploadReport";
			String path = request.getRealPath("images");
			mfile.transferTo(new File(path + "/" + newFileName));
		}

		result = rs.insert(report);
		if (result == 1) { // 글 작성 true
			if (report.getReporttype().equals("review")) { // 리뷰에 글을썼을경우
				System.out.println("리뷰 글작성 성공");
				model.addAttribute("msg", "신고가 접수되었습니다.");
				model.addAttribute("resultType", "review_true");
				model.addAttribute("pid", pid);
				System.out.println("pid : " + pid);
				model.addAttribute("report", report);
			} else if (report.getReporttype().equals("freeBoard")) { // 프리보드에 글을썼을경우
				System.out.println("프리보드 글작성 성공");
				model.addAttribute("msg", "신고가 접수되었습니다.");
				model.addAttribute("resultType", "freeBoard_true");
				model.addAttribute("report", report);
			}
		} else { // 글 작성 false
			model.addAttribute("msg", "글 작성에 실패하였습니다.");
			model.addAttribute("resultType", "report_false");
		}

		return "report/reportWriteResult";
	}
}
