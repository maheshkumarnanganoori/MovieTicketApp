package com.ancile.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.ancile.dao.MovieDAO;
import com.ancile.entity.Movie;

@Service
public class MovieService {
	
	@Autowired
	private MovieDAO movieDao;


	public void insertMovie(MultipartFile movieImg,String moviename,
			String movieCategory,String movieLanguage,String screenName,
			String movieDescription, double price) {
		
		Movie movie = new Movie();
		String fileName = StringUtils.cleanPath(movieImg.getOriginalFilename());
		if(fileName.contains("..")) {
			System.out.println("Not a valid file");
		}
		else {
			try {
				byte[] imageBytes = movieImg.getBytes();
				movie.setMovieImg(imageBytes);
				movie.setMovieImgName(fileName);
				//movie.setMovieImg(Base64.getEncoder().encodeToString(movieImg.getBytes()));
			} catch (IOException e) {
				e.printStackTrace();
			}
			movie.setMoviename(moviename);
			movie.setMovieCategory(movieCategory);
			movie.setMovieLanguage(movieLanguage);
			movie.setScreenName(screenName);
			movie.setMovieDescription(movieDescription);
			movie.setPrice(price);
		}
		movieDao.save(movie);
	}
	
	public List<Movie> viewAllMovies(){
		List<Movie> movies = movieDao.findAll();
		for(Movie movie: movies) {
			byte[] movieImg = movie.getMovieImg();
			if(movieImg!=null) {
				String encodedImage = Base64.getEncoder().encodeToString(movieImg);
				movie.setEncodedImage(encodedImage);
			}
		}
		return movies;
	}
	
	public List<Movie> viewAllByCategory(String category){
		List<Movie> movies = movieDao.findAllByMovieCategory(category);
		for(Movie movie: movies) {
			byte[] movieImg = movie.getMovieImg();
			if(movieImg!=null) {
				String encodedImage = Base64.getEncoder().encodeToString(movieImg);
				movie.setEncodedImage(encodedImage);
			}
		}
		return movies;
	}
	
	public List<Movie> viewAllbyLanguage(String language){
		List<Movie> movies= movieDao.findAllByMovieLanguage(language);
		for(Movie movie:movies) {
			byte[] movieImg = movie.getMovieImg();
			if(movieImg!=null) {
				String encodedImage = Base64.getEncoder().encodeToString(movieImg);
				movie.setEncodedImage(encodedImage);
			}
		}
		return movies;
	}
	
	public List<Long> getIds(){
		List<Movie> ids = movieDao.findAll();
		return ids.stream()
	            .map(Movie::getId)
	            .collect(Collectors.toList());
		
	}
	public List<Movie> viewAllbyId(Long Id){
		
		List<Movie> movies= movieDao.findByid(Id);
		for(Movie movie:movies) {
			byte[] movieImg = movie.getMovieImg();
			if(movieImg!=null) {
				String encodedImage = Base64.getEncoder().encodeToString(movieImg);
				movie.setEncodedImage(encodedImage);
			}
		}
		return movies;
	}

	public List<String> getScreenNames(){
		List<Movie> screenNames  = movieDao.findAll() ;
		List<String> uniqueScreenNames = new ArrayList<>();
		
	   List<String> screenList  = screenNames.stream().map(Movie::getScreenName).collect(Collectors.toList());
	   for(String scName: screenList) {
			if(!uniqueScreenNames.contains(scName)) {
				uniqueScreenNames.add(scName);
			}
		}
	   return uniqueScreenNames;
	}
	public List<Movie> viewAllByScreeName(String screenName){
		List<Movie> movies = movieDao.findByScreenName(screenName);
		for(Movie movie:movies) {
			byte[] movieImg = movie.getMovieImg();
			if(movieImg!=null) {
				String encodedImage = Base64.getEncoder().encodeToString(movieImg);
				movie.setEncodedImage(encodedImage);
			}
		}
		return movies;
		
	}
	

}
