class SearchsController < ApplicationController
  def new
  
  end
  
  def create
    puts param[:search][:find]
    result_list = Goal.find_with_index(param[:search][:find])
    redirect :action => "results", :values => result_list
  end

  def results
    puts param[:values]
  end
  
end