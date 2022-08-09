package com.project.member.service.impl;

import java.io.File;
import java.util.Optional;
import java.util.UUID;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.common.Constants;
import com.project.member.dao.FileDAO;
import com.project.member.dao.MemberDAO;
import com.project.member.service.MemberService;
import com.project.member.vo.FileVO;
import com.project.member.vo.MemberSVO;
import com.project.member.vo.MemberVO;
import com.project.member.vo.PagingVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private FileDAO fileDAO;
	
	/**
	 * 회원 목록 조회
	 * @param memberVO
	 * @param pageable
	 * @return Page<MemberVO>
	 * @throws Exception
	 */
	@Override
	public Page<MemberVO> selectMemberList(MemberVO memberVO, Pageable pageable) throws Exception {
		// TODO Auto-generated method stub
		Page <MemberVO> resultList = null;
		
		// memberName으로 검색 키워드가 없다면 (모든 조회일 경우)
		if("".equals(retNull(memberVO.getMemberName()))) {
			resultList = memberDAO.findAllByOrderByMemberIdxDesc(pageable);
			
		// memberName으로 검색 키워드가 있다면 memberName으로 like 검색
		}else {
			resultList = memberDAO.findByMemberNameLikeOrderByMemberIdxDesc(pageable, "%"+memberVO.getMemberName()+"%");
		}
		        
		// 조회결과로 해당 멤버의 이미지를 찾는다
		for(int i=0; i<resultList.getContent().size(); i++) {
			int memberIdx = resultList.getContent().get(i).getMemberIdx();
			FileVO fileVO = fileDAO.findByMemberIdx(memberIdx);
			if(fileVO != null) {
				resultList.getContent().get(i).setFileName(fileVO.getFileName());
			}
		}
		
		return resultList;
	}
	
	/**
	 * 회원 조회
	 * @param memberVO
	 * @return MemberVO
	 * @throws Exception
	 */
	@Override
	public MemberVO selectMember(MemberVO memberVO) throws Exception {
		MemberVO resultVO = memberDAO.findByMemberIdx(memberVO.getMemberIdx());
		FileVO fileVO = fileDAO.findByMemberIdx(resultVO.getMemberIdx());
		
		resultVO.setFileName(fileVO.getFileName());
		
		return resultVO;
	}

	/**
	 * 아이디, 패스워드로 회원 조회
	 * @param memberVO
	 * @throws Exception
	 */
	@Override
	public MemberVO selectMemberByIdByPw(MemberVO memberVO) throws Exception {
		MemberVO resultVO = memberDAO.findByMemberIdAndMemberPw(memberVO.getMemberId(), memberVO.getMemberPw());
		return resultVO;
	}
	
	/**
	 * 회원 등록
	 * @param files
	 * @param memberVO
	 * @throws Exception
	 */
	@Override
	public void insertMember(MultipartFile files, MemberVO memberVO) throws Exception {
		memberDAO.save(memberVO);
		
		/**
		 * 파일 업로드
		 * */
		
		// 업로드된 실제 파일명
		String origFileName = files.getOriginalFilename();
		// 업로드된 실제 파일의 확장자
		String origFileExt = origFileName.substring(origFileName.lastIndexOf(".") + 1);
		// DB 및 하드디스크에 저장될 파일명 생성(랜덤값)
        String fileName = UUID.randomUUID().toString() + "." + origFileExt;
        // 하드디스크에 파일이 저장될 경로 -> 상수로 관리한다. => D:/MemberMgmt
        String savePath = Constants.getUploadImagesPath();
        
        // 파일경로가 존재하지 않으면, 파일경로를 생성한다
        if (!new File(savePath).exists()) {
            try{
                new File(savePath).mkdir();
            }
            catch(Exception e){
                e.getStackTrace();
            }
        }
        
        // 풀 경로 -> 파일 + 파일명
        String filePath = savePath + File.separator + fileName;
        // 업로드된 파일을 풀 경로에 복사한다.
        files.transferTo(new File(filePath));

        // 업로드된 파일 정보 file 테이블에 insert
        FileVO fileVO = new FileVO();
        fileVO.setMemberIdx(memberVO.getMemberIdx());
        fileVO.setOrigFileName(origFileName);
        fileVO.setFileName(fileName);
        fileVO.setFilePath(filePath);
        
        fileDAO.save(fileVO);
	}

	/**
	 * 회원 수정
	 * @param files
	 * @param memberVO
	 * @throws Exception
	 */
	@Transactional
	@Override
	public void updateMember(MultipartFile files, MemberVO memberVO) throws Exception {
		Optional<MemberVO> resultVO = memberDAO.findById(memberVO.getMemberIdx());
		 
		if (resultVO.isPresent()) { 
			resultVO.get().setMemberName(memberVO.getMemberName());
			resultVO.get().setMemberPw(memberVO.getMemberPw());
			resultVO.get().setMemberEmail(memberVO.getMemberEmail());
			resultVO.get().setMemberPhoneNumber(memberVO.getMemberPhoneNumber());
			resultVO.get().setMemberAddress(memberVO.getMemberAddress());
			resultVO.get().setMemberAddress2(memberVO.getMemberAddress2());
			
			memberDAO.save(memberVO); 
		}
		
		// 해당 MemberIdx로 File을 찾는다
		FileVO fileVO = fileDAO.findByMemberIdx(memberVO.getMemberIdx());
		// 파일이 존재한다면 삭제
		if(fileVO != null) {
			File file = new File(fileVO.getFilePath());
			file.delete();
		}
		// 파일 테이블에서 해당 멤버의 파일정보 삭제
		fileDAO.deleteByMemberIdx(memberVO.getMemberIdx());
				
		// 업로드된 실제 파일명
		String origFileName = files.getOriginalFilename();
		// 업로드된 실제 파일의 확장자
		String origFileExt = origFileName.substring(origFileName.lastIndexOf(".") + 1);
		// DB 및 하드디스크에 저장될 파일명 생성(랜덤값)
        String fileName = UUID.randomUUID().toString() + "." + origFileExt;
        // 하드디스크에 파일이 저장될 경로 -> 상수로 관리한다. => D:/MemberMgmt
        String savePath = Constants.getUploadImagesPath();
        
        // 파일경로가 존재하지 않으면, 파일경로를 생성한다
        if (!new File(savePath).exists()) {
            try{
                new File(savePath).mkdir();
            }
            catch(Exception e){
                e.getStackTrace();
            }
        }
        
        // 풀 경로 -> 파일 + 파일명
        String filePath = savePath + File.separator + fileName;
        // 업로드된 파일을 풀 경로에 복사한다.
        files.transferTo(new File(filePath));

        // 업로드된 파일 정보 file 테이블에 insert
        fileVO = new FileVO();
        fileVO.setMemberIdx(memberVO.getMemberIdx());
        fileVO.setOrigFileName(origFileName);
        fileVO.setFileName(fileName);
        fileVO.setFilePath(filePath);
        
        fileDAO.save(fileVO);
	}

	/**
	 * 회원 삭제
	 * @param memberSVO
	 * @throws Exception
	 */
	@Transactional
	@Override
	public void deleteMember(MemberSVO memberSVO) throws Exception {
		//선택한 건 만큼 반복을 돌려 삭제한다
		for(int i=0; i<memberSVO.getMemberIdxs().length; i++) {
			int memberIdx = Integer.parseInt(memberSVO.getMemberIdxs()[i]);
			// Member 삭제
			memberDAO.deleteByMemberIdx(memberIdx);		
			
			// 해당 MemberIdx로 File을 찾는다
			FileVO fileVO = fileDAO.findByMemberIdx(memberIdx);
			// 파일이 존재한다면 삭제
			if(fileVO != null) {
				File file = new File(fileVO.getFilePath());
				file.delete();
			}
			// 파일 테이블에서 해당 멤버의 파일정보 삭제
			fileDAO.deleteByMemberIdx(memberIdx);
		}
	}
	
	/**
	 * null값 처리를 위한 메소드
	 * @param str
	 * @return str
	 */
	private String retNull(String str) {
		
		if(str == null || "".equals(str) || "null".equals(str.toLowerCase())) {
			return "";
		}
		
		str = str.trim();
		
		return str;
	}
	
	// 시작 페이지
	int startPage = 0;
	// 총 페이지
	int totalPage = 0;
	// 마지막 페이지
	int endPage = 0;
	// 페이지 수
	int maxPageCnt = 10;
	/**
	 * 페이징 처리를 위한 메소드
	 */
	public PagingVO setPaging(int pageSize, int number) {
		
		PagingVO pagingVO = new PagingVO();
		int totalCount = (int)memberDAO.count();
		
		startPage = ( ( ( (number % maxPageCnt) == 0) ? number-1 : number) / maxPageCnt) * maxPageCnt + 1;
		totalPage = (totalCount / pageSize) + ( ((totalCount % pageSize) == 0) ? 0 : 1);
		endPage = ( (totalPage - startPage) >= maxPageCnt ) ? (startPage + (maxPageCnt-1)) : totalPage;
		
		pagingVO.setStartPage(startPage);
		pagingVO.setTotalPage(totalPage);
		pagingVO.setEndPage(endPage);
		
		return pagingVO;
	}
	
}
