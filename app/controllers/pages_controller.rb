class PagesController < ApplicationController
  def home
    if signed_in?
      @title = "Dashboard"
      range = (Date.today-2..Date.today+3)
      @events = {}
      range.each { |d| @events.store(d, { :bd => [] }) }
      birthdays = User.birthdays_around(range).each { |bd| @events[bd.next_birthday][:bd] << bd}
    else
      redirect_to signin_path
    end
  end

end
