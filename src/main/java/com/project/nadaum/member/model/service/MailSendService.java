package com.project.nadaum.member.model.service;

import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;

@Service
public class MailSendService {

	@Autowired
	private JavaMailSenderImpl mailSender;
	
	private int size;
	
	private String getKey(int size) {
		this.size = size;
		return getAuthCode();
	}
	
	private String getAuthCode() {
		Random random = new Random();
		StringBuffer buffer = new StringBuffer();
		int num = 0;
		
		while(buffer.length() < size) {
			num = random.nextInt(10);
			buffer.append(num);
		}
		
		return buffer.toString();
	}
	
	public String sendAuthMail(String email) {
		String authKey = getKey(6);
		
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		String mailContent = "<h1>회원가입 이메일 인증</h1><br/><p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>"
						   + "<a href='http://localhost:9090/nadaum/member/memberConfirm.do?email=" + email
						   + "&authKey=" + authKey + "'>이메일 인증 확인</a>";
		
		try {
			mimeMessage.setSubject("회원가입 이메일 인증 ", "utf-8");
			mimeMessage.setText(mailContent, "utf-8", "html");
			mimeMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			mailSender.send(mimeMessage);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
				
		return authKey;
	}
	
}
