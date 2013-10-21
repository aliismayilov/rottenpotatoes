module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

  def checked_rating?(rating)
    if params[:ratings]
      params[:ratings].keys.include? rating
    else
      true
    end
  end
end
