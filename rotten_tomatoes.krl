ruleset rotten_tomatoes {
	meta {
		name "CS 462 Lab 4: Rotten Tomatoes"
		description <<
		  Allows a user to search rotten tomatoes for information about a movie.
		>>
		author "Mike Curtis"
		logging off
		use module a169x701 alias CloudRain
		use module a41x186  alias SquareTag
	}
	dispatch {
	}
	global {
		search_movies = function(query) {
			http:get("http://api.rottentomatoes.com/api/public/v1.0/movies.json",
						{"apikey": "cmcxzxm2vjhj5skwk2b27nbg",
						  "q": query,
						  "page_limit": 1});
		};
	}
  
	rule show_form is active {
		select when web cloudAppSelected
		pre {
			form = <<
			<div style="margin-left:36px">
			<h3>Movie search:</h3>
			<form id="lab4_form" onsubmit="return false">
				<input type="text" name="movieTitle" /><br />
				<input type="submit" value="Submit" />
			</form>
			</div>
			>>;
		}
		{
			SquareTag:inject_styling();
			CloudRain:createLoadPanel("CS 462 Lab 4: Rotten Tomatoes", {}, form);
			watch("#lab4_form", "submit");
		}
		fired {
			last;
		}
	}
	
	rule respond_submit is active {
		select when web submit "#lab4_form"
		pre {
			query = event:attr("movieTitle")
			search_data = search_movies(query)
		}
		{
			prepend("#cloudAppPanel-b505198x3-content","<b>#{search_data}</b>");
		}
	} 
}