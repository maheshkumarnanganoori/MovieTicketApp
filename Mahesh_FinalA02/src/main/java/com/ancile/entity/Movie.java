package com.ancile.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;
import jakarta.persistence.SequenceGenerator;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name="movies")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Movie {
	
	@Id
	@SequenceGenerator(name="seq_gen", sequenceName= "seq_gen", initialValue = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_gen")
	private Long Id;
	private String moviename;
	private String movieCategory;
	private String movieLanguage;
	private String screenName;
	private String movieDescription;
	private double price;
	
	@Lob
	@Column(columnDefinition = "BLOB")
	private byte[] movieImg;
	
	private String movieImgName;
	
	private String encodedImage;
}
