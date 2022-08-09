package com.project.member.dao;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.project.member.vo.MemberVO;

/**
 * Member 테이블 Repository
 *
 */
public interface MemberDAO extends JpaRepository<MemberVO, Integer> {
	
	// 모든 데이터 조회
	Page<MemberVO> findAll(Pageable pageable);
	// MemberIdx로 내림차순 조회
	Page<MemberVO> findAllByOrderByMemberIdxDesc(Pageable pageable);
	
	// MemberName으로 like 조회 
	Page<MemberVO> findByMemberNameLike(Pageable pageable, String memberName);
	// MemberIdx로 내림차순 조회
	Page<MemberVO> findByMemberNameLikeOrderByMemberIdxDesc(Pageable pageable, String memberName);

	// MemberIdx 로 단건 조회
	MemberVO findByMemberIdx(int memberIdx);
	// 회원가입여부를 확인하기 위한 MemberId, MemberPw로 단건 조회
	MemberVO findByMemberIdAndMemberPw(String memberId, String memberPw);
	
	// insert
	MemberVO save(MemberVO memberVO);
	
	// MemberIdx로 삭제
	void deleteByMemberIdx(int memberIdx);
}