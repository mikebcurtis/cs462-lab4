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
    }
	fired {
		last;
	}
  }
}