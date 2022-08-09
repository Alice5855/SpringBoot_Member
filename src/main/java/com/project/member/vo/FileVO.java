package com.project.member.vo;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@SequenceGenerator(
        name="FILE_SEQ_GEN",
        sequenceName="FILE_SEQ",
        initialValue=1,
        allocationSize=1
        )
@Entity
@Table(name="memberFile")
public class FileVO {
	
	@Id
	@GeneratedValue(
            strategy=GenerationType.SEQUENCE,
            generator="FILE_SEQ_GEN"        
            )
	private int fileIdx;
	private int memberIdx;
    private String origFileName;
    private String fileName;
    private String filePath;
    
	public int getFileIdx() {
		return fileIdx;
	}
	public void setFileIdx(int fileIdx) {
		this.fileIdx = fileIdx;
	}
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public String getOrigFileName() {
		return origFileName;
	}
	public void setOrigFileName(String origFileName) {
		this.origFileName = origFileName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Override
	public String toString() {
		return "FileVO [fileIdx=" + fileIdx + ", memberIdx=" + memberIdx + ", origFileName=" + origFileName
				+ ", fileName=" + fileName + ", filePath=" + filePath + "]";
	}
    
}