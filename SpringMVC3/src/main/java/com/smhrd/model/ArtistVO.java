package com.smhrd.model;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArtistVO {

	private Date collectDate;
	private String channel;
	private String artist;
	private String keyword;
	private long keywordCnt;
	
}
