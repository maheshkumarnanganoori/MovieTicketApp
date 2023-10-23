package com.ancile.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.ancile.entity.Movie;
import com.ancile.service.MovieService;

@Controller
public class MovieController {

	@Autowired
	private MovieService movieService;
	
	@GetMapping(value={"/"})
	public ModelAndView home() {
		ModelAndView mv = new ModelAndView();
		List<Movie> responseList = movieService.viewAllMovies();
		Collections.reverse(responseList);
		mv.addObject("responseList",responseList);
		System.out.println("GET");
		mv.setViewName("home");
		return mv;
	}
	
	@GetMapping(value={"/addmovie"})
	public ModelAndView addMovie() {
		ModelAndView mv = new ModelAndView();
		System.out.println("Get");
		mv.setViewName("addMovie");
		return mv;
	}
	
	@PostMapping("/insertmovie")
	public RedirectView addMovie(@RequestParam("movieImg") MultipartFile movieImg,
			@RequestParam("moviename") String moviename, 
			@RequestParam("movieCategory") String movieCategory,
			@RequestParam("movieLanguage") String movieLanguage,
			@RequestParam("screenName")String screenName,
			@RequestParam("movieDescription")String movieDescription,
			@RequestParam("price")double price) {

		System.out.println("Insert");
		movieService.insertMovie(movieImg, moviename, movieCategory, 
				movieLanguage, screenName, movieDescription, price);
		return new RedirectView("/");
	}
	
	
	@GetMapping("/viewallmovies")
	public ModelAndView viewAll() {
		ModelAndView mv = new ModelAndView();
		List<Movie> responseList = movieService.viewAllMovies();
		Collections.reverse(responseList);
		mv.addObject("responseList",responseList);
		mv.addObject("responseList",responseList);
		mv.setViewName("allmovies");
		return mv;
	}
	
	@GetMapping("/viewmoviebycategory")
	public String viewAllbyCategory(@RequestParam(name="category", required= false)String category, Model model){
		model.addAttribute("category",category);
		if(category == null) {
			category = "Action";
		}
		List<Movie>  movies = movieService.viewAllByCategory(category);
		model.addAttribute("movies",movies);
		return "byCategory";
	}
	
	@GetMapping("/viewmoviesbylanguage")
	public String viewbylanguage(@RequestParam(name="language", required= false) String language, Model model){
		model.addAttribute("language",language);
		if(language == null) {
			language = "Hindi";
		}
		List<Movie> movies = movieService.viewAllbyLanguage(language);
		model.addAttribute("movies", movies);
		return "byLanguage";
	}
	
	@GetMapping("/viewmoviebyscreename")
	public String viewAllbyScreeName(@RequestParam (name="screenName", required = false)String screenName, Model model){
		List<String> movieScreenNames = movieService.getScreenNames();
		model.addAttribute("screenNames",movieScreenNames);
		model.addAttribute("scName", screenName);
		if(screenName == null) {
			screenName = "AMC";
		}
		List<Movie> movies = movieService.viewAllByScreeName(screenName);
		model.addAttribute("movies", movies);
		return "byScreenName";
	}
	
	@GetMapping("/viewmoviebyid")
	public String viewAllbyId(@RequestParam(name="id", required=false) Long id, Model model){
		
		List<Long> movieId = movieService.getIds();
		model.addAttribute("movieIds", movieId);
		
		if(id == null) {
			id = 1L;
		}
		model.addAttribute("id",id);
		List<Movie> movies = movieService.viewAllbyId(id);
		model.addAttribute("movies", movies);
		return "byId";
	}
	
	@GetMapping("/contactus")
	public String contactus() {
		return "contactus";
	}
}
