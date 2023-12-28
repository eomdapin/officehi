package com.groupware.officehi.controller.admin;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.groupware.officehi.controller.LoginController.SessionConst;
import com.groupware.officehi.domain.Paging;
import com.groupware.officehi.dto.EmployeeDTO;
import com.groupware.officehi.dto.FileDTO;
import com.groupware.officehi.dto.LoginUserDTO;
import com.groupware.officehi.dto.PagingDTO;
import com.groupware.officehi.service.EmployeeService;
import com.groupware.officehi.service.LoginService;

import lombok.RequiredArgsConstructor;

/**
 * @author 박재용
 * @editDate 23.12.20 ~ 23.12.22 페이지네이션 기능 추가 23.12.23 ~ 23.12.25
 */

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/employees")
public class AdminEmployeeController {

	private final EmployeeService employeeService;
	private final LoginService loginService;
	
	private int employeesTotal = -1; // 전체 직원데이터 수 조회용 캐싱데이터
	
	public LoginUserDTO loginUser = null;

	// 로그인 검증
	public boolean loginCheck(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession(false);
		if (session == null)
			return true;
		
		this.loginUser = (LoginUserDTO) session.getAttribute(SessionConst.LOGIN_MEMBER);
		if (loginUser == null)
			return true;
		
		model.addAttribute("loginUser", loginUser);
		return false;
	}

	@GetMapping
	public String employeeList(Paging paging, HttpServletRequest request, Model model) {
		if (loginCheck(request, model))
			return "redirect:/login";
		
		if (loginUser.getAdmin() != 1)
			return "alert/alert";	
		
		List<EmployeeDTO> employees = employeeService.findAllPagingEmployee(paging);
		model.addAttribute("employees", employees);
		model.addAttribute("pageMarker", new PagingDTO(paging, employeeService.findAllEmployee().size()));

		return "admin/employees/employeeTotal";
	}

	@PostMapping("/search")
	public String findByUserName(@RequestParam("searchType") String searchType,
			@RequestParam(name = "name", required = false) String name,
			@RequestParam(name = "userNo", required = false) Long uesrNo,
			@RequestParam(name = "deptName", required = false) String deptName, Paging paging, Model model) {
		List<EmployeeDTO> employees = null;

		if ("name".equals(searchType)) {
			employees = employeeService.searchUserName(name, paging);
		} else if ("userNo".equals(searchType)) {
			employees = employeeService.searchUserNo(uesrNo);
		} else if ("deptName".equals(searchType)) {
			employees = employeeService.searchDeptName(deptName);
		}
		model.addAttribute("employees", employees);
		model.addAttribute("pageMarker", new PagingDTO(paging, employeesTotal));
		return "admin/employees/employeeTotal";
	}

	@GetMapping("/add")
	public String employeeAddForm(@ModelAttribute EmployeeDTO employee, Model model) {
		EmployeeDTO lastUser = new EmployeeDTO();
		List<EmployeeDTO> empList = employeeService.findAllEmployee();
		if (!empList.isEmpty())
			lastUser = empList.get(empList.size() - 1);
		else
			lastUser.setUserNo(9999L);
		model.addAttribute("lastUserNo", lastUser.getUserNo() + 1);
		model.addAttribute("employee", employee);
		return "admin/employees/employeeAddForm";
	}

	@PostMapping("/add")
	public String employeeAdd(@Valid @ModelAttribute EmployeeDTO employeeDTO, BindingResult bindingResult, 
							@RequestParam("profile") MultipartFile profileMultipartFile, 
							@RequestParam("stamp") MultipartFile stampMultipartFile,
							Model model,
							HttpServletRequest req) {
		if(bindingResult.hasErrors())
			return "admin/employees/employeeAddForm";
		
		// file외 user 정보 저장
		employeeService.insertUserInfo(employeeDTO);
		// login 권한 부여
		loginService.saveUserInfo(employeeDTO.getUserNo());
		
		// file 저장
		FileDTO fileDTO = new FileDTO();
		fileDTO.setUserNo(employeeDTO.getUserNo());
		
		// profile 증명사진 저장
		fileDTO.setMultipartFile(profileMultipartFile);
		fileDTO.setFileTypeNo("1");
		employeeService.insertFileInfo(fileDTO);

		// stamp 인감 저장
		fileDTO.setMultipartFile(stampMultipartFile);
		fileDTO.setFileTypeNo("2");
		employeeService.insertFileInfo(fileDTO);
		
		
		model.addAttribute("employeeDTO", employeeDTO);

		return "redirect:/admin/employees";
	}

	@GetMapping("/{userNo}")
	public String employeeDetail(@PathVariable Long userNo, Model model) {
		// 유저 정보
		Optional<EmployeeDTO> employee = employeeService.findUserInfoByUserNo(userNo);
		if (employee.get().getFromDate().equals("9999-01-01")) {
			employee.get().setFromDate("-");
		}
		model.addAttribute("employee", employee.get());
		
		// 파일 정보
		Optional<FileDTO> profileFile = employeeService.findProfileFileByUserNo(userNo);
		model.addAttribute("profileFile", profileFile.get());
		Optional<FileDTO> stampFile = employeeService.findStampFileByUserNo(userNo);
		model.addAttribute("stampFile", stampFile.get());
		
		return "admin/employees/employeeDetail";
	}

	@PostMapping("/{userNo}")
	public String employeeInfoEdit(@PathVariable Long userNo, @ModelAttribute EmployeeDTO employeeDTO) {
		employeeService.updateUserInfo(employeeDTO);
		return "redirect:/admin/employees";
	}

	@PostMapping("/{userNo}/retired")
	public String employeeInforetired(@PathVariable Long userNo, Model model) {
		employeeService.retiredUserInfo(userNo);
		return "redirect:/admin/employees";
	}

}
