package com.smhrd.db;

import java.util.List;

import com.smhrd.model.ArtistVO;

// import org.apache.ibatis.annotations.Mapper;

// @Mapper --> Spring 버전이 업그레이드 되면서 생략 가능해졌음.
public interface ArtistMapper {

	List<ArtistVO> artist();
	
}
