package com.smhrd.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpServerErrorException;

import com.smhrd.db.BoardMapper;
import com.smhrd.model.BoardVO;
import com.smhrd.model.SearchCriteria;


@Controller // 기능이 정의 되어있음
public class BoardController {

	@Autowired // 중요*****************
	private BoardMapper mapper;
	
	
	
	
	
	
	@RequestMapping("/") // "/"로 요청이 들어왔을 때 board 메소드를 실행
	public String board(Model model) {
		List<BoardVO> list = mapper.boardList();

		model.addAttribute("list", list);

		return "board";
	}             

	
	
	
	////////////////////// 게시물 등록 //////////////////////////
	@GetMapping("/register") // -->> post 전송방식 일때만 메소드 실행
	public String register(Model model) {
		return "register";
	}

	// 글쓰기 기능을 하는 메소드
	@PostMapping("/register") // -->> get 전송방식 일때만 메소드 실행
	public String register(BoardVO vo) {

		System.out.println(vo);

		mapper.boardRegister(vo);

		return "redirect:/";
	}
	
	
	
	//////////////////////// 게시물 한개에 대한 정보 ///////////////////////
	
	

	@GetMapping("/boardContent/{idx}")
	public String boardContent(@PathVariable("idx") int idx, Model model) {

		BoardVO list = mapper.boardContent(idx);

		model.addAttribute("list", list);

		return "boardContent";
	}
	
	
	
	
	
	///////////////////////// 게시물 삭제 ///////////////////////////
	
	@GetMapping("/delete/{idx}")
	public String delete(@PathVariable("idx") int idx) {

		mapper.delete(idx);

		return "redirect:/";
	}
	
	
	
	//////////////////////////// 게시물 수정 /////////////////////////
	
	
	@GetMapping("/edit/{idx}")
	public String edit(@PathVariable("idx") int idx, Model model) {

		BoardVO list = mapper.boardContent(idx);

		model.addAttribute("list", list);

		return "edit";
	}
	
	@PostMapping("/edit/{idx}")
	public String edit(@PathVariable("idx") int idx, BoardVO vo) {

		mapper.edit(vo);
		
		return "redirect:/boardContent/"+idx;
	}
	

}
