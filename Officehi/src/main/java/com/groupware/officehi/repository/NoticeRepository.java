package com.groupware.officehi.repository;

import java.util.List;
import java.util.Optional;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.groupware.officehi.dto.NoticeDTO;

/**
 * @author 정유진
 * @editDate 23.12.18 ~ 23.12.19
 * 
 * @author 이승준
 * 검색 기능 추가 23.12.24 ~ 23.12.26
 */

@Repository
public interface NoticeRepository {
	
	void insert(NoticeDTO notice);
	
	List<NoticeDTO> findAll();
	
	Optional<NoticeDTO> findByNoticeNo(Long noticeNo);
	
	/* 검색 기능 */
	List<NoticeDTO> searchTitle(@Param("title") String title);
	List<NoticeDTO> searchContent(@Param("content") String content);
	List<NoticeDTO> searchNoticeNo(@Param("noticeNo") Long noticeNo);
	
}