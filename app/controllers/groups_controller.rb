class GroupsController < ApplicationController

  LOCATION = 'Munich'

  def search
    @search_text = permitted_params[:text]
    if @search_text.present?
      @groups = Meetup::SearchGroupsService.new({
        text: @search_text,
        location: LOCATION
      }).search
    end
  end

  private

  def permitted_params
    params.permit(:text)
  end

end
