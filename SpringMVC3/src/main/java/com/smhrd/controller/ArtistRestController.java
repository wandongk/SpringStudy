package com.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smhrd.db.ArtistMapper;
import com.smhrd.model.ArtistVO;

@RestController
public class ArtistRestController {
	@Autowired
	private ArtistMapper mapper;
	
	
	@RequestMapping("/artist")
	public List<ArtistVO> artist(){
		List<ArtistVO> list = mapper.artist();
		return list;
	}
}
