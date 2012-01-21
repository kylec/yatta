class SearchsController < ApplicationController
  def new
  
  end
  
  def create
    puts params[:search][:find]
    puts 'test'
    @result_list = Goal.with_query(params[:search][:find])
    @result_list.each do |result|
      puts result.title
      puts result.description
    end
    
  end

  
end