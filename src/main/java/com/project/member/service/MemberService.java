package com.project.member.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import com.project.member.vo.MemberSVO;
import com.project.member.vo.MemberVO;
import com.project.member.vo.PagingVO;

public interface MemberService {
	
	/**
	 * 회원 목록 조회
	 * @param memberVO
	 * @param pageable
	 * @return Page<MemberVO>
	 * @throws Exception
	 */
	Page<MemberVO> selectMemberList(MemberVO memberVO, Pageable pageable) throws Exception;
	
	/**
	 * 페이징 처리를 위한 메소드
	 * @param pageSize
	 * @param number
	 * @return PagingVO
	 * @throws Exception
	 */
	public PagingVO setPaging(int pageSize, int number) throws Exception;
	
	/**
	 * 회원 조회
	 * @param memberVO
	 * @return MemberVO
	 * @throws Exception
	 */
	MemberVO selectMember(MemberVO memberVO) throws Exception;
	
	/**
	 * 아이디, 패스워드로 회원 조회
	 * @param memberVO
	 * @throws Exception
	 */
	MemberVO selectMemberByIdByPw(MemberVO memberVO) throws Exception;
	
	/**
	 * 회원 등록
	 * @param files
	 * @param memberVO
	 * @throws Exception
	 */
	void insertMember(MultipartFile files, MemberVO memberVO) throws Exception;
	
	/**
	 * 회원 수정
	 * @param files
	 * @param memberVO
	 * @throws Exception
	 */
	void updateMember(MultipartFile files, MemberVO memberVO) throws Exception;
	
	/**
	 * 회원 삭제
	 * @param memberSVO
	 * @throws Exception
	 */
	void deleteMember(MemberSVO memberSVO) throws Exception;
}
