package com.ancile.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.ancile.entity.Movie;

@Repository
public interface MovieDAO extends JpaRepository<Movie, Long> {

	List<Movie> findAllByMovieLanguage(String movieLanguage);
	List<Movie> findAllByMovieCategory(String movieCategory);
	List<Movie> findByMoviename(String movieName);
	List<Movie> findByScreenName(String screeName);
	List<Movie> findByPrice(double price);
	List<Movie> findByid(Long Id);

}
