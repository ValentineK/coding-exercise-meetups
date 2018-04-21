class GroupsController < ApplicationController

  LOCATION = 'Munich'

  def search
    @search_text = permitted_params[:text]
    unless @search_text.nil?
      @groups = Meetup::SearchGroupsService.new({
        text: @search_text,
        location: LOCATION
      }).run!.take(10)
    end
  end

  private

  def permitted_params
    params.permit(:text)
  end

end
