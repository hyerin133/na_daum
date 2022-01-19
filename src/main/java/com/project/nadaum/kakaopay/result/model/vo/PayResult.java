package com.project.nadaum.kakaopay.result.model.vo;

import java.io.Serializable;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PayResult implements Serializable{

	private static final long serialVersionUID = -2430097147429432602L;
	
	private String partnerOrderId;
	private String partnerUserId;
	private String tid;
	private String cid;
	private String sid;
	private String itemName;
	private int quantity;
	private int totalAmount;
	private String CARDS;
	private String pgToken;
	private String createdAt;
	
	enum CARDS{
		TOSS, KAKAO, SHINHAN, KB, HANA, NH, HYUNDAI, SAMSUNG, CITI  
	}
}